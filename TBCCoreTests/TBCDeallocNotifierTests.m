//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCCore.h>


@interface TBCDeallocNotifierTests : XCTestCase
@end

@implementation TBCDeallocNotifierTests

- (void)testSimple {
    NSObject *o = [[NSObject alloc] init];

    NSUInteger __block deallocHasBeenNotified = 0;

    id<TBCDeallocNotifier> notifier = TBCAttachDeallocNotifier(o, ^{
        deallocHasBeenNotified += 1;
    });

    XCTAssertEqual(deallocHasBeenNotified, 0U);

    o = nil;

    XCTAssertEqual(deallocHasBeenNotified, 1U);

    (void)notifier;
}

- (void)testDroppingNotifier {
    NSObject *o = [[NSObject alloc] init];

    NSUInteger __block deallocHasBeenNotified = 0;

    (void)TBCAttachDeallocNotifier(o, ^{
        deallocHasBeenNotified += 1;
    });

    XCTAssertEqual(deallocHasBeenNotified, 0U);

    o = nil;

    XCTAssertEqual(deallocHasBeenNotified, 0U);
}

- (void)testInvalidatingNotifier {
    NSObject *o = [[NSObject alloc] init];

    NSUInteger __block deallocHasBeenNotified = 0;

    id<TBCDeallocNotifier> notifier = TBCAttachDeallocNotifier(o, ^{
        deallocHasBeenNotified += 1;
    });

    XCTAssertEqual(deallocHasBeenNotified, 0U);

    [notifier invalidate];

    o = nil;

    XCTAssertEqual(deallocHasBeenNotified, 0U);
}

- (void)testInvalidatingNotifierAfterDealloc {
    NSObject *o = [[NSObject alloc] init];

    NSUInteger __block deallocHasBeenNotified = 0;

    id<TBCDeallocNotifier> notifier = TBCAttachDeallocNotifier(o, ^{
        deallocHasBeenNotified += 1;
    });

    XCTAssertEqual(deallocHasBeenNotified, 0U);

    o = nil;

    [notifier invalidate];

    XCTAssertEqual(deallocHasBeenNotified, 1U);
}

@end
