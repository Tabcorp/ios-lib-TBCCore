//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

typedef BOOL (^TBCObjectPredicateBlock)(id object);

extern TBCObjectPredicateBlock _TBCObjectIsKindOfClass(const Class klass);
#define TBCObjectIsKindOfClass(type) (_TBCObjectIsKindOfClass([type class]))

extern TBCObjectPredicateBlock _TBCObjectIsMemberOfClass(const Class klass);
#define TBCObjectIsMemberOfClass(type) (_TBCObjectIsMemberOfClass([type class]))

extern TBCObjectPredicateBlock _TBCObjectConformsToProtocol(Protocol *protocol);
#define TBCObjectConformsToProtocol(protoname) (_TBCObjectConformsToProtocol(@protocol(protoname)))

#define DECLARE_TBCObjectPredicate(type) extern const TBCObjectPredicateBlock TBCObjectIs##type
DECLARE_TBCObjectPredicate(NSArray);
DECLARE_TBCObjectPredicate(NSDecimalNumber);
DECLARE_TBCObjectPredicate(NSDictionary);
DECLARE_TBCObjectPredicate(NSNumber);
DECLARE_TBCObjectPredicate(NSString);
#undef DECLARE_TBCObjectPredicate

extern const TBCObjectPredicateBlock TBCObjectIsNSStringNotEmpty;
extern const TBCObjectPredicateBlock TBCObjectIsNotNSNull;