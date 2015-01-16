//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCStopwatch.h"

typedef NS_ENUM(NSUInteger, TBCStopwatchState) {
    TBCStopwatchNotStarted,
    TBCStopwatchRunning,
    TBCStopwatchPaused,
};

@implementation TBCStopwatch {
@private
    dispatch_queue_t _queue;
    TBCStopwatchBlock _block;
    
    TBCStopwatchState _state;
    NSTimeInterval _durationOfPreviousChunks;
    NSDate *_chunkStartDate;
}

- (instancetype)initWithBlock:(TBCStopwatchBlock)block {
    return [self initWithQueue:nil block:block];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue block:(TBCStopwatchBlock)block {
    NSParameterAssert(block);

    if (!queue) {
        queue = dispatch_get_main_queue();
    }

    self = [super init];
    if (self) {
        _queue = queue;
        _block = [block ?: ^(NSTimeInterval i){} copy];
        _firesOnDealloc = YES;
        
        _state = TBCStopwatchNotStarted;
        _durationOfPreviousChunks = 0;
        _chunkStartDate = nil;
    }
    return self;
}

- (void)dealloc {
    if (_firesOnDealloc && _state != TBCStopwatchNotStarted) {
        [self stop];
    }
}

- (void)start {
    NSAssert(_state == TBCStopwatchNotStarted, @"Attempt to start TBCIntervalTimer that is already running");
    _durationOfPreviousChunks = 0;
    [self tbc_beginChunk];
}

- (void)pause {
    NSAssert(_state != TBCStopwatchNotStarted, @"Attempt to pause TBCIntervalTimer that was not started");
    
    if (_state == TBCStopwatchRunning) {
        [self tbc_endChunk];
    }
}

- (void)resume {
    NSAssert(_state != TBCStopwatchNotStarted, @"Attempt to resume TBCIntervalTimer that was not started");
    
    if (_state == TBCStopwatchPaused) {
        [self tbc_beginChunk];
    }
}

- (void)stop {
    NSAssert(_state != TBCStopwatchNotStarted, @"Attempt to stop TBCIntervalTimer that was not started");
    if (_state == TBCStopwatchNotStarted) {
        return;
    }
    
    if (_state == TBCStopwatchRunning) {
        [self tbc_endChunk];
    }

    NSTimeInterval resultInterval = _durationOfPreviousChunks;
    _state = TBCStopwatchNotStarted;
    
    TBCStopwatchBlock sblock = _block;
    dispatch_async(_queue, ^{
        sblock(resultInterval);
    });
}

- (void)cancel {
    _state = TBCStopwatchNotStarted;
}

- (void)tbc_beginChunk {
    NSAssert(_state != TBCStopwatchRunning, @"");
    
    _chunkStartDate = [NSDate date];
    _state = TBCStopwatchRunning;
}

- (void)tbc_endChunk {
    NSAssert(_state == TBCStopwatchRunning, @"");
    
    NSTimeInterval chunkInterval = [[NSDate date] timeIntervalSinceDate:_chunkStartDate];
    _durationOfPreviousChunks += chunkInterval;
    _state = TBCStopwatchPaused;
}

@end
