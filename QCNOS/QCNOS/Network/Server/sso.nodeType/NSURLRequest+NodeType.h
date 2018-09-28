//
//  NSURLRequest+NodeType.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/28.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (NodeType)
/** 获取区块类型 */
+ (NSURLRequest *)getBlockTypeListWithParameters:(id)parameters;
@end
