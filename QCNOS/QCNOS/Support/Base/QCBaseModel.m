//
//  QCBaseModel.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCBaseModel.h"

@implementation QCBaseModel
+(NSDictionary *)modelCustomPropertyMapper{
    
    
    return @{@"Id" : @"id", @"desc" : @"description"};
    
}
@end
