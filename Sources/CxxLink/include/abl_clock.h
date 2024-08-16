#pragma once

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct abl_clock {
    void *impl;
} abl_clock;

abl_clock abl_clock_create(void);

void abl_clock_destroy(abl_clock clock);

uint64_t abl_clock_ticks(abl_clock clock);

#ifdef __cplusplus
}
#endif
