library:     debugger-nub
Target-type: dll
Files:       library
C-Source-Files: app_control.c
                debug_map.c
                coff_map.c
                debug_points.c
                memory_access.c
                register_access.c
                misc_utils.c
                page_protection.c
                remote_function_call.c
                remote_object_registration.c
                remote_objects.c
                source_location_info.c
                stack_backtrace2.c
                stop_reasons.c
                symbol_lookup.c
                dylan-extensions.c
                profile.c
                quick_and_dirty.c
                address-print.c
                coff_relocations.c
                page_fault_count.c
                process_walker.c
                server.c
                server_locals.c
                proxy.c
                lproxy.c
C-Header-Files: coff-extract.h
                coff_map.h
                cv-extract.h
                cv-types.h
                debug_map.h
                dia-types.h
                dylan-extensions.h
                nub-core-types.h
                nub-core.h
                nub_interface.h
                resource.h
                utils.h
C-Libraries:    dbghelp.lib
Copyright:   Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
             All rights reserved.
License:     See License.txt in this distribution for details.
Warranty:    Distributed WITHOUT WARRANTY OF ANY KIND

