//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCDispatch.h>

@interface TBCDispatchTests : XCTestCase
@end

@implementation TBCDispatchTests

- (void)testRetainNull {
    XCTAssertNoThrow(tbc_dispatch_retain(NULL), @"");
}

- (void)testRetainNonNull {
    dispatch_queue_t queue = dispatch_queue_create("test queue",  DISPATCH_QUEUE_SERIAL);
    XCTAssertNoThrow(tbc_dispatch_retain(queue));
    XCTAssertNoThrow(tbc_dispatch_release(queue));
    XCTAssertNoThrow(tbc_dispatch_release(queue));
}

- (void)testReleaseNull {
    XCTAssertNoThrow(tbc_dispatch_release(NULL), @"");
}

- (void)testReleaseNonNull {
    dispatch_queue_t queue = dispatch_queue_create("test queue",  DISPATCH_QUEUE_SERIAL);
    XCTAssertNoThrow(tbc_dispatch_release(queue));
}

@end
