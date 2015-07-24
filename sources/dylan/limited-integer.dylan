Module:    internal
Synopsis:  Limited integer types
Author:    Keith Playford
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

//// The limited integer type

// BOOTED: define ... class <limited-integer> ... end;

define method limited
    (class == <integer>, #key min :: <integer> = #f, max :: <integer> = #f)
 => (result :: <type>)
  if (min | max)
    // Could check for min > max and return a dignified empty type but
    // I'm not sure that's worthwhile.
    let type :: <limited-integer> = make(<limited-integer>, min: min, max: max);
    unless (instance?-iep(type))
      instance?-iep(type) := simple-method-iep(instance?-function(type));
    end unless;
    type
  else
    <integer>
  end
end method;

define inline method limits (limint :: <limited-integer>) => (result == <integer>)
  <integer>
end method;

//// Instance? relationships

define function min+max-limited-integer-instance?-function
    (i, limint :: <limited-integer>) => (result :: <boolean>)
  if (instance?(i, <integer>))
    // optimize because of the property of negative signed integers
    // being greater than all positive signed integers
    //   min <= i & i <= max
    // ->
    //   unsigned(i - min)  <= unsigned(max - min)
    // For min: -128, max: 128
    //   unsigned(i - -128) <= unsigned(128 - -128)
    //   unsigned(i + 128)  <= unsigned(256)
    let min = interpret-integer-as-machine-word(limint.limited-integer-min);
    let max = interpret-integer-as-machine-word(limint.limited-integer-max);
    let i = machine-word-subtract(interpret-integer-as-machine-word(i), min);
    let bound = machine-word-subtract(max, min);
    machine-word-unsigned-not-greater-than?(i, bound)
  else
    #f
  end if
end function;

define function min-only-limited-integer-instance?-function
    (i, limint :: <limited-integer>) => (result :: <boolean>)
  if (instance?(i, <integer>))
    // We do this directly via primitives rather than via \<= because
    // the compiler doesn't know for sure that limited-integer-min is
    // an integer here, so it introduces overhead.
    // There's no need to untag integers for this comparison.
    let i = interpret-integer-as-machine-word(i);
    let min = interpret-integer-as-machine-word(limint.limited-integer-min);
    machine-word-not-greater-than?(min, i)
  else
    #f
  end if
end function;

define function max-only-limited-integer-instance?-function
    (i, limint :: <limited-integer>) => (result :: <boolean>)
  if (instance?(i, <integer>))
    // We do this directly via primitives rather than via \<= because
    // the compiler doesn't know for sure that limited-integer-max is
    // an integer here, so it introduces overhead.
    // There's no need to untag integers for this comparison.
    let i = interpret-integer-as-machine-word(i);
    let max = interpret-integer-as-machine-word(limint.limited-integer-max);
    machine-word-not-greater-than?(i, max)
  else
    #f
  end if
end function;

define method instance?-function (t :: <limited-integer>) => (m :: <method>)
  if (t.limited-integer-max)
    if (t.limited-integer-min)
      min+max-limited-integer-instance?-function
    else
      max-only-limited-integer-instance?-function
    end if
  else
    min-only-limited-integer-instance?-function
  end if
end method;


//// Subtype? relationships

// With other limited integer types

define method subtype?
    (limint1 :: <limited-integer>, limint2 :: <limited-integer>)
 => (result :: <boolean>)
  local method satisifies-bound
      (value :: false-or(<integer>), bound :: false-or(<integer>), satisfied?)
    if (~bound)
      #t
    else
      if (value) satisfied?(value, bound) else #f end
    end
  end method;
  satisifies-bound(limint1.limited-integer-min, limint2.limited-integer-min, \>=)
    & satisifies-bound(limint1.limited-integer-max, limint2.limited-integer-max, \<=)
end method;

define method subjunctive-subtype? (limint1 :: <limited-integer>, limint2 :: <limited-integer>,
                                    scu :: <subjunctive-class-universe>)
 => (result :: <boolean>)
  subtype?(limint1, limint2)
end method;


// With other integer types - should consider different integer class
// precisions.

define method subtype?
    (class :: <class>, limint :: <limited-integer>) => (result == #f)
  #f
end method;

define method subtype?
    (limint :: <limited-integer>, class :: <class>) => (result :: <boolean>)
  subclass?(limits(limint), class)
end method;

define method subjunctive-subtype? (class :: <class>, limint :: <limited-integer>,
                                    scu :: <subjunctive-class-universe>)
 => (result == #f)
  #f
end method;

define method subjunctive-subtype? (limint :: <limited-integer>, class :: <class>,
                                    scu :: <subjunctive-class-universe>)
 => (result :: <boolean>)
  subjunctive-subtype?(limits(limint), class, scu)
end method;

//// Disjointness

define method disjoint-types-1? (t1 :: <limited-integer>, t2 :: <limited-integer>,
                                 scu :: <subjunctive-class-universe>,
                                 dep :: <false-or-dependent-generic-function>)
 => (well? :: <boolean>)
  let min1 = t1.limited-integer-min;
  let max1 = t1.limited-integer-max;
  let min2 = t2.limited-integer-min;
  let max2 = t2.limited-integer-max;
  ((// t1 lies entirely below t2:
      max1 & min2 & max1 < min2
       )
     |
     (// t1 lies entirely above t2:
      min1 & max2 & max2 < min1
        )
     )
end method;


///// Potential instance relationships

define method has-instances? (class :: <class>, limint :: <limited-integer>,
                              scu :: <subjunctive-class-universe>)
 => (some? :: <boolean>, all? == #f)
  values(subjunctive-subtype?(<integer>, class, scu) | subjunctive-subtype?(class, <integer>, scu), #f)
end method;

// define method disjointness-has-instances? (class :: <class>, limint :: <limited-integer>,
//                                            scu :: <subjunctive-class-universe>)
//  => (some? :: <boolean>, all? == #f)
//   values(subjunctive-subtype?(<integer>, class, scu) | subjunctive-subtype?(class, <integer>, scu), #f)
// end method;
