//
//  NSURLRequest+Message.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSURLRequest+Message.h"

@implementation NSURLRequest (Message)

/** 发送验证码接口 */
+ (NSURLRequest *)messageSendCodeWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/sendCode", [self messageServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 验证验证码接口 */
+ (NSURLRequest *)messageValidateCodeWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/validateCode", [self messageServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

//message模块的服务器路径
+ (NSString *)messageServerUrlPathString {
    return QCStringFormat(@"%@/sso/message", SERVER_SCHEME_AND_HOST_AND_PORT);
}

@end
