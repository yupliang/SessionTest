//
//  SessionTestTests.m
//  SessionTestTests
//
//  Created by yupeiliang on 2017/11/4.
//  Copyright © 2017年 PL Technology. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MySessionDelegate.h"

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

- (void)testDownloadTask {
    NSURLSessionConfiguration *defaultSession = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultSession];
    NSURL *url = [NSURL URLWithString:@"https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/ObjC_classic/FoundationObjC.pdf"];
    __block NSURL *templocation;
    __block NSURLResponse *serverResponse;
    __block NSError *serverError;
    XCTestExpectation *exception = [self expectationWithDescription:@"Request should succeed."];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"location %@", location);
        templocation = location;
        serverResponse = response;
        serverError = error;
        [exception fulfill];
    }];
    [downloadTask resume];
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        
    }];
    XCTAssertTrue(templocation != nil);
    XCTAssertTrue(serverResponse != nil);
    XCTAssertTrue([serverResponse isKindOfClass:[NSHTTPURLResponse class]]);
    XCTAssertTrue(serverError == nil);
}

- (void)testDonwloadInbackground {
    NSLog(@"%s %@", __FUNCTION__, [[UIPasteboard generalPasteboard] string]);
    NSURLSessionConfiguration *backgroundConfigration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.myapp.networking.background"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:backgroundConfigration delegate:[MySessionDelegate new] delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:@"https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/ObjC_classic/FoundationObjC.pdf"];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    [task resume];
    XCTestExpectation *exception = [self expectationWithDescription:@"Request should succeed."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exception fulfill];
    });
    [self waitForExpectationsWithTimeout:10 handler:nil];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
