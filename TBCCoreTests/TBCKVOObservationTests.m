//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCCore.h>

@interface TBCKVOCompliantObject : NSObject
@property(nonatomic,readwrite,retain) NSString *observable;
@end
@implementation TBCKVOCompliantObject
@end

@interface TBCKVOObservationTests : XCTestCase
@end

@implementation TBCKVOObservationTests

- (void)testObservance {
    TBCKVOCompliantObject * object = [[TBCKVOCompliantObject alloc] init];
    object.observable = @"a";

    XCTestExpectation * expectation = [self expectationWithDescription:@"observation block called"];
    expectation.assertForOverFulfill = YES;

    TBCKVOObservation * observation = [TBCKVOObservation observationWithObject:object selector:@selector(observable) block:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        [expectation fulfill];
    }];
    object.observable = @"b";

    [self waitForExpectationsWithTimeout:1 handler:nil];

    observation = nil;

    object.observable = @"c";
}

- (void)testObservanceAfterDestruction {
    TBCKVOCompliantObject * object = [[TBCKVOCompliantObject alloc] init];
    object.observable = @"a";

    TBCKVOObservation * observation = [TBCKVOObservation observationWithObject:object selector:@selector(observable) block:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        XCTFail(@"observation block called");
    }];
    observation = nil;

    object.observable = @"b";
}

- (void)testObservanceAfterRemove {
    TBCKVOCompliantObject * object = [[TBCKVOCompliantObject alloc] init];
    object.observable = @"a";

    TBCKVOObservation * observation = [TBCKVOObservation observationWithObject:object selector:@selector(observable) block:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        XCTFail(@"observation block called");
    }];
    [observation removeObservation];

    object.observable = @"b";
}



@end
