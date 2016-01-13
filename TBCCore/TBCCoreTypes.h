//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.


NS_ASSUME_NONNULL_BEGIN

#define TBCCoreDeclareGenericMapObjectToObjectBlock(name, intype, outtype) typedef outtype __nullable (^name)(intype object)
#define TBCCoreDeclareGenericMapObjectToNSIntegerBlock(name, intype) typedef NSInteger (^name)(intype object)

#define TBCCoreGenericMapObjectToObjectBlock(intype, outtype) outtype __nullable (^)(intype object)
#define TBCCoreGenericMapObjectAndIndexToObjectBlock(intype, outtype) outtype __nullable (^)(intype object, NSUInteger index)
#define TBCCoreGenericMapKeyAndObjectToObjectBlock(keytype, objecttype, outtype) outtype __nullable (^)(keytype key, objecttype object)
#define TBCCoreGenericMapObjectToNSIntegerBlock(intype) NSInteger (^)(intype object)
#define TBCCoreGenericMapObjectToNSUIntegerBlock(intype) NSUInteger (^)(intype object)
#define TBCCoreGenericMapObjectToArrayBlock(intype) NSArray * __nullable (^)(intype object)

#define TBCGenericObjectPredicateBlock(intype) BOOL (^)(intype object)
#define TBCGenericObjectObjectPredicateBlock(intype) BOOL (^)(intype a, intype b)

typedef id __nullable (^TBCCoreMapObjectToObjectBlock)(id object);
typedef id __nullable (^TBCCoreMapObjectAndIndexToObjectBlock)(id object, NSUInteger index);
typedef id __nullable (^TBCCoreMapKeyAndObjectToObjectBlock)(id key, id object);
typedef NSInteger (^TBCCoreMapObjectToNSIntegerBlock)(id object);
typedef NSUInteger (^TBCCoreMapObjectToNSUIntegerBlock)(id object);
typedef NSArray * __nullable (^TBCCoreMapObjectToArrayBlock)(id object);

typedef BOOL (^TBCObjectPredicateBlock)(id object);
typedef BOOL (^TBCObjectObjectPredicateBlock)(id a, id b);

NS_ASSUME_NONNULL_END
