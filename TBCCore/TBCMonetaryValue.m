//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <TBCCore/TBCCore.h>

#import "TBCMonetaryValue.h"

#import "TBCObjC.h"
#import "TBCTypeSafety.h"


@implementation TBCMonetaryValue

+ (instancetype)monetaryValueWithUnspecifiedCurrencyCodeAndAmount:(NSDecimalNumber *)amount {
    return [[self alloc] initWithUnspecifiedCurrencyCodeAndAmount:amount];
}

+ (instancetype)monetaryValueWithCurrencyCode:(NSString * __nullable)currencyCode amount:(NSDecimalNumber *)amount {
    return [[self alloc] initWithCurrencyCode:currencyCode amount:amount];
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithUnspecifiedCurrencyCodeAndAmount:(NSDecimalNumber *)amount {
    if ((self = [super init])) {
        _amount = amount.copy ?: NSDecimalNumber.zero;
    }
    return self;
}

- (instancetype)initWithCurrencyCode:(NSString * __nullable)currencyCode amount:(NSDecimalNumber *)amount {
    if ((self = [super init])) {
        _currencyCode = currencyCode.copy;
        _amount = amount.copy ?: NSDecimalNumber.zero;
    }
    return self;
}

@synthesize currencyCode = _currencyCode;
@synthesize amount = _amount;

- (id)copyWithZone:(NSZone * __nullable)zone {
    return [[self.class alloc] initWithCurrencyCode:_currencyCode amount:_amount];
}

- (BOOL)isEqual:(id)object {
    TBCMonetaryValue * const other = TBCEnsureClass(TBCMonetaryValue, object);
    if (!other) {
        return NO;
    }
    if (TBCObjectsAreDifferent(_currencyCode, other->_currencyCode)) {
        return NO;
    }
    return [_amount isEqualToNumber:other->_amount];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p %@ %@>", NSStringFromClass(self.class), self, _currencyCode ?: @"???", _amount];
}

@end
