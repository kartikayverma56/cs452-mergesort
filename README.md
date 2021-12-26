# Overview

In this project, you will implement a multithreaded version of the
mergesort algorithm using the pthread library.  We have provided you
with a single-threaded version of mergesort that you will be
converting to use threads. Makefiles have been provided that you can
use directly.


## Learning Objectives

- Take a singled threaded algorithm and safely convert it to threaded
  to see a performance gain.
- To gain more experience writing concurrent code.
- Explore the pthread library


## Book References

Read these chapters carefully in order to prepare yourself for this project.

- [Intro to Threads](http://pages.cs.wisc.edu/~remzi/OSTEP/threads-intro.pdf)
- [Threads API](http://pages.cs.wisc.edu/~remzi/OSTEP/threads-api.pdf)

## Make Concurrent

Convert the serial mergesort code to use multiple threads using the
pthread library. Your program should limit the number of threads it
uses via a command line argument (for example, this could be the total
number of threads or number of levels before cutting off new thread
generation). You must get a speedup of at least 2 with 4 or more cores
to get full credit on this project.  Use n = 100,000,000 elements for
your testing.

NOTE: Just because you see a speedup of 2 does not guarantee full
credit. You can easily hardcode the number of threads and hardcode the
branches to get a speedup of 2. Your code MUST work with a variable
number of threads!  Simply getting a speedup of 2 does not indicate
that you did the assignment correctly.

You will need to update mazda-tests.c to accept a number of threads (or a number of levels) as a
command line argument. The updated version of mazda-tests should show
timing results for the serial mergesort when the number of threads is 1 (or when the number of levels is 0),
and show timing results for the parallel mergesort when the number of threads is larger than 1 (or when the number of levels is larger than 0).

## Implementation Analysis (Graduate students only)

Create a file named speedup.pdf (in the root directory) that analyses
the following two aspects of your mergesort solution.

**Efficiency** - Analyse the thread efficiency by examining how the
threaded implementation’s performance compares to the single threaded
implementation. Include a chart showing the speedups obtained with
varying number of threads (from 1 to 8). The speedups should be relative
to the serial mergesort. Please also note the number of cores on the
system that you are testing.  All tests cases should be run with 100
million elements. Please discuss whether the speedup increases
linearly as the number of threads are increased.

**Effectiveness** - Analyse the effectiveness of your threaded
implementation by comparing sorting time of your threaded solution to
the single threaded solution. Run both the serial mergesort and
threaded mergesort with elements in the range from 1,000,000 to
100,000,000, incrementing by 1M each time.  The threaded version of
merge sort should be run with 5 threads for all test cases.  Plot the
timing results in a line chart (google sheets or excel) and compare
the results. Please discuss whether the threaded version always
performs better than the serial version.

HINT: You can make the chart using any tool want (excel, google docs,
etc.) as long as you can create a pdf as your final
deliverable. Look in the folder example for what your chart should
look like. Also, it may be useful to add an option to mazda-tests.c to output 
timing results speedup calculation in a CSV format.  This will make it 
significantly easier to generate the required data for the implementation 
analysis report.

## Hints

- Do not modify the given serial_mergesort function. Instead create a
  new parallel_mergesort function that will call serial_mergesort as a
  base case.
- You can stop the recursion using the number of levels in the sorting
  tree or by number of threads. It is simpler to stop it by the number
  of levels.
- You are recommended to do this: let child threads call pthread_exit() to exit.
  parent thread itself doesn't need to call pthread_exit(). This is a recommendation
  but is not a requirement, however, later on when you work on project 5,
  you will see the vaule of doing this.

## Submission  

Due Date: 23:59pm, Feburary 8th, 2021. Late submissions will not be accepted/graded.
All grading will be executed on onyx.boisestate.edu.
Submissions that fail to compile on onyx will not be graded.

## Grading Rubric (for Undergraduate students)

- [30 pts] Make concurrent
  - [10 pts] You got a speedup of at least 2 with 4 or more cores 
  - [10 pts] mazda-tests.c accepts a number of threads (or a number of levels) as a command line argument
  - [10 pts] Correctly creates new threads
- [10 pts] Compiler warnings **ALL files**
  - Each compiler warning will result in a 3 point deduction.
  - You are not allowed to suppress warnings
  - You must build with the flags ```-Wall -Wextra -Wpointer-arith -Wstrict-prototypes -std=gnu89```
- [5 pts] Valgrind reports no memory leaks or read/write errors
  - As reported by **runval.sh**
  - This is a **PASS/FAIL** score. 1 read/write error or leaking 1
    byte will result in a zero for this section. There is no partial
    credit for this section.
- [5 pts] Documentation: README.md file (replace this current README.md with a new one using the template. Do not check in this current README.)

## Grading Rubric (for Graduate students)

- [15 pts] Make concurrent
  - [5 pts] You got a speedup of at least 2 with 4 or more cores 
  - [5 pts] mazda-tests.c accepts a number of threads (or a number of levels) as a command line argument
  - [5 pts] Correctly creates new threads
- [15 pts] Implementation analysis (speedup.pdf)
  - Score will reflect the quality of the analysis.
- [10 pts] Compiler warnings **ALL files**
  - Each compiler warning will result in a 3 point deduction.
  - You are not allowed to suppress warnings
  - You must build with the flags ```-Wall -Wextra -Wpointer-arith -Wstrict-prototypes -std=gnu89```
- [5 pts] Valgrind reports no memory leaks or read/write errors
  - As reported by **runval.sh**
  - This is a **PASS/FAIL** score. 1 read/write error or leaking 1
    byte will result in a zero for this section. There is no partial
    credit for this section.
- [5 pts] Documentation: README.md file (replace this current README.md with a new one using the template. Do not check in this current README.)
