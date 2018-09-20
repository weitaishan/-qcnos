//
//  QCError.m
//  WashingCar
//
//  Created by 谭川江 on 2017/6/9.
//  Copyright © 2017年 com.tan. All rights reserved.
//

#import "QCError.h"

@implementation QCError

+ (QCError *)standardError {
    QCError *error = [[QCError alloc] init];
    return error;
}

@end
