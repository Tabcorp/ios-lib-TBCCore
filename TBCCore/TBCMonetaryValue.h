//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TBCMonetaryValue : NSObject<NSCopying>

+ (id<NSDecimalNumberBehaviors>)defaultBehavior;
+ (void)setDefaultBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)monetaryValueWithUnspecifiedCurrencyCodeAndAmount:(NSDecimalNumber *)amount;
- (instancetype)initWithUnspecifiedCurrencyCodeAndAmount:(NSDecimalNumber *)amount NS_DESIGNATED_INITIALIZER;

+ (instancetype)monetaryValueWithCurrencyCode:(NSString * __nullable)currencyCode amount:(NSDecimalNumber *)amount;
- (instancetype)initWithCurrencyCode:(NSString * __nullable)currencyCode amount:(NSDecimalNumber *)amount NS_DESIGNATED_INITIALIZER;

@property (nonatomic,copy,readonly,nullable) NSString *currencyCode;
@property (nonatomic,copy,readonly) NSDecimalNumber *amount;

- (TBCMonetaryValue *)monetaryValueByAdding:(TBCMonetaryValue *)value;
- (TBCMonetaryValue *)monetaryValueByAdding:(TBCMonetaryValue *)value withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

- (TBCMonetaryValue *)monetaryValueBySubtracting:(TBCMonetaryValue *)value;
- (TBCMonetaryValue *)monetaryValueBySubtracting:(TBCMonetaryValue *)value withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

- (TBCMonetaryValue *)monetaryValueByMultiplyingBy:(NSDecimalNumber *)multiplier;
- (TBCMonetaryValue *)monetaryValueByMultiplyingBy:(NSDecimalNumber *)multiplier withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

- (TBCMonetaryValue *)monetaryValueByDividingBy:(NSDecimalNumber *)divisor;
- (TBCMonetaryValue *)monetaryValueByDividingBy:(NSDecimalNumber *)divisor withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

- (TBCMonetaryValue *)monetaryValueByRoundingAccordingToBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface TBCPercentageValue : NSObject<NSCopying>

+ (instancetype)zero;
+ (instancetype)oneHundredPercent;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)percentageValueWithDecimalNumber:(NSDecimalNumber *)percentage;
- (instancetype)initWithDecimalNumber:(NSDecimalNumber *)percentage NS_DESIGNATED_INITIALIZER;

@property (nonatomic,copy,readonly) NSDecimalNumber *percentage;

- (TBCPercentageValue *)percentageValueByMultiplyingBy:(NSDecimalNumber *)multiplier;
- (TBCPercentageValue *)percentageValueByMultiplyingBy:(NSDecimalNumber *)multiplier withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

- (TBCPercentageValue *)percentageValueByDividingBy:(NSDecimalNumber *)divisor;
- (TBCPercentageValue *)percentageValueByDividingBy:(NSDecimalNumber *)divisor withBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

- (TBCPercentageValue *)percentageValueByRoundingAccordingToBehavior:(id<NSDecimalNumberBehaviors> __nullable)behavior;

@end

NS_ASSUME_NONNULL_END
