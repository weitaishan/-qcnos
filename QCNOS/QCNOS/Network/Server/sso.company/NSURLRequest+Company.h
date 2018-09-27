//
//  NSURLRequest+Company.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Company)

/** 添加企业 */
+ (NSURLRequest *)companyAddWithParameters:(id)parameters;

@end
