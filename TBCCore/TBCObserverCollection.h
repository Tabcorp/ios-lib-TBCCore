//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


@interface TBCObserverCollection<ObserverType> : NSObject

- (instancetype __nonnull)init;
- (instancetype __nonnull)initWithCapacity:(NSUInteger)capacity NS_DESIGNATED_INITIALIZER;

- (void)addObserver:(ObserverType __nonnull)observer;
- (void)removeObserver:(ObserverType __nonnull)observer;

- (void)compact;

- (void)notifyObserversWithBlock:(void(^ __nonnull)(ObserverType __nonnull observer))block;

@end
