//
//  MySessionDelegate.h
//  SessionTest
//
//  Created by yupeiliang on 2017/11/6.
//  Copyright © 2017年 PL Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySessionDelegate : NSObject <NSURLSessionDownloadDelegate>

@property (nonatomic,copy) void (^storeHandler)(void);

@end
