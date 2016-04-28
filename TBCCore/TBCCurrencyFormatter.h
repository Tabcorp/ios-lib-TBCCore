//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


@protocol TBCCurrencyFormatter <NSObject>
- (NSDecimalNumber *)numberFromString:(NSString *)string;
- (NSString *)stringFromNumber:(NSNumber *)string;
- (NSString *)stringForObjectValue:(id)object;
@end

extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForCurrencyCode(NSString *currencyCode);
extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForCurrencyCodeIntegralValues(NSString *currencyCode);
extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForAustralianCurrency(void);
extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForAustralianCurrencyWholeDollars(void);
