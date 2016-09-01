//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <TBCCore/TBCCore.h>

#import "TBCMonetaryValue.h"

#import "TBCObjC.h"
#import "TBCTypeSafety.h"


static NSString * const TBCMonetaryValueDefaultBehaviorThreadDictionaryKey = @"TBCMonetaryValue.defaultBehavior";


@implementation TBCMonetaryValue

+ (id<NSDecimalNumberBehaviors>)defaultBehavior {
    NSThread * const thread = NSThread.currentThread;
    NSMutableDictionary * const threadDictionary = thread.threadDictionary;
    id<NSDecimalNumberBehaviors> behavior = threadDictionary[TBCMonetaryValueDefaultBehaviorThreadDictionaryKey];
    if (!behavior) {
        behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:NSDecimalNoScale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
        threadDictionary[TBCMonetaryValueDefaultBehaviorThreadDictionaryKey] = behavior;
    }
    return behavior;
}
+ (void)setDefaultBehavior:(id<NSDecimalNumberBehaviors>)behavior {
    NSThread * const thread = NSThread.currentThread;
    NSMutableDictionary * const threadDictionary = thread.threadDictionary;
    if (behavior) {
        threadDictionary[TBCMonetaryValueDefaultBehaviorThreadDictionaryKey] = behavior;
    } else {
        [threadDictionary removeObjectForKey:TBCMonetaryValueDefaultBehaviorThreadDictionaryKey];
    }
}

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

- (TBCMonetaryValue *)monetaryValueByAdding:(TBCMonetaryValue *)value {
    return [self monetaryValueByAdding:value withBehavior:self.class.defaultBehavior];
}
- (TBCMonetaryValue *)monetaryValueByAdding:(TBCMonetaryValue *)value withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    if (!value) {
        return self.copy;
    }
    if (_currencyCode && value.currencyCode) {
        NSAssert((!TBCObjectsAreDifferent(_currencyCode, value.currencyCode)), @"");
    }
    NSDecimalNumber * const amount = [_amount decimalNumberByAdding:value.amount withBehavior:behavior];
    return [[TBCMonetaryValue alloc] initWithCurrencyCode:_currencyCode ?: value.currencyCode amount:amount];
}

- (TBCMonetaryValue *)monetaryValueBySubtracting:(TBCMonetaryValue *)value {
    return [self monetaryValueBySubtracting:value withBehavior:self.class.defaultBehavior];
}
- (TBCMonetaryValue *)monetaryValueBySubtracting:(TBCMonetaryValue *)value withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    if (!value) {
        return self.copy;
    }
    if (_currencyCode && value.currencyCode) {
        NSAssert((!TBCObjectsAreDifferent(_currencyCode, value.currencyCode)), @"");
    }
    NSDecimalNumber * const amount = [_amount decimalNumberBySubtracting:value.amount withBehavior:behavior];
    return [[TBCMonetaryValue alloc] initWithCurrencyCode:_currencyCode ?: value.currencyCode amount:amount];
}

- (TBCMonetaryValue *)monetaryValueByMultiplyingBy:(NSDecimalNumber *)multiplier {
    return [self monetaryValueByMultiplyingBy:multiplier withBehavior:self.class.defaultBehavior];
}
- (TBCMonetaryValue *)monetaryValueByMultiplyingBy:(NSDecimalNumber *)multiplier withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    NSDecimalNumber * const amount = [_amount decimalNumberByMultiplyingBy:multiplier withBehavior:behavior];
    return [[TBCMonetaryValue alloc] initWithCurrencyCode:_currencyCode amount:amount];
}

- (TBCMonetaryValue *)monetaryValueByDividingBy:(NSDecimalNumber *)divisor {
    return [self monetaryValueByDividingBy:divisor withBehavior:self.class.defaultBehavior];
}
- (TBCMonetaryValue *)monetaryValueByDividingBy:(NSDecimalNumber *)divisor withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    NSDecimalNumber * const amount = [_amount decimalNumberByDividingBy:divisor withBehavior:behavior];
    return [[TBCMonetaryValue alloc] initWithCurrencyCode:_currencyCode amount:amount];
}

