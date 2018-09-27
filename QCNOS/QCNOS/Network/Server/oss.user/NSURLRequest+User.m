//
//  NSURLRequest+User.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSURLRequest+User.h"

@implementation NSURLRequest (User)

/** 登录接口 */
+ (NSURLRequest *)userLoginWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/login", [self userServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 注册接口 */
+ (NSURLRequest *)userRegisterWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/register", [self userServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 重置密码接口 */
+ (NSURLRequest *)userResetPasswordWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/resetPassword", [self userServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 注册的时候验证手机号码是否存在接口 */
+ (NSURLRequest *)userIsExistMobileWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/isExistMobile", [self userServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 注册的时候验证证件号码是否存在接口 */
+ (NSURLRequest *)userIsExistIdNumberWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/isExistIdNumber", [self userServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 退出登录接口 */
+ (NSURLRequest *)userLogoutWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/logout", [self userServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 获取个人所有信息 */
+ (NSURLRequest *)userGetAllInfoWithParameters:(id)parameters{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/getAllInfo", [self userServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
    
}

//user模块的服务器路径
+ (NSString *)userServerUrlPathString {
    return QCStringFormat(@"%@/sso/user", SERVER_SCHEME_AND_HOST_AND_PORT);
}

@end
