//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCTimer.h>

@interface TBCTimerTests : XCTestCase
@end

@implementation TBCTimerTests

- (void)testRepeatingTimerDesignatedInit {
    NSDate *baseDate = [NSDate date];

    __block int count = 0;
    __unused TBCTimer *timer = [[TBCTimer alloc] initWithFireDate:[baseDate dateByAddingTimeInterval:0.5] interval:.25 leeway:0 queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) block:^{
        XCTAssertTrue(![NSThread isMainThread], @"");
        count++;
    }];
    //Fire times will be [0.5, 0.75, 1.0, 1.25, ...]

    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:0.25]];
    XCTAssertEqual(count, 0);

    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.6]];
    XCTAssertEqual(count, 1);

    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.8]];
    XCTAssertEqual(count, 2);

    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:1.1]];
    XCTAssertEqual(count, 3);

    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:1.3]];
    XCTAssertEqual(count, 4);
}

- (void)testRepeatingTimer {
    NSDate *baseDate = [NSDate date];
    
    __block int count = 0;
    __unused TBCTimer *timer = [[TBCTimer alloc] initWithFireDate:[baseDate dateByAddingTimeInterval:0.5] interval:.25 leeway:0 block:^{
        XCTAssertTrue([NSThread isMainThread], @"");
        count++;
    }];
    //Fire times will be [0.5, 0.75, 1.0, 1.25, ...]
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:0.25]];
    XCTAssertEqual(count, 0);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.6]];
    XCTAssertEqual(count, 1);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.8]];
    XCTAssertEqual(count, 2);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:1.1]];
    XCTAssertEqual(count, 3);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:1.3]];
    XCTAssertEqual(count, 4);
}

- (void)testSingleFireTimerDesignatedInit {
    NSDate *baseDate = [NSDate date];
    
    __block int count = 0;
    __unused TBCTimer *timer = [[TBCTimer alloc] initWithFireDate:[baseDate dateByAddingTimeInterval:0.5] interval:TBCTimerIntervalForever leeway:0 queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) block:^{
        XCTAssertTrue(![NSThread isMainThread], @"");
        count++;
    }];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:0.25]];
    XCTAssertEqual(count, 0);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.6]];
    XCTAssertEqual(count, 1);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.8]];
    XCTAssertEqual(count, 1);
}

- (void)testSingleFireTimer {
    NSDate *baseDate = [NSDate date];
    
    __block int count = 0;
    __unused TBCTimer *timer = [[TBCTimer alloc] initWithFireDate:[baseDate dateByAddingTimeInterval:0.5] leeway:0 queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) block:^{
        XCTAssertTrue(![NSThread isMainThread], @"");
        count++;
    }];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:0.25]];
    XCTAssertEqual(count, 0);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.6]];
    XCTAssertEqual(count, 1);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.8]];
    XCTAssertEqual(count, 1);
}

- (void)testSingleFireTimerConvenienceInit {
    NSDate *baseDate = [NSDate date];
    
    __block int count = 0;
    __unused TBCTimer *timer = [[TBCTimer alloc] initWithFireDate:[baseDate dateByAddingTimeInterval:0.5] leeway:0 block:^{
        XCTAssertTrue([NSThread isMainThread], @"");
        count++;
    }];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:0.25]];
    XCTAssertEqual(count, 0);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.6]];
    XCTAssertEqual(count, 1);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[baseDate dateByAddingTimeInterval:.8]];
    XCTAssertEqual(count, 1);
}

@end
