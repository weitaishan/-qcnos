//
//  AFHTTPRequestSerializer+Extension.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "AFHTTPRequestSerializer+Extension.h"

@implementation AFHTTPRequestSerializer (Extension)

+ (AFHTTPRequestSerializer *)defaultSerializer {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    return serializer;
}

@end
