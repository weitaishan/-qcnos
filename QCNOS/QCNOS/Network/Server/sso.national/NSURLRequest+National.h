//
//  NSURLRequest+National.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (National)

/** 获取国家信息 */
+ (NSURLRequest *)nationalWithParameters:(id)parameters;

@end
