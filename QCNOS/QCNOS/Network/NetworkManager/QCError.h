//
//  QCError.h
//  WashingCar
//
//  Created by 谭川江 on 2017/6/9.
//  Copyright © 2017年 com.tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCError : NSObject

//服务器指定的错误代码
@property (nonatomic, copy) NSString *errcode;

@property (nonatomic, copy) NSString *localizedDescription;

+ (QCError *)standardError;

@end
