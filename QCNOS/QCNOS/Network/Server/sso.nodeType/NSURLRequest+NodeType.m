//
//  NSURLRequest+NodeType.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/28.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSURLRequest+NodeType.h"

@implementation NSURLRequest (NodeType)
/** 获取区块类型 */
+ (NSURLRequest *)getBlockTypeListWithParameters:(id)parameters{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    NSString *urlString = QCStringFormat(@"%@/list", [self blockServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
    [request authorizedURLRequest];
    return request;
}



//block模块的服务器路径
+ (NSString *)blockServerUrlPathString {
    return QCStringFormat(@"%@/sso/blockType", SERVER_SCHEME_AND_HOST_AND_PORT);
}

@end
