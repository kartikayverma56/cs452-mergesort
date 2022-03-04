# Overview

In this project, we will implement a multithreaded version of the
mergesort algorithm using the pthread library. 

## Learning Objectives

- To gain more experience writing concurrent code.
- See how multithreading improves program performance.
- Explore the pthread library.

## Book References

Read these chapters carefully in order to prepare yourself for this project.

- [Intro to Threads](http://pages.cs.wisc.edu/~remzi/OSTEP/threads-intro.pdf)
- [Threads API](http://pages.cs.wisc.edu/~remzi/OSTEP/threads-api.pdf)

## APIs

I used the following APIs.

```c
int pthread_create(pthread_t *thread, const pthread_attr_t *attr, void *(*start_routine) (void *), void *arg);
```
According to its man page, the **pthread_create**() function creates "a new thread in the calling process.  The new thread starts execution by invoking start\_routine(); arg is passed as the sole argument of start\_routine()". You can create a *struct pthread_t* instance and pass its address into **pthread_create**(), as its first parameter, which represents the thread you are going to create. The second parameter *attr* describes some attributes of this thread, and for this assignment, you can juse use NULL, which indicates the thread is created with default attributes. The third parameter, *start_routine*(), is the function you want the newly created thread to run, this function must take one and only one parameter, which must be a *void* \* type pointer. This function returns a *void* \* type pointer. The four parameter is the argument, which is also known as the parameter, of this function - the one represented by the third parameter. For obvious reason, *arg* is a *void* \* type pointer.

```c
int pthread_join(pthread_t thread, void **retval);
```

According to its man page, The  **pthread_join**() function  "waits for the thread specified by thread to terminate. If that thread has already terminated, then **pthread_join**() returns immediately". After calling **pthread_create**() to create threads, you may want to wait for these threads to complete. And that is why you call **pthread_join**(). The first parameter of **pthread_join**(), is also the first parameter of **pthread_create**(), however, **pthread_create**() takes its address as the parameter, whereas **pthread_join**() takes the variable itself as the first parameter. In this assignment, you can set the second parameter, which is *retval*, which is a pointer. 

```c
void *memcpy(void *dest, const void *src, size_t n);
```

You may need to call **memcpy**() in your **merge**() function, so as to copy data from one array to another array.

```c
void *malloc(size_t size);
void free(void *ptr);
```

You may need to call **malloc**() to allocate memory in your **buildArgs**() function for the argument you are going to build. You can then free such memory chunks in your **parallel_mergesort**().

You may have heard of **pthread_exit**(), do not use it for this assignment, otherwise valgrind will report memory blocks "still reachable" issues. valgrind has trouble to track variables used in **pthread_exit**().

## Starter Code

The starter code looks like this:

xxx

You will be modifying the xxx.c file. You should not modify the xxx.h file.

## Implementation: Make Concurrent

You are required to implement the following 4 functions:

```c
void mergesort(int left, int right);
```

This function does the mergesort, with one single thread.

```c
void merge(int leftstart, int leftend, int rightstart, int rightend);
```

In a typical merge sort algorithm, the **mergesort**() function will eventually call **merge**(), which attempts to merge two already-sorted sub-arrays. You are highly recommended to write this **merge**() function as a recursive function.

```c
void * parallel_mergesort(void *arg);
```

This **parallel_mergesort**() function calls **mergesort**() as its base case. You are highly recommended to write this **parallel_mergesort**() recursively, using the pthread library functions. Note: the term recursion in the context of pthread, is slightly different from the term recursion you usually see. In the above **merge**() function, you call **merge**(), that is the typical recursion scenario you see in other recursive programs. In your **parallel_mergesort**(), you do not call **parallel_mergesort**() directly, instead, you call **pthread_create**(), which will then call **parallel_mergesort**(). In other words, in **merge**(), you call **merge**() directly, in **parallel_mergesort**(), you call **parallel_mergesort** indirectly.

```c
struct argument * buildArgs(int left, int right, int level);
```



You will convert the serial mergesort code to use multiple threads using the
pthread library. Your program should limit the number of levels it
uses via a command line argument: number of levels before cutting off new thread
generation. You must get a speedup of at least 2 with 4 or more cores
to get full credit on this project. Use n = 100,000,000 elements for
your testing.

You will need to update test-mazda.c to accept a number of levels as a
command line argument. The updated version of test-mazda should show
timing results for the serial mergesort when the number of levels is 0,
and show timing results for the parallel mergesort when the number of levels is larger than 0.

## Hints

- Do not modify the given serial_mergesort function. Instead create a
  new parallel_mergesort function that will call serial_mergesort as a
  base case.
- You can stop the recursion using the number of levels in the sorting
  tree or by number of threads. It is simpler to stop it by the number
  of levels.
- You are recommended to do this: let child threads call pthread_exit() to exit.
  parent thread itself doesn't need to call pthread_exit(). This is a recommendation
  but is not a requirement, however, later on when you work on the Cadillac (threads library) project,
  you will see the vaule of doing this.

## Submission  

Due Date: 23:59pm, March 15th, 2022. Late submissions will not be accepted/graded.
All grading will be executed on onyx.boisestate.edu.
Submissions that fail to compile on onyx will not be graded.

## Grading Rubric (for Undergraduate students)

- [70 pts] Make concurrent
  - [40 pts] You got a speedup of at least 2 with 4 or more cores 
  - [20 pts] test-mazda.c accepts a number levels as a command line argument
  - [10 pts] Correctly creates new threads
- [10 pts] Compiler warnings **ALL files**
  - Each compiler warning will result in a 3 point deduction.
  - You are not allowed to suppress warnings
  - You must build with the flags ```-Wall -Wextra -Wpointer-arith -Wstrict-prototypes -std=gnu89```
- [10 pts] Valgrind reports no memory leaks or read/write errors
  - As reported by **runval.sh**
  - This is a **PASS/FAIL** score. 1 read/write error or leaking 1
    byte will result in a zero for this section. There is no partial
    credit for this section.
- [10 pts] Documentation: README.md file (replace this current README.md with a new one using the template. Do not check in this current README.)

<!-- ## Grading Rubric (for Graduate students)

- [15 pts] Make concurrent
  - [5 pts] You got a speedup of at least 2 with 4 or more cores 
  - [5 pts] test-mazda.c accepts a number of threads (or a number of levels) as a command line argument
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
- [5 pts] Documentation: README.md file (replace this current README.md with a new one using the template. Do not check in this current README.) -->

## Related Exercises

For those who need more practices in C programming, you are recommended to solve these three problems using the merge sort algorithm.

Leetcode Problem 88 - Merge Sorted Array<br/>
Leetcode Problem 912 - Sort an Array<br/>
Leetcode Problem 148 - Sort List
