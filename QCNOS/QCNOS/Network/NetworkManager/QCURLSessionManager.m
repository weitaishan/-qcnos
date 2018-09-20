//
//  QCURLSessionManager.m
//  WashingCar
//
//  Created by 谭川江 on 2017/6/9.
//  Copyright © 2017年 com.tan. All rights reserved.
//

#import "QCURLSessionManager.h"
#import "AFURLSessionManager+SessionManager.h"

@implementation QCURLSessionManager

+ (NSURLSessionTask *)dataTaskWithRequest:(NSURLRequest *)request
                             successBlock:(DataTaskSuccessBlock)successBlock
                                failBlock:(DataTaskFailBlock)failBlock {
    NSURLSessionDataTask *dataTask = [[AFURLSessionManager defaultAFURLSessionManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (!response) {
                QCError *networkError = [QCError standardError];
                networkError.localizedDescription = [NSString stringWithFormat:@"网络异常\n%@", [error localizedDescription]];
                failBlock(networkError);
                return;
            }

            QCError *otherErr = [QCError standardError];
            otherErr.localizedDescription = [NSString stringWithFormat:@"系统错误\n%@", [error localizedDescription]];
            failBlock(otherErr);
            return;
        }
        
        //服务端错误 errcode != 0
        if ([responseObject isKindOfClass:[NSDictionary class]]
            && [responseObject[@"code"] integerValue] != 200) {
            NSString *errCode = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
            NSString *errMessage = nil;
            QCError *serverError = [QCError standardError];
            serverError.errcode = errCode;
            errMessage = responseObject[@"message"];
            serverError.localizedDescription = errMessage;
            failBlock(serverError);
            return;
        }
        successBlock(responseObject);
    }];
    
    [dataTask resume];
    return dataTask;
}

//兼容后台的数据结构
+ (NSURLSessionTask *)dataTaskWithCompatibleRequest:(NSURLRequest *)request
                                       successBlock:(DataTaskSuccessBlock)successBlock
                                          failBlock:(DataTaskFailBlock)failBlock {
    NSURLSessionDataTask *dataTask = [[AFURLSessionManager defaultAFURLSessionManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (!response) {
                QCError *networkError = [QCError standardError];
                networkError.localizedDescription = [NSString stringWithFormat:@"网络异常\n%@", [error localizedDescription]];
                failBlock(networkError);
                return;
            }
            
            QCError *otherErr = [QCError standardError];
            otherErr.localizedDescription = [NSString stringWithFormat:@"系统错误\n%@", [error localizedDescription]];
            failBlock(otherErr);
            return;
        }
        
        //服务端错误 errcode != 0
        if ([responseObject isKindOfClass:[NSDictionary class]]
            && ![responseObject[@"header"][@"returnStatus"] isEqualToString:@"SUCCESS"]) {
            NSString *errCode = [NSString stringWithFormat:@"%@", responseObject[@"header"][@"returnCode"]];
            NSString *errMessage = nil;
            QCError *serverError = [QCError standardError];
            serverError.errcode = errCode;
//            errMessage = responseObject[@"message"];
            errMessage = @"请求异常";
            serverError.localizedDescription = errMessage;
            failBlock(serverError);
            return;
        }
        successBlock(responseObject[@"body"]);
    }];
    
    [dataTask resume];
    return dataTask;
}

+ (NSURLSessionTask *)uploadFileWithFileData:(NSData *)fileData
                                     request:(NSURLRequest *)request
                                successBlock:(DataTaskSuccessBlock)successBlock
                                   failBlock:(DataTaskFailBlock)failBlock {
    NSURLSessionDataTask *dataTask = [[AFURLSessionManager defaultAFURLSessionManager] uploadTaskWithRequest:request fromData:fileData progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (!response) {
                QCError *networkError = [QCError standardError];
                networkError.localizedDescription = [NSString stringWithFormat:@"网络异常\n%@", [error localizedDescription]];
                failBlock(networkError);
                return;
            }
            
            QCError *otherErr = [QCError standardError];
            otherErr.localizedDescription = [NSString stringWithFormat:@"系统错误\n%@", [error localizedDescription]];
            failBlock(otherErr);
            return;
        }
        
        //服务端错误 errcode != 0
        if ([responseObject isKindOfClass:[NSDictionary class]]
            && [responseObject[@"code"] integerValue] != 200) {
            NSString *errCode = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
            NSString *errMessage = nil;
            QCError *serverError = [QCError standardError];
            serverError.errcode = errCode;
            errMessage = responseObject[@"message"];
            serverError.localizedDescription = errMessage;
            failBlock(serverError);
            return;
        }
        successBlock(responseObject);
    }];
    [dataTask resume];
    return dataTask;
}

@end
