## BackgroundSession test steps
```
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
```

1 run test case
2 kill app

### the following method calls
* \- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
* \- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
* \- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session

0--0 now , I can also work on my windows PC. (:
