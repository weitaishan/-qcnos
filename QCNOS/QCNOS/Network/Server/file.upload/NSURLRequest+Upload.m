//
//  NSURLRequest+Upload.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/6.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSURLRequest+Upload.h"

@implementation NSURLRequest (Upload)

/** 上传图片 */
+ (NSURLRequest *)uploadHeaderImageWithParameters:(id)parameters
                                         fileName:(NSString *)fileName {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer defaultSerializer];
    [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *urlString = QCStringFormat(@"%@/uploadImg", [self uploadServerUrlPathString]);
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                       URLString:urlString
                                                      parameters:parameters
                                                           error:nil];
//    [request setValue:[NSString stringWithFormat:@"form-data; name=\"%@\"", fileName]
//    forHTTPHeaderField:@"Content-Disposition"];
//    [request setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
    [request authorizedURLRequest];
    return request;
}

//upload模块的服务器路径
+ (NSString *)uploadServerUrlPathString {
    return QCStringFormat(@"%@/file/upload", SERVER_SCHEME_AND_HOST_AND_PORT);
}

@end
