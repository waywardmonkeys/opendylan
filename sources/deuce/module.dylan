Module:       Dylan-User
Synopsis:     The Deuce editor
Author:       Scott McKay
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

// Export module for Deuce external clients
define module deuce-commands
  // Basic commands
  create editor-help, editor-key-bindings,
         self-insert, insert-tab, quoted-insert,
         numeric-argument, numeric-negative, universal-argument,
         toggle-overwrite,
         cancel-command,
         scroll-forward, scroll-forward-ext,
         scroll-backward, scroll-backward-ext,
         start-of-page, end-of-page,
         force-redisplay, force-recenter,
         show-position,
         forward-character, backward-character,
         forward-character-ext, backward-character-ext,
         forward-word, backward-word,
         forward-word-ext, backward-word-ext,
         forward-list, backward-list,
         forward-expression, backward-expression,
         next-line, previous-line,
         next-line-ext, previous-line-ext,
         start-of-line, end-of-line,
         start-of-line-ext, end-of-line-ext,
         start-of-buffer, end-of-buffer,
         start-of-section, end-of-section,
         down-list, up-list,
         down-expression, up-expression,
         goto-character, goto-line,
         delete-character, rubout-character,
         delete-word, rubout-word,
         delete-list, rubout-list,
         delete-expression, rubout-expression,
         cut-region, delete-region, copy-region, paste,
         yank, yank-next,
         insert-newline, indent-newline,
         open-line, split-line,
         kill-line, join-lines,
         transpose-characters, transpose-words, transpose-expressions, transpose-lines,
         transpose-lists,
         upcase-word, downcase-word, capitalize-word,
         upcase-region, downcase-region,
         change-region-font, change-region-weight, change-region-slant,
         find-string, find-next-string, find-previous-string,
         replace-string, query-replace-string,
         show-matching-lines, show-non-matching-lines,
         hack-matching-lines,
         set-mark, exchange-point-pdl, swap-point-and-mark,
         mark-buffer, mark-to-beginning, mark-to-end,
         mark-next-word, mark-word,
         mark-next-atom, mark-atom,
         mark-next-expression,
         save-point-in-register, restore-point-from-register,
         save-string-in-register, insert-string-from-register,
         undo-command, undo-all-commands,
         redo-command, redo-all-commands,
         find-file, new-file, insert-file,
         save-file, save-file-as, save-all-files,
         print-file,
         revert-file, close-file, sectionize-file,
         choose-buffer, switch-buffers, new-buffer,
         mark-unmodified, toggle-read-only,
         choose-configuration,
         edit-definition,
         start-of-definition, end-of-definition,
         indent-line, indent-expression, indent-region,
         indent-rigidly, unindent-rigidly,
         insert-comment, comment-region,
         delete-whitespace,
         start-keyboard-macro, finish-keyboard-macro,
         execute-keyboard-macro,
         dylan-insert-block-end;

  // Language and environment commands
  create complete-name, dynamic-complete-name,
         show-value, describe-object,
         browse-object, browse-class, browse-function,
         show-arglist, show-documentation,
         evaluate-definition, evaluate-region, evaluate-buffer,
         macroexpand-region,
         parse-project, compile-project, clean-compile-project,
         link-project, build-project, clean-build-project,
         compile-file, load-file;

  // Browsing buffer commands
  create edit-home-definition,
         edit-class-subclasses, edit-class-superclasses,
         edit-class-methods, edit-generic-function-methods,
         edit-callers, edit-callees;

  // Source version control commands
  create vc-claim,
         vc-check-out,
         vc-check-in,
         vc-abandon,
         vc-merge,
         vc-diff,
         vc-report,
         vc-add,
         vc-remove;

  // Mail commands
  create send-mail,
         mail-send,
         mail-send-and-exit,
         mail-signature;
end module deuce-commands;

