#include "nub-core.h"
#include <assert.h>
#include <stdio.h>

using namespace lldb;

// process creation and tethering.

NUB_STATE::NUB_STATE()
  : launchInfo(nullptr),
    started(false)
{
}

// open_local_tether
// Calls the local debugger nub to create a new target process. Returns
// a NUB descriptor which must subsequently be passed to all requests
// to the local nub to perform transactions on that process.

NUB
  open_local_tether
    (char *command,          // IN: The name and relative path of the EXE
     char *arguments,        // IN: The additional command line to pass.
     NUBINT sym_path_count,  // IN: The number of symbol search paths.
     char **paths,           // IN: The symbol search paths.
     NUBINT lib_path_count,  // IN: The number of DLL search paths.
     char **lib_paths,       // IN: The DLL search paths themselves.
     char *workdir,          // IN: The working directory pathname.
     NUBINT create_shell,    // IN: nonzero means allow process to create its
                             //     own shell or console window.
     NUBINT *success         // OUT: 1 indicates success, 0 indicates failure.
  )
{
  SBDebugger::Initialize();

  NUB nub = new NUB_STATE();
  nub->started = false;
  nub->debugger = SBDebugger::Create(false);
  nub->debugger.SetAsync(true);
  nub->target = nub->debugger.CreateTarget(command);
  nub->launchInfo.SetWorkingDirectory(workdir);
  nub->launchInfo.SetLaunchFlags(eLaunchFlagStopAtEntry);
  *success = 1;
  return nub;
}

NUBINT nub_thread_stop_information
  (NUB nub,  NUBTHREAD nubthread,
    NUBINT *fchance,  NUBINT *fstart,
    TARGET_ADDRESS *ret_addr)
{
  *fchance = 0;
  *fstart = 0;
  *ret_addr = (TARGET_ADDRESS)0;
  return 0;
}

void nub_wait_for_stop_reason_with_timeout
  (NUB nub,  NUBINT timeout,  NUBINT *code)
{
  SBEvent event;
  if (nub->debugger.GetListener().WaitForEvent(
        timeout / 1000,
        event
      ))
  {
    if (!nub->started)
    {
      *code = CREATE_PROCESS_DBG_EVENT;
    }
    return;
  }
  *code = TIMED_OUT;
}

void nub_application_restart
  (NUB nub)
{
  if (nub->process.GetProcessID() != LLDB_INVALID_PROCESS_ID)
  {
    nub->process.Stop();
    nub->process.Kill();
  }

  SBError error;
  nub->process = nub->target.Launch(nub->launchInfo, error);
}

void nub_application_stop
  (NUB nub)
{
  SBError error = nub->process.Stop();
  assert(error.Success());
}

void nub_application_continue
  (NUB nub)
{
  SBError error = nub->process.Continue();
  assert(error.Success());
}

void nub_thread_stop
  (NUB nub,  NUBTHREAD nubthread)
{
  if (nubthread)
  {
    nubthread->thread.Suspend();
  }
}

void nub_thread_continue
  (NUB nub,  NUBTHREAD nubthread)
{
  if (nubthread)
  {
    nubthread->thread.Resume();
  }
}

void nub_thread_suspended (NUBTHREAD thread)
{
  thread->thread.Suspend();
}

bool nub_thread_suspendedQ (NUBTHREAD thread)
{
  return thread->thread.IsSuspended();
}

void nub_thread_resumed (NUBTHREAD thread)
{
  thread->thread.Resume();
}

NUB_ERROR nub_kill_application
  (NUB nub)
{
  printf("NYI: nub_kill_application\n");
  return 0;
}

void nub_close_application
  (NUB nub)
{
  printf("NYI: nub_close_application\n");
}
