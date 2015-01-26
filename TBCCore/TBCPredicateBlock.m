//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCPredicateBlock.h"

TBCObjectPredicateBlock _TBCObjectIsKindOfClass(const Class klass) {
    return ^(id o){ return [o isKindOfClass:klass]; };
}

TBCObjectPredicateBlock _TBCObjectIsMemberOfClass(const Class klass) {
    return ^(id o){ return [o isMemberOfClass:klass]; };
}

TBCObjectPredicateBlock _TBCObjectConformsToProtocol(Protocol *protocol) {
    return ^(id o){ return [o conformsToProtocol:protocol]; };
}

#define DEFINE_TBCObjectPredicate(type) \
const TBCObjectPredicateBlock TBCObjectIs##type = ^(id o) {\
Class klass = [type class]; \
return [o isKindOfClass:klass]; \
}

DEFINE_TBCObjectPredicate(NSArray);
DEFINE_TBCObjectPredicate(NSDecimalNumber);
DEFINE_TBCObjectPredicate(NSDictionary);
DEFINE_TBCObjectPredicate(NSNumber);
DEFINE_TBCObjectPredicate(NSString);

#undef DEFINE_TBCObjectPredicate

const TBCObjectPredicateBlock TBCObjectIsNSStringNotEmpty = ^(id o) {
    return (BOOL)([o isKindOfClass:[NSString class]] && [o length] > 0);
};

const TBCObjectPredicateBlock TBCObjectIsNotNSNull = ^(id o) {
    return (BOOL)(o != [NSNull null]);
};