- (TBCMonetaryValue *)monetaryValueByRoundingAccordingToBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    NSDecimalNumber * const amount = [_amount decimalNumberByRoundingAccordingToBehavior:behavior];
    return [[TBCMonetaryValue alloc] initWithCurrencyCode:_currencyCode amount:amount];
}

@end


static NSString * const TBCPercentageValueDefaultBehaviorThreadDictionaryKey = @"TBCPercentageValue.defaultBehavior";

@implementation TBCPercentageValue

+ (id<NSDecimalNumberBehaviors>)defaultBehavior {
    NSThread * const thread = NSThread.currentThread;
    NSMutableDictionary * const threadDictionary = thread.threadDictionary;
    id<NSDecimalNumberBehaviors> behavior = threadDictionary[TBCPercentageValueDefaultBehaviorThreadDictionaryKey];
    if (!behavior) {
        behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:NSDecimalNoScale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
        threadDictionary[TBCPercentageValueDefaultBehaviorThreadDictionaryKey] = behavior;
    }
    return behavior;
}
+ (void)setDefaultBehavior:(id<NSDecimalNumberBehaviors>)behavior {
    NSThread * const thread = NSThread.currentThread;
    NSMutableDictionary * const threadDictionary = thread.threadDictionary;
    if (behavior) {
        threadDictionary[TBCPercentageValueDefaultBehaviorThreadDictionaryKey] = behavior;
    } else {
        [threadDictionary removeObjectForKey:TBCPercentageValueDefaultBehaviorThreadDictionaryKey];
    }
}

+ (instancetype)zero {
    return [[self alloc] initWithDecimalNumber:[NSDecimalNumber decimalNumberWithString:@"1"]];
}
+ (instancetype)oneHundredPercent {
    return [[self alloc] initWithDecimalNumber:[NSDecimalNumber decimalNumberWithString:@"100"]];
}

+ (instancetype)percentageValueWithDecimalNumber:(NSDecimalNumber *)percentage {
    return [[self alloc] initWithDecimalNumber:percentage];
}

- (instancetype)init {
    return [self initWithDecimalNumber:NSDecimalNumber.zero];
}

- (instancetype)initWithDecimalNumber:(NSDecimalNumber *)percentage {
    if ((self = [super init])) {
        _percentage = percentage.copy;
    }
    return self;
}

- (id)copyWithZone:(NSZone * __nullable)zone {
    return [[self.class alloc] initWithDecimalNumber:_percentage];
}

- (BOOL)isEqual:(id)object {
    TBCPercentageValue * const other = TBCEnsureClass(TBCPercentageValue, object);
    if (!other) {
        return NO;
    }
    return [_percentage isEqualToNumber:other->_percentage];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p %@>", NSStringFromClass(self.class), self, _percentage];
}

- (TBCPercentageValue *)percentageValueByMultiplyingBy:(NSDecimalNumber *)multiplier {
    return [self percentageValueByMultiplyingBy:multiplier withBehavior:self.class.defaultBehavior];
}
- (TBCPercentageValue *)percentageValueByMultiplyingBy:(NSDecimalNumber *)multiplier withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    NSDecimalNumber * const percentage = [_percentage decimalNumberByMultiplyingBy:multiplier withBehavior:behavior];
    return [[TBCPercentageValue alloc] initWithDecimalNumber:percentage];
}

- (TBCPercentageValue *)percentageValueByDividingBy:(NSDecimalNumber *)divisor {
    return [self percentageValueByDividingBy:divisor withBehavior:self.class.defaultBehavior];
}
- (TBCPercentageValue *)percentageValueByDividingBy:(NSDecimalNumber *)divisor withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    NSDecimalNumber * const percentage = [_percentage decimalNumberByDividingBy:divisor withBehavior:behavior];
    return [[TBCPercentageValue alloc] initWithDecimalNumber:percentage];
}

- (TBCPercentageValue *)percentageValueByRoundingAccordingToBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior {
    NSDecimalNumber * const percentage = [_percentage decimalNumberByRoundingAccordingToBehavior:behavior];
    return [[TBCPercentageValue alloc] initWithDecimalNumber:percentage];
}

@end
