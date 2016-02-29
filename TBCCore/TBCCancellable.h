//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TBCCancellable <NSObject>
@property (nonatomic,assign,getter=shouldCancelOnDeallocation) BOOL cancelOnDeallocation;
@property (nonatomic,assign,getter=isCancelled) BOOL cancelled;
- (void)cancel;
@end

@interface TBCDispatchAsyncCancellable : NSObject<TBCCancellable>
- (instancetype)initWithBlock:(dispatch_block_t)block;
@end

@interface TBCCancellableAggregator : NSObject<TBCCancellable>
- (void)addCancellable:(id<TBCCancellable>)cancellable;
- (void)removeCancellable:(id<TBCCancellable>)cancellable;
@end

NS_ASSUME_NONNULL_END
