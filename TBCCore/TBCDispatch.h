//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <dispatch/dispatch.h>

static inline uint64_t tbc_dispatch_time_interval(NSTimeInterval timeInterval) {
    if (!isfinite(timeInterval) || timeInterval < 0 || timeInterval >= (DBL_MAX / NSEC_PER_SEC)) {
        return DISPATCH_TIME_FOREVER;
    } else {
        return timeInterval * NSEC_PER_SEC;
    }
}

static inline void tbc_dispatch_after_delay(NSTimeInterval delay, dispatch_queue_t queue, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, block);
}

static inline void tbc_dispatch_on_main_queue_after_delay(NSTimeInterval delay, dispatch_block_t block) {
    tbc_dispatch_after_delay(delay, dispatch_get_main_queue(), block);
}
