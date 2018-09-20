//
//  UITextField+Util.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/29.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "UITextField+Util.h"

@implementation UITextField (Util)

- (void)placeholderTextAlignmentCenter {
    NSNumber * value = [NSNumber numberWithInteger:NSTextAlignmentCenter];
    [self setValue:value forKeyPath:@"_placeholderLabel.textAlignment"];
}

@end
