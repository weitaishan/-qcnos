//
//  NSURLRequest+Shop.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/29.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSURLRequest+Shop.h"

@implementation NSURLRequest (Shop)

/** 新增店铺 */
+ (NSURLRequest *)addShopWithParameters:(id)parameters {
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/add", [self shopServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}

//block模块的服务器路径
+ (NSString *)shopServerUrlPathString {
    return QCStringFormat(@"%@/sso/shop", SERVER_SCHEME_AND_HOST_AND_PORT);
}



@end
