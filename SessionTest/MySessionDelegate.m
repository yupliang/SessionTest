//
//  MySessionDelegate.m
//  SessionTest
//
//  Created by yupeiliang on 2017/11/6.
//  Copyright © 2017年 PL Technology. All rights reserved.
//

#import "MySessionDelegate.h"
#import <UIKit/UIKit.h>

@implementation MySessionDelegate

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSString *str = [NSString stringWithFormat:@"%@ --1", [[UIPasteboard generalPasteboard] string]];
    [[UIPasteboard generalPasteboard] setString:str];
    NSLog(@"%s", __FUNCTION__);
    if (self.storeHandler != nil) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.storeHandler();
        }];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%s \n%@", __FUNCTION__, location);
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"%s \n%d %d %d", __FUNCTION__,bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"%s", __FUNCTION__);
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    NSLog(@"%s \n %@", __FUNCTION__, error);
    NSString *str = [NSString stringWithFormat:@"%@ --2", [[UIPasteboard generalPasteboard] string]];
    [[UIPasteboard generalPasteboard] setString:str];
}

@end
