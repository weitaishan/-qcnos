//
//  NSURLRequest+Shop.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/29.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Shop)
/** 新增店铺 */
+ (NSURLRequest *)addShopWithParameters:(id)parameters;
@end
