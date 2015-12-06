Module:       dylan-user
Synopsis:     Common Dylan library definition
Author:       Andy Armstrong
Version:      $HostName$
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define library common-dylan
  use dylan,
    export: { dylan,
              finalization,
              threads };
  export
    common-dylan,
    common-extensions,
    streams-protocol,
    locators-protocol,
    machine-words,
    simple-random,
    simple-profiling,
    simple-timers,
    simple-format,
    simple-io,
    byte-vector,
    transcendentals;
end library common-dylan;

define module simple-profiling
  create \timing;

  create \profiling,
         <profiling-state>,
         start-profiling,
         start-profiling-type,
         stop-profiling,
         stop-profiling-type,
         profiling-type-result;
end module simple-profiling;

define module simple-timers
  create <profiling-timer>,
         timer-start,
         timer-stop,
         timer-accumulated-time,
         timer-running?;
end module simple-timers;

define module byte-vector
  use dylan-extensions,
    export: { <byte> };
  create <byte-vector>,
         byte-vector-fill,
         byte-vector-ref,
         byte-vector-ref-setter,
         copy-bytes,
         byte-storage-address,
         byte-storage-offset-address,
         hexstring, from-hexstring
end module byte-vector;

define module common-extensions
  use dylan-extensions,
    export: { <bottom>,
              <format-string-condition>,
                <stack-overflow-error>,
                <arithmetic-error>,
                  <division-by-zero-error>,
                  <arithmetic-domain-error>,
                  <arithmetic-overflow-error>,
                  <arithmetic-underflow-error>,
              <stretchy-object-vector>,
              <object-deque>,
              <simple-condition>,
              <stretchy-sequence>,
              <string-table>,
              false-or,
              ignorable,
              ignore,
              \iterate,
              one-of,
              remove-all-keys!,
              rest,
              subclass,
              \when,
              register-application-exit-function };
  use simple-debugging,
    export: { \assert,
              \debug-assert,
              debug-message };
  use simple-profiling,
    export: { \profiling,
              profiling-type-result };
  use byte-vector,
    export: { <byte-vector>,
              byte-storage-address,
              byte-storage-offset-address};
  create <closable-object>,
         <stream>,
         close,
         integer-length,
         <float-classification>,
         classify-float,
         decode-float,
         scale-float,
         float-radix,
         float-digits,
         float-precision,
         $single-float-epsilon,
         $double-float-epsilon,
         $minimum-single-float-exponent,
         $maximum-single-float-exponent,
         $minimum-double-float-exponent,
         $maximum-double-float-exponent,
         $unsupplied, unsupplied, unsupplied?, supplied?,
         $unfound,    unfound,    unfound?,    found?,
         true?, false?,
         concatenate!,
         condition-to-string,
         difference,
         position,
         split,
         join,
         fill-table!,
         find-element,
         find-value,
         float-to-string,
         integer-to-string,
         number-to-string,
         string-to-integer,
         machine-word-to-string,
         string-to-machine-word,
         \table-definer,
         application-name,
         application-filename,
         application-arguments,
         tokenize-command-line,
         exit-application;
end module common-extensions;

define module common-dylan
  use dylan, export: all;
  use common-extensions, export: all;
end module common-dylan;

define module simple-format
  create format-out,
         format-to-string;
end module simple-format;

define module simple-io
  use simple-format, export: all;
end module simple-io;

define module simple-random
  create <random>,
         random;
end module simple-random;

define module locators-protocol
  create <locator>;
  create supports-open-locator?,
         open-locator,
         supports-list-locator?,
         list-locator;

  create <server-locator>,
         <physical-locator>;
end module locators-protocol;

define module streams-protocol
  use common-extensions,
    import: { <stream>, close },
    export: all;
  // Conditions
  create <stream-error>,
           stream-error-stream,
         <end-of-stream-error>,
           <incomplete-read-error>,
             stream-error-sequence,
             stream-error-count,
           <incomplete-write-error>,
             stream-error-count;
  // Opening streams
  create open-file-stream;
  // Reading from streams
  create read-element,
         unread-element,
         peek,
         read,
         read-into!,
         discard-input,
         stream-input-available?,
         stream-contents,
         stream-contents-as;
  // Writing to streams
  create write-element,
         write,
         force-output,
         wait-for-io-completion,
         synchronize-output,
         discard-output;
  // Querying streams
  create stream-open?,
         stream-element-type,
         stream-at-end?,
         stream-size;
  // Positioning streams
  create <positionable-stream>,
         stream-position,
         stream-position-setter,
         adjust-stream-position;
  // Wrapper streams
  create outer-stream,
         outer-stream-setter;
end module streams-protocol;

define module transcendentals
  use dylan;
  use dylan-primitives;
  export $single-pi, $double-pi, // $extended-pi,
         $single-e,  $double-e,  // $extended-e,
         sqrt,
         isqrt,
         log,
         exp,
         logn,
         ilog2,
         sin,
         cos,
         tan,
         sincos,
         asin,
         acos,
         atan,
         atan2,
         sinh,
         cosh,
         tanh,
         asinh,
         acosh,
         atanh,
         hypot;
end module transcendentals;

