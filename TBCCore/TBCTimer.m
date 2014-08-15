//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCTimer.h"

#import "TBCDispatch.h"


NSTimeInterval const TBCTimerIntervalForever = INFINITY;


@implementation TBCTimer {
@private
    dispatch_block_t _block;
    dispatch_source_t _source;
}

- (id)initWithFireDate:(NSDate *)fireDate interval:(NSTimeInterval)interval leeway:(NSTimeInterval)leeway queue:(dispatch_queue_t)queue block:(dispatch_block_t)block {
    NSParameterAssert(interval > 0);
    NSParameterAssert(block);

    self = [super init];
    if (self) {
        _block = [block ?: ^{} copy];
        _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue ?: dispatch_get_main_queue());

        dispatch_time_t sourceStart = dispatch_time(DISPATCH_TIME_NOW, [fireDate timeIntervalSinceNow] * NSEC_PER_SEC);
        uint64_t sourceInterval = tbc_dispatch_time_interval(interval) ?: DISPATCH_TIME_FOREVER;
        uint64_t sourceLeeway = tbc_dispatch_time_interval(leeway);
        dispatch_source_set_timer(_source, sourceStart, sourceInterval, sourceLeeway);
        BOOL repeating = sourceInterval != DISPATCH_TIME_FOREVER;
        
        __weak __typeof__(self) wself = self;
        dispatch_source_set_event_handler(_source, ^{
            __strong __typeof__(self) sself = wself;
            if (!sself) {
                return;
            }
            if (!repeating) {
                dispatch_source_cancel(sself->_source);
            }
            sself->_block();
        });
        
        dispatch_resume(_source);
    }
    return self;
}

- (id)initWithFireDate:(NSDate *)fireDate leeway:(NSTimeInterval)leeway block:(dispatch_block_t)block {
    return [self initWithFireDate:fireDate interval:TBCTimerIntervalForever leeway:leeway queue:nil block:block];
}

- (id)initWithFireDate:(NSDate *)fireDate leeway:(NSTimeInterval)leeway queue:(dispatch_queue_t)queue block:(dispatch_block_t)block {
    return [self initWithFireDate:fireDate interval:TBCTimerIntervalForever leeway:leeway queue:queue block:block];
}

- (id)initWithFireDate:(NSDate *)fireDate interval:(NSTimeInterval)interval leeway:(NSTimeInterval)leeway block:(dispatch_block_t)block {
    return [self initWithFireDate:fireDate interval:interval leeway:leeway queue:nil block:block];
}

- (void)dealloc {
    tbc_dispatch_release(_source);
}

- (void)invalidate {
    dispatch_source_cancel(_source);
}

@end
