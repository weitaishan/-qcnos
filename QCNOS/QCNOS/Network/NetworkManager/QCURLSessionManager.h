//
//  QCURLSessionManager.h
//  WashingCar
//
//  Created by 谭川江 on 2017/6/9.
//  Copyright © 2017年 com.tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QCError;

typedef void (^DataTaskSuccessBlock)(id responseObject);
typedef void (^DataTaskFailBlock)(QCError *error);

@interface QCURLSessionManager : NSObject

+ (NSURLSessionTask *)dataTaskWithRequest:(NSURLRequest *)request
                             successBlock:(DataTaskSuccessBlock)successBlock
                                failBlock:(DataTaskFailBlock)failBlock;

//兼容后台的数据结构
+ (NSURLSessionTask *)dataTaskWithCompatibleRequest:(NSURLRequest *)request
                                       successBlock:(DataTaskSuccessBlock)successBlock
                                          failBlock:(DataTaskFailBlock)failBlock;
//上传文件
+ (NSURLSessionTask *)uploadFileWithFileData:(NSData *)fileData
                                     request:(NSURLRequest *)request
                                successBlock:(DataTaskSuccessBlock)successBlock
                                   failBlock:(DataTaskFailBlock)failBlock;

@end
