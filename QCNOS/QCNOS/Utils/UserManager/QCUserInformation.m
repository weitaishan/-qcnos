//
//  QCUsernformation.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCUserInformation.h"

@implementation QCUserInformation

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"bankList" : [QCUserInformationBankList class]
             };
}
@end

@implementation QCUserInformationBankList

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"Id":@"id"};
}
@end
