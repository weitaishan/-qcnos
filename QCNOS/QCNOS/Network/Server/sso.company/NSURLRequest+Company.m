//
//  NSURLRequest+Company.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSURLRequest+Company.h"

@implementation NSURLRequest (Company)

/** 添加企业 */
+ (NSURLRequest *)companyAddWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/add", [self companyServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

/** 查询企业列表 */
+ (NSURLRequest *)companyGetWithParameters:(id)parameters {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/getList", [self companyServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

//company模块的服务器路径
+ (NSString *)companyServerUrlPathString {
    return QCStringFormat(@"%@/sso/company", SERVER_SCHEME_AND_HOST_AND_PORT);
}

@end
