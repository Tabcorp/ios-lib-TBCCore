//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


#define TBC_STRINGIFY(s) TBC_STRINGIFY_(s)
#define TBC_STRINGIFY_(s) #s


#if __has_feature(objc_generics)
# define TBC_ARRAY(ValueType) NSArray<ValueType>
# define TBC_MUTABLEARRAY(ValueType) NSMutableArray<ValueType>
# define TBC_SET(ValueType) NSSet<ValueType>
# define TBC_MUTABLESET(ValueType) NSMutableSet<ValueType>
# define TBC_HASHTABLE(ValueType) NSHashTable<ValueType>
# define TBC_DICTIONARY(KeyType, ValueType) NSDictionary<KeyType, ValueType>
# define TBC_MUTABLEDICTIONARY(KeyType, ValueType) NSMutableDictionary<KeyType, ValueType>
# define TBC_MAPTABLE(KeyType, ValueType) NSMapTable<KeyType, ValueType>
#else
# define TBC_ARRAY(ValueType) NSArray
# define TBC_MUTABLEARRAY(ValueType) NSMutableArray
# define TBC_SET(ValueType) NSSet
# define TBC_MUTABLESET(ValueType) NSMutableSet
# define TBC_HASHTABLE(ValueType) NSHashTable
# define TBC_DICTIONARY(KeyType, ValueType) NSDictionary
# define TBC_MUTABLEDICTIONARY(KeyType, ValueType) NSMutableDictionary
# define TBC_MAPTABLE(KeyType, ValueType) NSMapTable
#endif