// Export module for Deuce Dylan clients
define module deuce
  use deuce-commands,
    export: all;

  create <line>,
         <text-line>,
         <diagram-line>,
         <structural-diagram-line>,
         line-next,
         line-previous,
         line-section,
         copy-line,
         line-length,
         line-contents,
         line-node,
         line-empty?;

  create <bp>,
         make-bp, copy-bp,
         bp-line,
         bp-index,
         bp-buffer,
         move-bp!,
         kill-bp!,
         bp-less?, bp-greater?,
         bp-character, bp-character-setter,
         bp-character-before, bp-character-after,
         bp-looking-at?, bp-looking-at-word?,  bp-looking-at-atom?,
         bp-node;

  create <interval>,
         make-interval, copy-interval,
         interval-start-bp, interval-end-bp,
         interval-buffer,
         do-lines, do-characters,
         count-lines, count-characters,
         bp-within-interval?;

  create <node>,
         <section-node>,
         <definition-node>,
         node-next,
         node-previous,
         node-parent,
         node-children,
         node-buffer,
         node-section,
         node-definition-signature,
         node-definition-name,
         node-definition-type,
         make-section-node, make-empty-section-node;

  create <section>,
         <definition-section>,
         section-start-line,
         section-end-line,
         section-definition-signature,
         section-definition-name,
         section-definition-type,
         section-container,
         section-home-buffer,
         section-node,
         add-line!, remove-line!,
         make-empty-section;

  create <source-container>,
         container-pathname,
         container-sections;

  create <syntax-table>,
         $word-alphabetic,
         $word-delimiter,
         $atom-alphabetic,
         $atom-delimiter,
         $list-alphabetic,
         $list-delimiter,
         $list-escape,
         $list-single-quote,
         $list-double-quote,
         $list-open,
         $list-close,
         $default-word-syntax,
         $default-atom-syntax,
         $default-list-syntax,
         character-syntax,
         word-syntax, atom-syntax, list-syntax;

  create <command-table>,
         command-table-name,
         add-command!, remove-command!,
         find-command;

  create <command-set>,
         $standard-command-set,
         command-set-name,
         standard-command-table,
         control-X-command-table,
         control-C-command-table,
         escape-command-table,
         compute-key-binding-documentation;

  create <mode>,
         <major-mode>,
         <language-mode>,
         <minor-mode>,
         word-syntax-table,
         atom-syntax-table,
         list-syntax-table;

  create <buffer>,
         <file-buffer>,
         <non-file-buffer>,
         <simple-display-buffer>,
         <composite-buffer>,
         *buffer*,
         buffer-name,
         buffer-pathname, buffer-default-pathname,
         buffer-start-node,
         buffer-end-node,
         line-next-in-buffer,
         line-previous-in-buffer,
         revert-buffer,
         save-buffer, save-buffer-as,
         kill-buffer,
         gc-buffer,
         file-buffer?, saves-like-file-buffer?,
         composite-buffer?,
         special-purpose-buffer?,
         buffer-modified?,
         add-node!, remove-node!,
         do-save-all-files;

  create <interval-stream>,
         <repainting-interval-stream>;

  create <kill-history>,
         do-history-elements,
         yank-from-history,
         yank-next-from-history,
         history-push,
         history-pop,
         history-top, history-top-setter,
         add-to-kill-ring, yank-from-kill-ring;

  create <window>,
         window-buffer,
         window-point,
         window-mark,
         window-temporary-mark?,
         select-buffer, select-buffer-in-appropriate-window;

  create <editor>,
         editor-frames,
         editor-windows,
         editor-buffers,
         find-buffer, find-buffer-from-pathname;

  create <editor-frame>,
         *editor-frame*,
         frame-editor,
         frame-buffer,
         frame-window,
         frame-command-set,
         exit-editor;

  create $display-none,
         $display-region,
         $display-point,
         $display-line,
         $display-text,
         $display-blt,
         $display-all,
         queue-redisplay, queue-region-redisplay,
         redisplay-window, redisplay-all-windows,
         redisplay-section,
         recenter-window,
         bp->position, position->bp,
         point, move-point!,
         mark, move-mark!, clear-mark!,
         swap-point-and-mark!;

  create increment-bp!, decrement-bp!,
         start-of-line?, line-start,
         end-of-line?, line-end,
         move-over-characters,
         move-over-words, move-over-atoms,
         move-over-lists, move-over-expressions,
         move-up-or-down-lists, move-up-or-down-expressions,
         move-over-lines,
         forward-over,  forward-over!,
         backward-over, backward-over!,
         forward-until, backward-until,
         definition-interval, relevant-function-interval,
         atom-under-bp, select-atom-under-bp,
         char-index->bp, bp->char-index,
         line-index->line, line->line-index,
         line-index->bp, bp->line-index;

  create insert!, insert-moving!,
         delete!, kill!;

  create search;

  create <presentation>,
         presentation-object, presentation-type,
         presentation-at-position,
         handle-presentation-event,
         cursor-at-position;

  create $menu-gesture,
         $move-gesture,
         $copy-gesture,
         $edit-gesture,
         gesture-matches?;
