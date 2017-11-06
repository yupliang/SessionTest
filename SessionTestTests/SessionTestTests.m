//
//  SessionTestTests.m
//  SessionTestTests
//
//  Created by yupeiliang on 2017/11/4.
//  Copyright © 2017年 PL Technology. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SessionTestTests : XCTestCase

@end

@implementation SessionTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sessionWithoutADelegate = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSURL *url = [NSURL URLWithString:@"https://www.example.com/"];
    __block BOOL flag = NO;
    [[sessionWithoutADelegate dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Got response %@ with error %@.\n", response, error);
        NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        flag = true;
        [expectation fulfill];
  }] resume];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    XCTAssertTrue(flag == true);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
