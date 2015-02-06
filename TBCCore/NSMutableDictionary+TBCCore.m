//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "NSMutableDictionary+TBCCore.h"

#import "TBCTypeSafety.h"

@implementation NSMutableDictionary(TBCCore)

- (id)tbc_extractObjectForKey:(id)aKey {
    return [self tbc_extractObjectForKey:aKey expectingValue:YES withTransformationBlock:nil];
}

- (id)tbc_extractObjectIfExistsForKey:(id)aKey {
    return [self tbc_extractObjectForKey:aKey expectingValue:NO withTransformationBlock:nil];
}

- (id)tbc_extractObjectForKey:(id)aKey withTransformationBlock:(id(^)(id object))block {
    return [self tbc_extractObjectForKey:aKey expectingValue:YES withTransformationBlock:block];
}

- (id)tbc_extractObjectIfExistsForKey:(id)aKey withTransformationBlock:(id(^)(id object))block {
    return [self tbc_extractObjectForKey:aKey expectingValue:NO withTransformationBlock:block];
}

/**
 *  Removes and returns the value associated with a given key, optionally transformed by a given block.
 *
 *  Intended to encapsulate most of the assertions and NSNull handling involved in consuming values in an externally provided dictionary.
 *
 *  @note Treats values of NSNull as if there was no value associated with the key.
 *
 *  @param aKey        The key for which to return the corresponding value.
 *  @param expectValue Asserts that a value (not NSNull) exists at the given key if YES.
 *  @param block       An optional block that is used to transform the associated value before returning it.
 *                     The block should return nil to indicate there was an error transforming the value (for example, if a string date didn't conform to an expected format).
 *                     The block will not be called if there is no value (or NSNull).
 */

- (id)tbc_extractObjectForKey:(id)aKey expectingValue:(BOOL)expectValue withTransformationBlock:(id(^)(id object))block {
    id object = TBCEnsureNotNSNull([self objectForKey:aKey]);
    [self removeObjectForKey:aKey];
    if (expectValue) {
        NSAssert(object != nil, @"extract failed to find value at key %@", aKey);
    }
    
    id result;
    if (block && object) {
        result = block(object);
        NSAssert(result != nil, @"transformation block returned nil from %@", object);
    } else {
        result = object;
    }
    return result;
}

@end
