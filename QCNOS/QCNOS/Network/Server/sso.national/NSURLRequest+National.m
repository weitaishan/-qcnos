//
//  NSURLRequest+National.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSURLRequest+National.h"

@implementation NSURLRequest (National)

/** 获取国家信息 */
+ (NSURLRequest *)nationalWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/list", [self nationalServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

//national模块的服务器路径
+ (NSString *)nationalServerUrlPathString {
    return QCStringFormat(@"%@/sso/national", SERVER_SCHEME_AND_HOST_AND_PORT);
}

@end
