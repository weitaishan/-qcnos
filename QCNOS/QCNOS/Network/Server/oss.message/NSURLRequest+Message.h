//
//  NSURLRequest+Message.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Message)

/** 发送验证码接口 */
+ (NSURLRequest *)messageSendCodeWithParameters:(id)parameters;

/** 验证验证码接口 */
+ (NSURLRequest *)messageValidateCodeWithParameters:(id)parameters;

@end
