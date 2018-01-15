//  Copyright © 2018 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TBCKVOObservationBlock)(NSDictionary<NSKeyValueChangeKey,id> * change);

@interface TBCKVOObservation : NSObject

+ (instancetype)observationWithObject:(NSObject *)object keyPath:(NSString *)keyPath block:(TBCKVOObservationBlock)block;
+ (instancetype)observationWithObject:(NSObject *)object selector:(SEL)selector block:(TBCKVOObservationBlock)block;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObject:(NSObject *)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(TBCKVOObservationBlock)block __attribute((objc_designated_initializer));
- (instancetype)initWithObject:(NSObject *)object keyPath:(NSString *)keyPath block:(TBCKVOObservationBlock)block;
- (instancetype)initWithObject:(NSObject *)object selector:(SEL)selector options:(NSKeyValueObservingOptions)options block:(TBCKVOObservationBlock)block;
- (instancetype)initWithObject:(NSObject *)object selector:(SEL)selector block:(TBCKVOObservationBlock)block;

- (void)removeObservation;

@end

NS_ASSUME_NONNULL_END
