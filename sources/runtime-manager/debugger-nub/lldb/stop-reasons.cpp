#include "nub-core.h"
#include <assert.h>
#include <stdio.h>

using namespace lldb;

NUBTHREAD nub_stop_reason_thread
  (NUB nub)
{
  NUBTHREAD thread = new NUB_THREAD_STATE();
  thread->thread = nub->process.GetSelectedThread();
  return thread;
}

