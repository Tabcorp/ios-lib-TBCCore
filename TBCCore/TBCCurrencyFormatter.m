//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCCurrencyFormatter.h"


@interface TBCCurrencyFormatter : NSObject<TBCCurrencyFormatter>
@property (nonatomic,assign) NSUInteger maximumFractionDigits;
@end

@implementation TBCCurrencyFormatter {
@private
    NSNumberFormatter *_formatter;
}
- (instancetype)initWithNumberFormatter:(NSNumberFormatter *)formatter {
    if ((self = [super init])) {
        _formatter = formatter;
    }
    return self;
}
- (NSDecimalNumber *)numberFromString:(NSString *)string {
    return (NSDecimalNumber *)[_formatter numberFromString:string];
}
- (NSString *)stringFromNumber:(NSNumber *)string {
    return [_formatter stringFromNumber:string];
}
- (NSString *)stringForObjectValue:(id)object {
    return [_formatter stringForObjectValue:object];
}
- (NSUInteger)maximumFractionDigits {
    return [_formatter maximumFractionDigits];
}
- (void)setMaximumFractionDigits:(NSUInteger)maximumFractionDigits {
    return [_formatter setMaximumFractionDigits:maximumFractionDigits];
}
@end

extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForCurrencyCode(NSString *currencyCode) {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    currencyFormatter.currencyCode = currencyCode;
    currencyFormatter.generatesDecimalNumbers = YES;
    return [[TBCCurrencyFormatter alloc] initWithNumberFormatter:currencyFormatter];
}
extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForCurrencyCodeIntegralValues(NSString *currencyCode) {
    TBCCurrencyFormatter *currencyFormatter = TBCCurrencyFormatterForCurrencyCode(currencyCode);;
    currencyFormatter.maximumFractionDigits = 0;
    return currencyFormatter;
}

TBCCurrencyFormatter *TBCCurrencyFormatterForAustralianCurrency(void) {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    currencyFormatter.currencyCode = @"AUD";
    currencyFormatter.generatesDecimalNumbers = YES;
    return [[TBCCurrencyFormatter alloc] initWithNumberFormatter:currencyFormatter];
}

TBCCurrencyFormatter *TBCCurrencyFormatterForAustralianCurrencyWholeDollars(void) {
    TBCCurrencyFormatter *currencyFormatter = TBCCurrencyFormatterForAustralianCurrency();
    currencyFormatter.maximumFractionDigits = 0;
    return currencyFormatter;
}
