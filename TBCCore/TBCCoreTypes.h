//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.


NS_ASSUME_NONNULL_BEGIN

typedef id __nullable (^TBCCoreMapObjectToObjectBlock)(id object);
typedef id __nullable (^TBCCoreMapObjectAndIndexToObjectBlock)(id object, NSUInteger index);
typedef id __nullable (^TBCCoreMapKeyAndObjectToObjectBlock)(id<NSCopying> key, id object);
typedef NSUInteger (^TBCCoreMapObjectToNSUIntegerBlock)(id object);
typedef NSArray * __nullable (^TBCCoreMapObjectToArrayBlock)(id object);

typedef BOOL (^TBCObjectPredicateBlock)(id object);
typedef BOOL (^TBCObjectObjectPredicateBlock)(id a, id b);

NS_ASSUME_NONNULL_END
