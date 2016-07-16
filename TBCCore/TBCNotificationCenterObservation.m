//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCNotificationCenterObservation.h"

@implementation TBCNotificationCenterObservation {
    TBCNotificationCenterObservationBlock _block;
    NSString * _name;
    __weak NSObject * _object;
    BOOL _observing;
}

+ (instancetype)observationWithNotificationName:(NSString *)name object:(NSObject *)object block:(TBCNotificationCenterObservationBlock)block {
    return [[self alloc] initWithNotificationName:name object:object block:block];
}

+ (instancetype)observationWithNotificationName:(NSString *)name block:(TBCNotificationCenterObservationBlock)block {
    return [[self alloc] initWithNotificationName:name block:block];
}

- (instancetype)initWithNotificationName:(NSString *)name object:(NSObject *)object block:(TBCNotificationCenterObservationBlock)block {
    self = [super init];
    if (self) {
        _name = name.copy;
        _object = object;
        _block = [block copy];
        _observing = YES;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tbc_notification:) name:name object:object];
    }
    return self;
}

- (instancetype)initWithNotificationName:(NSString *)name block:(TBCNotificationCenterObservationBlock)block {
    return [self initWithNotificationName:name object:nil block:block];
}

- (void)dealloc {
    if (_observing) {
        [self removeObservation];
    }
}

- (void)removeObservation {
    NSAssert(_observing, @"removeObservation called while not observing");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:_object];
    _observing = NO;
}

- (void)tbc_notification:(NSNotification *)notification {
    if (_block) {
        _block(notification);
    }
}

@end
