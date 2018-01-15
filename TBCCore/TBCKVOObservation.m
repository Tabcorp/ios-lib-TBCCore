//  Copyright © 2018 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCKVOObservation.h"

@implementation TBCKVOObservation {
    __weak NSObject * _object;
    NSString * _keyPath;
    TBCKVOObservationBlock _block;
    BOOL _observing;
}

+ (instancetype)observationWithObject:(NSObject *)object keyPath:(NSString *)keyPath block:(TBCKVOObservationBlock)block {
    return [[self alloc] initWithObject:object keyPath:keyPath block:block];
}

+ (instancetype)observationWithObject:(NSObject *)object selector:(SEL)selector block:(TBCKVOObservationBlock)block {
    return [[self alloc] initWithObject:object selector:selector block:block];
}

- (instancetype)initWithObject:(NSObject *)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(TBCKVOObservationBlock)block {
    self = [super init];
    if (self) {
        _object = object;
        _keyPath = [keyPath copy];
        _block = [block copy];
        _observing = YES;

        [object addObserver:self forKeyPath:_keyPath options:options context:&_observing];
    }
    return self;
}

- (instancetype)initWithObject:(NSObject *)object keyPath:(NSString *)keyPath block:(TBCKVOObservationBlock)block {
    return [self initWithObject:object keyPath:keyPath options:0 block:block];
}

- (instancetype)initWithObject:(NSObject *)object selector:(SEL)selector options:(NSKeyValueObservingOptions)options block:(TBCKVOObservationBlock)block {
    return [self initWithObject:object keyPath:NSStringFromSelector(selector) options:options block:block];
}

- (instancetype)initWithObject:(NSObject *)object selector:(SEL)selector block:(TBCKVOObservationBlock)block {
    return [self initWithObject:object selector:selector options:0 block:block];
}

- (void)dealloc {
    if (_observing) {
        [self removeObservation];
    }
}

- (void)removeObservation {
    NSAssert(_observing, @"removeObservation called while not observing");
    NSObject * const object = _object;
    NSAssert(object, @"removeObservation called after `_object` deallocation");
    [object removeObserver:self forKeyPath:_keyPath];
    _observing = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _object && context == &_observing) {
        _block(change);
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