end module deuce;

// Implementation and extension module
define module deuce-internals
  use common-dylan,
    exclude: { position, position-if, count };
  use dylan-extensions,
    import: { \without-bounds-checks,
              element-no-bounds-check,
              element-no-bounds-check-setter,
              element-range-error };
  use format;
  use format-out;
  use threads;
  use table-extensions, exclude: { table };
  use plists;

  use byte-vector;
  use streams-internals,
    rename: { <buffer>       => streams/<buffer>,
              read-character => streams/read-character };
  use date;
  use file-system,
    export: { <pathname> };
  use locators;

  use deuce,
    export: all;

  export \inc!, \dec!,
         \max!, \min!,
         \swap!,
         \push!, \pop!,
         \with-thing-locked,                // to squelch a compiler warning
         \with-node-locked,
         \with-buffer-locked,
         \with-editor-locked,
         \with-editor-state-bound;

  export true, false,
         gethash, gethash-setter, remhash,
         position, position-if, count,
         insert-at!, remove-at!,
         get-file-property,
         tick;

  export char-equal?, char-less?, char-greater?,
         string-equal?, string-less?, string-greater?,
         alpha-char?, digit-char?, alphanumeric-char?,
         upper-case?, lower-case?,
         graphic-char?, standard-char?,
         whitespace-char?, any-whitespace-char?,
         string-trim, trim-whitespace,
         string-capitalize, string-capitalize!;

  export <basic-line>,
         <fixed-text-line>,
         <rich-text-line>,
         text-line?, diagram-line?, structural-diagram-line?,
         line-next-setter,
         line-previous-setter,
         line-section-setter,
         line-length-setter,
         line-contents-setter,
         line-style-changes, line-style-changes-setter,
         line-bps, line-bps-setter,
         line-modification-tick, line-modification-tick-setter,
         line-properties, line-properties-setter,
         line-contents-properties, line-contents-properties-setter,
         note-line-changed,
         line-read-only?, line-read-only?-setter,
         line-for-display-only?,
         dump-line,
         gc-line;

  export <style-change>,
         style-change-index, style-change-index-setter,
         style-change-font,  style-change-font-setter,
         style-change-color, style-change-color-setter;

  export <moving-bp-mixin>,
         <basic-bp>,
         <simple-bp>, <simple-moving-bp>,
         <permanent-bp>, <permanent-moving-bp>,
         simple-bp?, moving-bp?;

  export <basic-interval>,
         <simple-interval>,
         bp-line-setter,
         bp-index-setter,
         bp-buffer-setter,
         interval-read-only?, interval-read-only?-setter,
         interval-start-bp-setter, interval-end-bp-setter;

  export <basic-node>,
         <simple-section-node>,
         <simple-definition-node>,
         node-next-setter,
         node-previous-setter,
         node-parent-setter,
         node-children-setter,
         node-buffer-setter,
         node-section-setter,
         node-lock,
         note-node-changed;

  export <basic-section>,
         <simple-section>,
         <section-separator-style>,
         section-start-line-setter,
         section-end-line-setter,
         section-nodes, section-nodes-setter,
         section-modification-tick,   section-modification-tick-setter,
         section-sectionization-tick, section-sectionization-tick-setter,
         section-compilation-tick,    section-compilation-tick-setter,
         section-defining-line,
         section-lock,
         note-section-changed,
         note-section-compiled,
         resectionize-section;

  export <basic-source-container>,
         <flat-file-source-container>,
         <database-file-source-container>,
         do-find-file,
         maybe-save-buffer,
         find-source-container,
         source-container-class,
         container-pathname-setter,
         container-sections-setter,
         container-has-hard-sections?,
         container-modified?,
         note-container-changed,
         container-read-only?,
         container-home-buffer,
         container-buffers, container-buffers-setter,
         container-undo-history,
         container-lock,
         container-properties, container-properties-setter,
         read-container-contents,
         read-buffer-contents-from-stream, read-section-contents-from-stream,
         sectionize-container,
         add-section!, remove-section!;

  export copy-syntax-table, copy-syntax-table-into!,
         character-syntax-setter;

  export <standard-command-table>,
         copy-command-table, copy-command-table-into!,
         add-commands!, remove-commands!,
         $control-key, $meta-key, $super-key, $shift-key,
         $left-button, $middle-button, $right-button,
         $modifier-key-names;

  export <standard-command-set>,
         copy-command-set, copy-command-set-into!,
         standard-command-table-setter,
         control-X-command-table-setter,
         control-C-command-table-setter,
         escape-command-table-setter;

  export <fundamental-mode>,
         <text-mode>,
         *major-modes*,
         *minor-modes*,
         *file-type->major-mode*,
         *keyword->major-mode*,
         initialize-major-mode,
         word-syntax-table-setter,
         atom-syntax-table-setter,
         list-syntax-table-setter,
         mode-name,
         mode-command-set, mode-command-set-setter,
         major-mode?,
         find-mode,
         find-mode-from-keyword,
         find-mode-from-file-type, find-mode-from-pathname,
         enter-mode, exit-mode,
         mode-initial-minor-modes,
         execute-command, execute-command-in-frame,
         source-file-type, binary-file-type,
         do-sectionize-buffer,
         do-sectionize-container,
         do-resectionize-section,
         do-note-line-changed,
         do-definition-interval,
         do-relevant-function-interval,
         do-atom-under-bp,
         do-move-over-expressions,
         do-move-up-or-down-expressions,
         do-insert-comment, do-comment-region,
         do-indent-line, do-indent-region,
         do-complete-name, do-complete-dynamically, do-edit-definition,
         do-describe-object,
         do-browse-object, do-browse-class, do-browse-function,
         do-show-arglist, do-show-documentation,
         definition-browser-parameters,
         compilation-supported?,
         do-compile-file, do-load-file, do-compile-to-core,
         do-macroexpand,
         do-build-project,
         <breakpoint-state>,
         line-breakpoint?, line-breakpoint?-setter,
         line-breakpoint-icon,
         buffer-command-menu-items;

  export <source-control-operation>,
         do-source-control-operation;

  export <mail-buffer>,
         <mail-mode>,
         make-mail-buffer,
         parse-mail-buffer,
         do-send-mail;

  export <command-error>,
         command-error-window,
         command-error-format-string,
         command-error-format-arguments,
         <simple-command-error>,
         <read-only-command-error>,
         command-error,
         check-read-only;

  export <basic-buffer>,
         <special-purpose-buffer-mixin>,
         <basic-special-purpose-buffer>,
         <file-buffer-mixin>,
         <non-file-buffer-mixin>,
         <composite-buffer-mixin>,
         buffer-start-node-setter,
         buffer-end-node-setter,
         buffer-lock,
         buffer-major-mode, buffer-major-mode-setter,
         buffer-minor-modes, buffer-minor-modes-setter,
         buffer-modification-tick, buffer-modification-tick-setter,
         buffer-save-tick, buffer-save-tick-setter,
         buffer-properties, buffer-properties-setter,
         buffer-contents-properties, buffer-contents-properties-setter,
         buffer-name-setter,
         buffer-pathname-setter,
         buffer-source-container, buffer-source-container-setter,
         buffer-initial-point, buffer-initial-mark, buffer-initial-line,
         sectionize-buffer,
         revert-buffer-if-necessary,
         buffer-has-hard-sections?,
         buffer-contains-section?,
         buffer-modified?-setter,
         buffer-section-separator-style,
         note-buffer-changed,
         buffer-read-only?, buffer-read-only?-setter,
         buffer-anonymous?,
         buffer-undo-history,
         make-empty-buffer, make-initial-buffer,
         buffer-associated-buffers, buffer-associated-buffers-setter;

  export <basic-history>,
         history-length,
         history-element,
         history-element-size,
         merge-history-elements,
         reset-history;

  export <undo-history>,
         reset-undo-history,
         undo-history-state,
         <change-record>,
         <insert-change-record>,
         <paste-change-record>,
         <delete-change-record>,
         <kill-change-record>,
         <replace-change-record>,
         <indentation-change-record>,
         find-change-record,
         close-change-record,
         extend-insertion-record,
         extend-deletion-record,
         add-change-record,
         \with-change-recording,
         *change-record*,
         undo!, undo-all!, do-undo,
         redo!, redo-all!, do-redo;

  export <basic-window>,
         window-point-setter,
         window-mark-setter,
         window-temporary-mark?-setter,
         window-buffer-setter,
         window-selected-buffers, window-selected-buffers-setter,
         window-goal-x-position, window-goal-x-position-setter,
         window-display-lines, window-n-display-lines,
         window-max-line-width,
         window-redisplay-degree, window-redisplay-degree-setter,
         window-centering-fraction, window-centering-fraction-setter,
         window-initial-line, window-initial-line-setter,
         window-line-number, window-line-number-setter,
         window-total-lines, window-total-lines-setter,
         window-redisplay-line, window-redisplay-line-setter,
         window-redisplay-index, window-redisplay-index-setter,
         window-frame, window-frame-setter,
         window-line-spacing,
         window-font, window-font-setter,
         window-default-font, window-default-font-setter,
         window-default-bold-font, window-default-bold-font-setter,
         window-default-italic-font, window-default-italic-font-setter,
         set-default-font,
         set-default-font-size,
         window-color, window-color-setter,
         push-point-pdl!, pop-point-pdl!,
         command-enabled?, command-enabled?-setter,
         window-note-mode-entered,
         window-note-buffer-changed, note-buffer-changed-everywhere,
         window-note-buffer-read-only, note-buffer-read-only-everywhere,
         window-note-buffer-selected,
         window-note-selection-changed,
         window-note-search-string,
         window-note-undo/redo,
         window-note-policy-changed,
         window-hide-section-separators?,
         line-visible-in-window?, line-invisible-in-window?;

  export window-enabled?,
         window-occluded?,
         window-size,
         window-viewport-size,
         update-scroll-bar,
         scroll-position, set-scroll-position,
         display-message, display-error-message,
         display-buffer-name, display-buffer-name-everywhere,
         draw-string, string-size,
         draw-line, draw-rectangle,
         draw-image,
         clear-area,
         copy-area,
         cursor-position, set-cursor-position,
         \with-busy-cursor, do-with-busy-cursor,
         caret-position, set-caret-position,
         caret-size, set-caret-size,
         show-caret, hide-caret,
         font-metrics,
         choose-from-menu, choose-from-dialog,
         information-dialog, warning-dialog,
         yes-or-no-dialog, yes-no-or-cancel-dialog,
         open-file-dialog, new-file-dialog,
         save-buffers-dialog,
         choose-buffer-dialog, choose-buffers-dialog,
         new-buffer-dialog,
         choose-string-dialog,
         hack-matching-lines-dialog,
         string-search-dialog, string-replace-dialog,
         edit-definition-dialog,
         goto-position-dialog, <goto-target-type>,
         configuration-dialog,
         add-to-clipboard, get-from-clipboard,
         read-character, read-gesture;

  export <color>,
         make-color,
         color-red, color-green, color-blue,
         $black, $white, $red, $green, $blue, $cyan, $magenta, $yellow,
         $default-foreground, $default-background;

  export <font>,
         make-font,
         font-family, font-name, font-weight, font-slant, font-size,
         font-point-size,
         font->index, index->font,
         $default-font, $default-bold-font, $default-italic-font;

  export standard-images,
         $potential-breakpoint,
         $enabled-breakpoint,
         $disabled-breakpoint,
         $step-breakpoint,
         $test-breakpoint,
         $enabled-tracepoint,
         $disabled-tracepoint,
         $profile-point,
         $current-location,
         $prompt-arrow,
         $values-arrow,
         $warning,
         $serious-warning,
         $breakpoint-image-width, $breakpoint-image-height,
         $prompt-image-width,     $prompt-image-height;

  export <basic-editor>,
         <simple-editor>,
         editor-frames-setter,
         editor-windows-setter,
         editor-buffers-setter,
         editor-source-containers, editor-source-containers-setter,
         editor-kill-history,
         editor-policy, editor-policy-setter,
         editor-lock,
         editor-search-string, editor-search-string-setter,
         editor-replace-string, editor-replace-string-setter,
         editor-reverse-search?, editor-reverse-search?-setter,
         editor-case-sensitive-search?, editor-case-sensitive-search?-setter,
         editor-whole-word-search?, editor-whole-word-search?-setter,
         editor-skip-table, editor-skip-table-setter,
         editor-reoccurrence-table, editor-reoccurrence-table-setter,
         \do-associated-windows, \do-associated-buffers;

  export <editor-state-mixin>,
         <basic-editor-frame>,
         <simple-editor-frame>,
         frame-buffer-setter,
         frame-window-setter,
         frame-command-set-setter,
         frame-command-state, frame-command-state-setter,
         frame-command, frame-command-setter,
         frame-command-character, frame-command-character-setter,
         frame-command-modifiers, frame-command-modifiers-setter,
         frame-last-command, frame-last-command-setter,
         frame-last-command-type, frame-last-command-type-setter,
         frame-numeric-arg, frame-numeric-arg-setter,
         frame-numeric-arg-state, frame-numeric-arg-state-setter,
         frame-before-command-hooks, frame-after-command-hooks,
         frame-dynamic-completion-state, frame-dynamic-completion-state-setter,
         frame-search-string-found?, frame-search-string-found?-setter,
         find-next-or-previous-string,
         replace-next-or-previous-string;

  export <editor-policy>,
         $emacs-editor-policy, $windows-editor-policy,
         $default-editor-policy,
         copy-policy,
         command-set-policy, command-set-policy-setter, <command-set-policy>,
         install-command-set,
         alt-key-is-meta?, alt-key-is-meta?-setter,
         initial-click-moves-point?, initial-click-moves-point?-setter,
         clipboard-policy, clipboard-policy-setter,
         typing-replaces-selection?, typing-replaces-selection?-setter,
         unselected-copy-policy, unselected-copy-policy-setter, <unselected-copy-policy>,
         next-line-adds-newline?, next-line-adds-newline?-setter,
         undo-past-save-policy, undo-past-save-policy-setter,
         confirm-kill-buffer?, confirm-kill-buffer?-setter,
         new-file-buffer?, new-file-buffer?-setter,
         marking-policy, marking-policy-setter, <marking-policy>,
         scrolling-moves-point?, scrolling-moves-point?-setter,
         tab-stop-size, tab-stop-size-setter,
         default-font, default-font-setter,
         default-font-size, default-font-size-setter,
         fixed-frame-buffer?, fixed-frame-buffer?-setter,
         show-section-separators?, show-section-separators?-setter,
         show-path-in-title?, show-path-in-title?-setter,
         wrap-searches?, wrap-searches?-setter,
         use-isearch?, use-isearch?-setter;

  export set-centering-fraction,
         do-redisplay-window, redisplay-window-within-frame,
         initialize-redisplay-for-buffer,
         scroll-n-lines,
         update-display-lines,
         find-display-line,
         display-line-line, display-line-line-setter,
         display-line-tick, display-line-tick-setter,
         display-line-start, display-line-start-setter,
         display-line-end, display-line-end-setter,
         display-line-width, display-line-width-setter,
         display-line-height, display-line-height-setter,
         display-line-y, display-line-y-setter,
         display-line-baseline, display-line-baseline-setter,
         display-line-mark-start, display-line-mark-start-setter,
         display-line-mark-end, display-line-mark-end-setter,
         display-line-mark-x, display-line-mark-x-setter,
         display-line-mark-width, display-line-mark-width-setter,
         display-line-mark-tick, display-line-mark-tick-setter,
         ensure-line-visible,
         clear-region-marking,
         display-region-marking,
         update-display-line-marking,
         $region-marking-color,
         display-line,
         line-size, line-margin,
         position->index, index->position;

  export move-forward-or-backward!;

  export insert-into-line;

  export delete-within-line,
         note-multi-line-deletion;

  export boyer-search,
         cached-boyer-search, compute-boyer-tables,
         string-search, string-reverse-search;

  export frame-isearch-trail,       frame-isearch-trail-setter,
         frame-isearch-direction,   frame-isearch-direction-setter,
         frame-isearch-move-mark?,  frame-isearch-move-mark?-setter,
         frame-isearch-last-string, frame-isearch-last-string-setter,
         incremental-search-forward,
         incremental-search-backward,
         start-incremental-search,
         continue-incremental-search,
         finish-incremental-search;

  export <basic-presentation>,
         <simple-presentation>,
         <blank-area>,
         <event-type>,
         do-presentation-at-position,
         do-handle-presentation-event,
         do-cursor-at-position,
         blank-area-menu,
         \with-temporary-selection, do-with-temporary-selection;

  export \command-definer,
         $brief-command-help, $long-command-help;

  export <shell-mode>,
         shell-input-complete?,
         process-shell-input, do-process-shell-input,
         terminate-shell,
         previous-shell-input,
         next-shell-input,
         activate-shell-input-newline,
         activate-shell-input,
         trim-shell-output-history,
         cancel-shell-command,
         <basic-shell-buffer>,
         <simple-shell-buffer>,
         shell-buffer-section-class,
         <basic-shell-section>,
         <simple-shell-section>,
         shell-section?,
         section-output-line, section-output-line-setter,
         <shell-input>;

  export <header-node>;

  export <dylan-mode>,
         <dylan-section>,
         <dylan-definition-node>,
         <dylan-header-node>,
         compute-file-signatures, compute-buffer-signatures, compute-section-signature,
         node-module-name, node-module-name-setter,
         <dylan-definition-line>,
         $dylan-definition-line-color,
         <dylan-breakpoint>,
         <dylan-atom>,
         <dylan-shell-mode>,
         make-dylan-shell;

  export <xml-mode>,
         <xml-section>,
         <xml-node>,
         <xml-header-node>;

  export <keyboard-macro>,
         keyboard-macro-closed?, keyboard-macro-closed?-setter,
         keyboard-macro-items, keyboard-macro-items-setter,
         do-execute-keyboard-macro,
         <keyboard-macro-item>;

  export <definition-browsing-buffer>,
         browsing-buffer-definition,
         browsing-buffer-name-key,
         browsing-buffer-generator,
         <subclasses-browsing-buffer>,
         <superclasses-browsing-buffer>,
         <class-methods-browsing-buffer>,
         <generic-function-methods-browsing-buffer>,
         <callers-browsing-buffer>,
         <callees-browsing-buffer>;
end module deuce-internals;
