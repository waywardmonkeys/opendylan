/* ********************************************************************** */
/* ** nub-core-types.h                                                 ** */
/* ** Basic type aliases to improve code documentation in the nub.     ** */
/* ** ---------------------------------------------------------------- ** */
/* ** Author: Paul Howard                                              ** */
/* ** Copyright: (c) 1998 Functional Objects, Inc.                     ** */
/* **            All Rights Reserved.                                  ** */
/* ********************************************************************** */

#ifndef OPEN_DYLAN_NUB_CORE_TYPES_H_
#define OPEN_DYLAN_NUB_CORE_TYPES_H_

#include "lldb/api/lldb.h"

typedef struct NUB_STATE {
  NUB_STATE();

  lldb::SBDebugger     debugger;
  lldb::SBTarget       target;
  lldb::SBProcess      process;
  lldb::SBLaunchInfo   launchInfo;
  bool                 started;
} *NUB;

typedef struct NUB_THREAD_STATE {
  lldb::SBThread       thread;
} *NUBTHREAD;

typedef char           INT8;
typedef short          INT16;
typedef long           INT32;
typedef void*          INT64;
typedef short          UNICODE;
typedef void*          NUBHANDLE;
typedef int            NUBINT;
typedef void*          SERVER;
typedef int            NUB_INDEX;
typedef int            NUB_ERROR;
typedef void*          NUBPROCESS;
typedef void*          NUBLIBRARY;
typedef float          FLOAT;
typedef double         DOUBLE;
typedef void*          NUBFRAME;
typedef void*          TARGET_ADDRESS;
typedef int            TARGET_INT;

#endif // OPEN_DYLAN_NUB_CORE_TYPES_H_