define module machine-words
  use dylan-extensions,
    export: {<machine-word>,
             $machine-word-size,
             $maximum-signed-machine-word,
             $minimum-signed-machine-word,
             $maximum-unsigned-machine-word,
             $minimum-unsigned-machine-word,
             as-unsigned };
  create %logior,
         %logxor,
         %logand,
         %lognot,
         %logbit?,
         %count-low-zeros,
         %count-high-zeros,
         \%+,
         \%-,
         \%*,
         %floor/,
         %ceiling/,
         %round/,
         %truncate/,
         %divide,
         %negative,
         %abs,
         %shift-left,
         %shift-right;
  create so%+,
         so%-,
         so%*,
         so%negative,
         so%abs,
         so%shift-left;
  create d%floor/,
         d%ceiling/,
         d%round/,
         d%truncate/,
         d%divide;
  create u%+,
         u%-,
         u%*,
         u%divide,
         u%rotate-left,
         u%rotate-right,
         u%shift-left,
         u%shift-right,
         u%<;
  create ud%divide,
         ud%shift-left,
         ud%shift-right;
end module machine-words;

define module common-dylan-internals
  use common-dylan;
  use dylan-extensions;
  use dylan-direct-c-ffi;
  use machine-word-lowlevel;
  use machine-words;
  use threads;
  use transcendentals;
  use byte-vector;
  use streams-protocol;
  use locators-protocol;
  use simple-random;
  use simple-profiling;
  use simple-timers;
  use simple-format;
end module common-dylan-internals;

define module streams-internals
  use streams-protocol;
  use common-dylan;
  use locators-protocol;
  use dylan-extensions;
  use dylan-direct-c-ffi;
  use byte-vector;
  use machine-words;
  use threads;

  // Basic stream classes
  export <typed-stream>,
         <general-typed-stream>,
         <byte-element-stream>,
         <byte-char-element-stream>;

  // Efficient querying direction
  export readable?, writable?, closed?, read-only?, write-only?, read-write?;

  // Conditions
  export end-of-stream-value,
         stream-error-requested-position,
         stream-error-size-of-stream,
         ensure-readable, ensure-writable;

  // Querying streams
  export stream-direction, stream-console?;

  // Positionable streams
  export current-position, current-position-setter,
         initial-position,
         final-position;

  // Buffers and buffered streams
  export *multi-buffer-bytes*,
         <power-of-two-buffer>,
         <single-buffered-stream>,
         <double-buffered-stream>,
         make-<power-of-two-buffer>,
         buffer-off-page-bits,
         buffer-on-page-bits,
         buffer-owning-stream, buffer-owning-stream-setter,
         buffer-use-count, buffer-use-count-setter,
         ensure-input-buffer, ensure-output-buffer,
         coerce-to-element,
         coerce-from-element,
         coerce-to-sequence,
         coerce-from-sequence,
         round-to-power-of-two,
         stream-input-buffer,  stream-input-buffer-setter,
         stream-output-buffer, stream-output-buffer-setter,
         stream-shared-buffer, stream-shared-buffer-setter,
         actual-stream-input-buffer, actual-stream-input-buffer-setter,
         actual-stream-output-buffer, actual-stream-output-buffer-setter;

  // File streams
  export <file-stream>,
         <byte-file-stream>,
         <external-file-accessor>,
         type-for-file-stream,
         stream-locator,
         writable-file-stream-position-setter,
         <general-file-stream>,
         <byte-char-file-stream>;

  // Multi-buffered streams
  export <buffer-vector>,
         <multi-buffered-stream>,
         multi-buffered-stream-position-setter,
         write-4-aligned-bytes-from-word,
         read-4-aligned-bytes-as-word,
         write-4-aligned-bytes, write-8-aligned-bytes,
         read-4-aligned-bytes, read-8-aligned-bytes,
         multi-buffer-working-set,
         multi-buffer-reads,
         multi-buffer-bytes,
         multi-buffer-total-working-set,
         multi-buffer-total-reads,
         multi-buffer-total-bytes,
         <general-multi-buffered-stream>,
         <byte-multi-buffered-stream>,
         <byte-char-multi-buffered-stream>;

  // Sequence streams
  export clear-contents,
         newline-sequence,
         stream-limit-setter,
         stream-sequence;

  // Stream access paths
  export <external-stream-accessor>,
         <external-stream>,
         platform-accessor-class,
         new-accessor,
         accessor, accessor-setter,
         accessor-open,
         accessor-open?,
         accessor-close,
         accessor-at-end?,
         accessor-at-end?-setter,
         accessor-console?,
         accessor-size,
         accessor-size-setter,
         accessor-positionable?,
         accessor-position,
         accessor-position-setter,
         accessor-force-output,
         accessor-wait-for-completion,
         accessor-newline-sequence,
         accessor-preferred-buffer-size,
         accessor-fd,
         accessor-synchronize,
         accessor-read-into!,
         accessor-write-from;

  // "High performance"
  export \copy-down-stream-definer,
         \copy-down-buffered-stream-definer,
         read-skip,
         write-fill;

  // File accessors
  create <native-file-accessor>;
end module streams-internals;
