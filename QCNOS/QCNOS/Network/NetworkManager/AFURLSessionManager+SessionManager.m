//
//  AFURLSessionManager+SessionManager.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "AFURLSessionManager+SessionManager.h"

static AFURLSessionManager *manager;

@implementation AFURLSessionManager (SessionManager)

+ (AFURLSessionManager *)defaultAFURLSessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 15;
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    });
    return manager;
}

@end
