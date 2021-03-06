Module:    win32-gl
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

// These actually belong in win32-gdi

define C-function wglCreateContext
  parameter hdc :: <HDC>;
  result    val :: <HGLRC>;
  c-name: "wglCreateContext", c-modifiers: "__stdcall";
end C-function;

define C-function wglMakeCurrent
  parameter hdc :: <HDC>;
  parameter rc  :: <HGLRC>;
  result    val :: <BOOL>;
  c-name: "wglMakeCurrent", c-modifiers: "__stdcall";
end C-function;
