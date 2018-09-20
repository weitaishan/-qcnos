//
//  NSURLRequest+Upload.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/6.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Upload)

/** 上传图片 */
+ (NSURLRequest *)uploadHeaderImageWithParameters:(id)parameters
                                         fileName:(NSString *)fileName;

@end
