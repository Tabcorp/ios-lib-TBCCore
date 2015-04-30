//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.


typedef id (^TBCCoreMapObjectToObjectBlock)(id object);
typedef id (^TBCCoreMapObjectAndIndexToObjectBlock)(id object, NSUInteger index);
typedef id (^TBCCoreMapKeyAndObjectToObjectBlock)(id<NSCopying> key, id object);
typedef NSUInteger (^TBCCoreMapObjectToNSUIntegerBlock)(id object);
typedef NSArray *(^TBCCoreMapObjectToArrayBlock)(id object);

typedef BOOL (^TBCObjectPredicateBlock)(id object);
typedef BOOL (^TBCObjectObjectPredicateBlock)(id a, id b);
