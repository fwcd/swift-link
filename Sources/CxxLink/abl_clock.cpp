#include "abl_clock.h"
#include "ableton/Link.hpp"

extern "C" {

abl_clock abl_clock_create(void) {
    return {
        reinterpret_cast<void *>(new ableton::Link::Clock()),
    };
}

void abl_clock_destroy(abl_clock clock) {
    delete reinterpret_cast<ableton::Link::Clock *>(clock.impl);
}

uint64_t abl_clock_micros(abl_clock clock) {
    return reinterpret_cast<ableton::Link::Clock *>(clock.impl)->micros().count();
}

}
