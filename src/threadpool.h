#ifndef __THREADPOOL_H__
#define __THREADPOOL_H__

#include <queue.h>
#include <pthread.h>

struct task
{
    void *(*function)(void*);
    void *argp;
};

typedef struct
{
    queue           *tasks;
    pthread_t       *threads;
    pthread_mutex_t  queue_mutex;
    pthread_mutex_t  destroy_mutex;
    pthread_cond_t   new_task_cond;
    bool             interrupt;
    bool             close;
    size_t           thread_number;
    size_t           started;
    size_t           terminated;
} threadpool;

threadpool *threadpool_create(const size_t);
void threadpool_destroy(threadpool *, bool);
bool threadpool_add(threadpool *, const struct task *);

#endif
