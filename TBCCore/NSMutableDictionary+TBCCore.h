//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary<KeyType, ObjectType> (TBCCore)

- (ObjectType __nullable)tbc_extractObjectForKey:(KeyType)aKey;
- (ObjectType __nullable)tbc_extractObjectIfExistsForKey:(KeyType)aKey;
- (id __nullable)tbc_extractObjectForKey:(KeyType)aKey withTransformationBlock:(id(^__nullable)(ObjectType object))block;
- (id __nullable)tbc_extractObjectIfExistsForKey:(KeyType)aKey withTransformationBlock:(id(^__nullable)(ObjectType object))block;

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
- (id __nullable)tbc_extractObjectForKey:(KeyType)aKey expectingValue:(BOOL)expectValue withTransformationBlock:(id(^__nullable)(ObjectType object))block;

- (NSInteger)tbc_extractIntegerIfExistsForKey:(KeyType)aKey withTransformationBlock:(NSInteger(^__nullable)(ObjectType object))block;
- (NSInteger)tbc_extractIntegerForKey:(KeyType)aKey withTransformationBlock:(NSInteger(^__nullable)(ObjectType object))block;
- (NSInteger)tbc_extractIntegerIfExistsForKey:(KeyType)aKey;
- (NSInteger)tbc_extractIntegerForKey:(KeyType)aKey;

- (NSString * __nullable)tbc_extractStringForKey:(KeyType)aKey;
- (NSString * __nullable)tbc_extractStringIfExistsForKey:(KeyType)aKey;

- (NSNumber * __nullable)tbc_extractNumberForKey:(KeyType)aKey;
- (NSNumber * __nullable)tbc_extractNumberIfExistsForKey:(KeyType)aKey;

@end

NS_ASSUME_NONNULL_END
