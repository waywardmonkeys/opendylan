Module:   dfmc-common
Synopsis: compilation-pass definition and creation
Author:   Paul Haahr
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

//// public interface

define open generic run-compilation-passes (code) => code;
  // method definition in management module


//// <compilation-pass> class

define class <compilation-pass> (<named-object>)
  // TODO: required keyword name:;
  slot pass-function :: <function>, required-init-keyword: function:;
  slot visiting-policy :: <symbol> = #"top-level-forms",
    init-keyword: visit:;

  slot before = #[], init-keyword: before:;
  slot after = #[], init-keyword: after:;
  slot trigger = #[], init-keyword: trigger:;
  slot triggered-by = #[], init-keyword: triggered-by:;
  slot include-back-ends = #[], init-keyword: back-end:;
  slot exclude-back-ends = #[], init-keyword: exclude-back-end:;

  slot disabled? = #f, init-keyword: disabled?:;
  slot print-before? = #f, init-keyword: print-before?:;
  slot print-after? = #f, init-keyword: print-after?:;
  slot check-before? = #f, init-keyword: check-before?:;
  slot check-after? = #f, init-keyword: check-after?:;

  slot all-triggered-passes;        // trigger + other passes' triggered-by
  slot cached-position;                // position in the ordered list of passes
end class <compilation-pass>;

define method make
    (class == <compilation-pass>, #rest keys, #key print?, check?, mandatory?)
 => (pass :: <compilation-pass>)
  ignore(mandatory?);
  if (print?)
    keys := concatenate(#[print-before?:, #t, print-after?:, #t], keys);
  end if;
  if (check?)
    keys := concatenate(#[check-before?:, #t, check-after?:, #t], keys);
  end if;
  apply(next-method, class, keys)
end method make;

define method as
    (class == <compilation-pass>, name :: <symbol>)
 => (pass :: <compilation-pass>)
  lookup-pass(name)
end method as;

define method as
    (class == <compilation-pass>, object :: <object>)
 => (pass :: <compilation-pass>)
  as(<compilation-pass>, as(<symbol>, object))
end method as;


//// pass definition

define class <passes> (<object>)
  slot table = make(<table>);
  slot valid? = #f;                // invalidated on modification
  slot cached-ordering = #();
end class <passes>;

define constant *passes* = make(<passes>);

define method define-compilation-pass!
    (name, #rest keys, #key, #all-keys) => ();
  let pass
    = apply(make, <compilation-pass>, name: name, keys);
  *passes*.valid? := #f;
  *passes*.table[name] := pass;
  values()
end method define-compilation-pass!;

define method lookup-pass (name :: <symbol>)
  *passes*.table[name]
end method lookup-pass;


//// computing pass ordering

define method compute-ordering! (passes :: <passes>)
  compute-all-triggers!(passes);
  passes.cached-ordering
    := map(curry(element, passes.table),
           topological-sort
             (passes.table.key-sequence,
              all-ordering-constraints(passes),
              tie-breaker-rule));
  for (pass in passes.cached-ordering, pos from 0)
    pass.pass-position := pos;
  end for;
  passes.valid? := #t;
  passes.cached-ordering
end method compute-ordering!;

define method tie-breaker-rule (minimal-elements, result-so-far)
  // Completely arbitrary.  Would something else be better?
  // Perhaps pick the one with the lowest optimization level?
  // Maybe do something with triggers?
  /* signal("pass ordering tie among %s", minimal-elements); */
  first(minimal-elements)
end method tie-breaker-rule;

define method all-ordering-constraints (passes :: <passes>)
  let constraints :: <list> = #();
  for (pass in passes.table)
    for (before in pass.before)
      constraints := pair(list(pass.name, before), constraints);
    end for;
    for (after in pass.after)
      constraints := pair(list(after, pass.name), constraints);
    end for;
  end for;
  constraints
end method all-ordering-constraints;

define method pass-ordering (passes :: <passes>)
  unless (passes.valid?)
    compute-ordering!(passes)
  end unless;
  passes.cached-ordering
end method pass-ordering;

define method pass-position (pass :: <compilation-pass>)
  unless (*passes*.valid?)
    compute-ordering!(*passes*)
  end unless;
  pass.cached-position
end method pass-position;

define method pass-position-setter (new-value, pass :: <compilation-pass>)
  pass.cached-position := new-value
end method pass-position-setter;

define method compute-all-triggers! (passes :: <passes>)
  local method name->pass (name :: <symbol>)
          let pass = element(passes.table, name, default: #f);
          unless (pass)
            error("reference to undefined pass %s", name)
          end unless;
          pass
        end method name->pass;
  for (pass in passes.table)
    pass.all-triggered-passes
      := map-as(<stretchy-vector>, name->pass, pass.trigger);
  end for;
  for (pass in passes.table)
    for (triggering-pass in pass.triggered-by)
      add!(name->pass(triggering-pass).all-triggered-passes, pass)
    end for;
  end for;
end method compute-all-triggers!;


//// queueing

// a priority queue of passes
//
// A heap would probably be the best data structure here, but that
// doesn't easily support the policy of "add if not yet a member"

define class <compilation-queue> (<object>)
  slot remaining :: <list> = #();
end class <compilation-queue>;

define method pop-pass! (queue :: <compilation-queue>)
 => pass :: type-union(<compilation-pass>, singleton(#f));
  if (empty?(queue.remaining))
    #f
  else
    block ()
      queue.remaining.head
    afterwards
      queue.remaining := queue.remaining.tail
    end block
  end if
end method pop-pass!;

define method push-pass!
    (queue :: <compilation-queue>, pass :: <compilation-pass>) => ();
  unless (*passes*.valid?)
    compute-ordering!(*passes*);
  end unless;
  if (pass-enabled?(pass))
    local method add (list)
            case
              empty?(list) =>
                pair(pass, #());
              pass.pass-position > list.head.pass-position =>
                list.tail := add(list.tail);
                list;
              pass.pass-position < list.head.pass-position =>
                pair(pass, list);
              pass.pass-position = list.head.pass-position =>
                assert(pass == list.head);
                list
            end case
          end method add;
    queue.remaining := add(queue.remaining);
  end if;
  values();
end method push-pass!;

define method pass-enabled? (pass :: <compilation-pass>)
 => (enabled? :: <boolean>);
  begin
    let include = pass.include-back-ends;
    empty?(include) | member?(current-back-end(), include)
  end
  & ~member?(current-back-end(), pass.exclude-back-ends)
  & ~pass.disabled?
end method pass-enabled?;
