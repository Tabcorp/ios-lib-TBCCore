//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCDelayedDispatcher.h>


@interface TBCDelayedDispatcherTests : XCTestCase
@end

@implementation TBCDelayedDispatcherTests

- (void)testDelay {
    NSUInteger __block count = 0;

    TBCDelayedDispatcher * const d = [[TBCDelayedDispatcher alloc] initWithDelay:1 maximumDelay:TBCDelayedDispatcherDelayForever block:^{
        ++count;
    }];
    XCTAssertEqual(count, 0U);

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.5]];

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.5]];

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.5]];

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.5]];

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    XCTAssertEqual(count, 1U);

    (void)d;

    XCTAssertEqual(count, 1U);
}

- (void)testMaximumDelay {
    NSUInteger __block count = 0;

    TBCDelayedDispatcher * const d = [[TBCDelayedDispatcher alloc] initWithDelay:3 maximumDelay:7 block:^{
        ++count;
    }];
    XCTAssertEqual(count, 0U);

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    XCTAssertEqual(count, 0U);

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    XCTAssertEqual(count, 0U);

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    XCTAssertEqual(count, 0U);

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    XCTAssertEqual(count, 1U);

    (void)d;

    XCTAssertEqual(count, 1U);
}

- (void)testReallyBigDelay {
    NSUInteger __block count = 0;

    // 1.7976931348623156e299 is DBL_MAX, 1.7976931348623155e299 is "a bit less than that" :-)
    TBCDelayedDispatcher * const d = [[TBCDelayedDispatcher alloc] initWithDelay:1.7976931348623155e299 maximumDelay:TBCDelayedDispatcherDelayForever block:^{
        ++count;
    }];
    XCTAssertEqual(count, 0U);

    [d arm];
    XCTAssertEqual(count, 0U);

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    XCTAssertEqual(count, 0U);

    (void)d;

    XCTAssertEqual(count, 0U);
}

@end
