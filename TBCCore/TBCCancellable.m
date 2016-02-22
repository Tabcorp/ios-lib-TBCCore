//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCCancellable.h"

#import <libkern/OSAtomic.h>

typedef NS_OPTIONS(uint32_t, TABCancellableFlags) {
    TBCCancellableCancelled = 0x1,
};

@implementation TBCCancellableAggregator {
@private
    uint32_t _flags;
    NSMutableArray<id<TBCCancellable>> *_cancellables;
}
@synthesize cancelOnDeallocation = _cancelOnDeallocation;
- (instancetype)init {
    self = [super init];
    if (self) {
        _cancellables = @[].mutableCopy;
        _cancelOnDeallocation = YES;
    }
    return self;
}
- (void)addCancellable:(id<TBCCancellable>)cancellable {
    NSAssert((_flags & TBCCancellableCancelled) == 0, @"Cannot add a cancellable to a cancelled cancellable aggregator");
    [_cancellables addObject:cancellable];
}
- (void)removeCancellable:(id<TBCCancellable>)cancellable {
    [_cancellables removeObject:cancellable];
}
@dynamic cancelled;
- (void)cancel {
    uint32_t const cancelledValue = TBCCancellableCancelled;
    if ((OSAtomicOr32OrigBarrier(cancelledValue, &_flags) & TBCCancellableCancelled) == 0) {
        NSArray<id<TBCCancellable>> *cancellables = _cancellables;
        _cancellables = nil;
        for (id<TBCCancellable> cancellable in cancellables) {
            [cancellable cancel];
        }
    }
}
- (BOOL)isCancelled {
    uint32_t const flags = OSAtomicOr32Barrier(0, &_flags);
    return !!(flags & TBCCancellableCancelled);
}
- (void)dealloc {
    if (_cancelOnDeallocation) {
        [self cancel];
    }
}
@end