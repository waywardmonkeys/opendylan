Library:   sample-OLE-server
Synopsis:  Example of an OLE server application using the low-level API.
Files:	library
	resdecl
	declobj
	declapp
	oleutl
	hatch
	app
	obj
	doc
	icf
	simpsvr
	ioo
	iec
	ioipao
	ips
	ido
	ioipo
	last
Target-type: executable
Compilation-mode: tight
Start-Function: WinMain
RC-Files: simpsvr.rc
C-Header-Files: resource.h
	csimpsvr.h
	simpsvr.ico
Linker-Options: $(guilflags)
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND
Other-Files: README.html
             sample.reg
Platforms: x86-win32
