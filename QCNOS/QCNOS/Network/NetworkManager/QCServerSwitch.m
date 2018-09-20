//
//  QCServerSwitch.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCServerSwitch.h"

@implementation QCServerSwitch

+ (NSString *)serverSwith {
#ifdef DEBUG
    return @"http://43.254.45.72:8888";   //正式环境
#else
    return @"http://43.254.45.72:8888";   //正式环境
#endif
}

@end
