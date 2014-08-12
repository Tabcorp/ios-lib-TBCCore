//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCDelayedDispatcher.h"
#import "TBCDispatch.h"


NSTimeInterval const TBCDelayedDispatcherDelayForever = INFINITY;


@implementation TBCDelayedDispatcher {
@private
    dispatch_queue_t _queue;
    dispatch_block_t _block;
    uint64_t _timerDelay;
    dispatch_source_t _timer;
    uint64_t _maximumTimerDelay;
    dispatch_source_t _maximumTimer;
    bool _maximumTimerArmed;
}

- (instancetype)init {
    return [self initWithDelay:TBCDelayedDispatcherDelayForever maximumDelay:TBCDelayedDispatcherDelayForever queue:nil block:nil];
}
- (instancetype)initWithDelay:(NSTimeInterval)delay maximumDelay:(NSTimeInterval)maximumDelay block:(dispatch_block_t)block {
    return [self initWithDelay:delay maximumDelay:maximumDelay queue:nil block:block];
}
- (instancetype)initWithDelay:(NSTimeInterval)delay maximumDelay:(NSTimeInterval)maximumDelay queue:(dispatch_queue_t)queue block:(dispatch_block_t)block {
    NSParameterAssert(block);
    if (!queue) {
        queue = dispatch_get_main_queue();
    }

    if ((self = [super init])) {
        tbc_dispatch_retain(_queue = queue);
        _block = [block ?: ^{} copy];

        if (!isfinite(delay) || delay < 0 || delay >= (DBL_MAX / NSEC_PER_SEC)) {
            _timerDelay = DISPATCH_TIME_FOREVER;
        } else {
            _timerDelay = delay * NSEC_PER_SEC;
        }
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

        if (!isfinite(maximumDelay) || maximumDelay < 0 || maximumDelay >= (DBL_MAX / NSEC_PER_SEC)) {
            _maximumTimerDelay = DISPATCH_TIME_FOREVER;
        } else {
            _maximumTimerDelay = maximumDelay * NSEC_PER_SEC;
        }
        _maximumTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

        dispatch_source_set_timer(_timer, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER);
        dispatch_source_set_timer(_maximumTimer, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER);

        __typeof__(self) __weak const wself = self;
        dispatch_block_t const handler = ^{
            __typeof__(self) const sself = wself;
            if (!sself) {
                return;
            }

            dispatch_source_set_timer(sself->_timer, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER);
            dispatch_source_set_timer(sself->_maximumTimer, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER);
            sself->_maximumTimerArmed = false;

            sself->_block();
        };

        dispatch_source_set_event_handler(_timer, handler);
        dispatch_source_set_event_handler(_maximumTimer, handler);

        dispatch_resume(_timer);
        dispatch_resume(_maximumTimer);
    }
    return self;
}

- (void)dealloc {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    if (_maximumTimer) {
        dispatch_source_cancel(_maximumTimer);
    }

    tbc_dispatch_release(_timer);
    tbc_dispatch_release(_maximumTimer);
    tbc_dispatch_release(_queue);
}


- (void)arm {
    uint64_t const leeway = 50 * NSEC_PER_MSEC;
    if (_timerDelay != DISPATCH_TIME_FOREVER) {
        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, _timerDelay), DISPATCH_TIME_FOREVER, leeway);
    }
    if (!_maximumTimerArmed) {
        if (_maximumTimerDelay != DISPATCH_TIME_FOREVER) {
            dispatch_source_set_timer(_maximumTimer, dispatch_time(DISPATCH_TIME_NOW, _maximumTimerDelay), DISPATCH_TIME_FOREVER, leeway);
        }
        _maximumTimerArmed = true;
    }
}

- (void)disarm {
    dispatch_source_set_timer(_timer, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER);
    dispatch_source_set_timer(_maximumTimer, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER, DISPATCH_TIME_FOREVER);
    _maximumTimerArmed = false;
}

@end
