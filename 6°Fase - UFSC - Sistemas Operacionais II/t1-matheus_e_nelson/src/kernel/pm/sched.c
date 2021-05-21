/*
 * Copyright(C) 2011-2016 Pedro H. Penna   <pedrohenriquepenna@gmail.com>
 *              2015-2016 Davidson Francis <davidsondfgl@hotmail.com>
 *
 * This file is part of Nanvix.
 *
 * Nanvix is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Nanvix is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Nanvix. If not, see <http://www.gnu.org/licenses/>.
 */

#include <nanvix/clock.h>
#include <nanvix/const.h>
#include <nanvix/klib.h>
#include <nanvix/hal.h>
#include <nanvix/pm.h>
#include <signal.h>
#include <string.h>

unsigned max_tickets = 0; /* Maximum tickets produced */

/**
 * @brief Schedules a process to execution.
 *
 * @param proc Process to be scheduled.
 */
PUBLIC void sched(struct process *proc)
{
	proc->state = PROC_READY;

	/* Grant a ticket to the process based on priority */
	if (proc->priority == PRIO_IO) {
		proc->tickets = 16;
	} else if (proc->priority == PRIO_BUFFER) {
		proc->tickets = 14;
	} else if (proc->priority == PRIO_INODE) {
		proc->tickets = 12;
	} else if (proc->priority == PRIO_SUPERBLOCK) {
		proc->tickets = 10;
	} else if (proc->priority == PRIO_REGION) {
		proc->tickets = 8;
	} else if (proc->priority == PRIO_TTY) {
		proc->tickets = 6;
	} else if (proc->priority == PRIO_SIG) {
		proc->tickets = 4;
	} else {
		proc->tickets = 2;
	}

	/*
		Because counter is used as a clock tick counter when the process
		is running, we can use it to calculate its quantum_fraction
		quantum_fraction is how many ticks were executed
		The compensation is given by PROC_QUNATUM / proc->quantum_fraction
	*/
	proc->quantum_fraction = PROC_QUANTUM - proc->counter;
  /* Grant compensation tickets */
  if (proc->quantum_fraction != 0)
    proc->tickets = proc->tickets * PROC_QUANTUM / proc->quantum_fraction;
  proc->counter = 0;
}

/**
 * @brief Stops the current running process.
 */
PUBLIC void stop(void)
{
	curr_proc->state = PROC_STOPPED;
	sndsig(curr_proc->father, SIGCHLD);
	yield();
}

/**
 * @brief Resumes a process.
 *
 * @param proc Process to be resumed.
 *
 * @note The process must stopped to be resumed.
 */
PUBLIC void resume(struct process *proc)
{
	/* Resume only if process has stopped. */
	if (proc->state == PROC_STOPPED)
		sched(proc);
}

/*
		Counts the number of total tickets so that we
		can generate a random number between 0 and max_tickets - 1
	*/
unsigned generate_rand_number()
{
  return max_tickets ? krand() % max_tickets : 0;
}

/**
 * @brief Yields the processor.
 */
PUBLIC void yield(void)
{
	struct process *p;    /* Working process.     */
	struct process *next; /* Next process to run. */
	unsigned selected_ticket; /* Selected according to random number generator */
	unsigned ticket_sum = 0; /* Sum of tickets used to select process with winning ticket */

	/* Re-schedule process for execution. */
	if (curr_proc->state == PROC_RUNNING)
		sched(curr_proc);

	/* Remember this process. */
	last_proc = curr_proc;

	/* Check alarm. */
	for (p = FIRST_PROC; p <= LAST_PROC; p++)
	{
		/* Skip invalid processes. */
		if (!IS_VALID(p))
			continue;

		/* Alarm has expired. */
		if ((p->alarm) && (p->alarm < ticks))
			p->alarm = 0, sndsig(p, SIGALRM);
	}

	/*
		Count the number of total tickets so that we
		can generate a random number between 0 and max_tickets -1
	*/
	for (p = FIRST_PROC; p <= LAST_PROC; p++)
	{
    if (p->state != PROC_READY)
      continue;

		max_tickets += p->tickets;
	}

  selected_ticket = generate_rand_number();

  /* Choose a process to run next. */
	next = IDLE;
	for (p = FIRST_PROC; p <= LAST_PROC; p++)
	{
		/* Skip non-ready process. */
		if (p->state != PROC_READY)
			continue;

		ticket_sum += p->tickets;

		/*
		 * Finds the process with
		 * the winning ticket
		 */
		if (ticket_sum > selected_ticket)
		{
			next = p;
			break;
		}
	}

	/* Switch to next process. */
	ticket_sum = 0; // Resets ticket_sum
	max_tickets = 0; // Resets max_tickets
	next->priority = PRIO_USER;
	next->state = PROC_RUNNING;
	next->counter = PROC_QUANTUM;
	if (curr_proc != next)
  /* Switches context and makes the next process be executed */
		switch_to(next);
}
