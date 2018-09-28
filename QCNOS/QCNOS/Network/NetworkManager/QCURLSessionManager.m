//
//  QCURLSessionManager.m
//  WashingCar
//
//  Created by 谭川江 on 2017/6/9.
//  Copyright © 2017年 com.tan. All rights reserved.
//

#import "QCURLSessionManager.h"
#import "AFURLSessionManager+SessionManager.h"
#import "QCLoginViewController.h"

@implementation QCURLSessionManager

+ (NSURLSessionTask *)dataTaskWithRequest:(NSURLRequest *)request
                             successBlock:(DataTaskSuccessBlock)successBlock
                                failBlock:(DataTaskFailBlock)failBlock {
    NSURLSessionDataTask *dataTask = [[AFURLSessionManager defaultAFURLSessionManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"responseObject == %@, error == %@", responseObject, error);
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
            if ([responseObject[@"message"] isEqualToString:@"登录已失效, 请重新登录"]) {
                [QCUserManager clearUserDatas];
                QCLoginViewController *VC = [[QCLoginViewController alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController
                 pushViewController:VC
                 animated:YES];
            }
            else {
                NSString *errCode = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
                NSString *errMessage = nil;
                QCError *serverError = [QCError standardError];
                serverError.errcode = errCode;
                errMessage = responseObject[@"message"];
                serverError.localizedDescription = errMessage;
                failBlock(serverError);
            }
            return;
        }
        successBlock(responseObject);
    }];
    
    [dataTask resume];
    return dataTask;
}

+ (void)uploadImageWithImage:(UIImage *)image
                   imageType:(QCUploadImageServerType)imageType
                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    switch (imageType) {
        case QCUploadImageServerTypeIdPhoto:
            parameters[@"type"] = @"idPhoto";
            break;
        case QCUploadImageServerTypeHeadPhoto:
            parameters[@"type"] = @"headPhoto";
            break;
        case QCUploadImageServerTypeLogoPhoto:
            parameters[@"type"] = @"logoPhoto";
            break;
        case QCUploadImageServerTypeShopPhoto:
            parameters[@"type"] = @"shopPhoto";
            break;
    }
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    [manage.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:[NSString stringWithFormat:@"%@/file/upload/uploadImg", SERVER_SCHEME_AND_HOST_AND_PORT]
      parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *fileName = [NSString stringWithFormat:@"%@.png",
                          [formatter stringFromDate:[NSDate date]]];
    [formData appendPartWithFileData:data
                                name:@"fileData"
                            fileName:fileName
                            mimeType:@"image/jpeg"];
    }
        progress:uploadProgress
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
             NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:nil];
             success(task, responseDic);
     }
         failure:failure];
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

@end
