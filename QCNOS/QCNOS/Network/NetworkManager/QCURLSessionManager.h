//
//  QCURLSessionManager.h
//  WashingCar
//
//  Created by 谭川江 on 2017/6/9.
//  Copyright © 2017年 com.tan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, QCUploadImageServerType) {
    QCUploadImageServerTypeIdPhoto = 0,      //身份证
    QCUploadImageServerTypeHeadPhoto,        //头像
    QCUploadImageServerTypeLogoPhoto,        //logo
    QCUploadImageServerTypeShopPhoto,        //店铺图片
};

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
+ (void)uploadImageWithImage:(UIImage *)image
                   imageType:(QCUploadImageServerType)imageType
                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
