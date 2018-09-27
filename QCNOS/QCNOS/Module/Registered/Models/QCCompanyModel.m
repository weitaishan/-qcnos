//
//  QCCompanyModel.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCCompanyModel.h"

@implementation QCCompanyModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.nodeStatus = YES;
        self.gpsStatus = YES;
        self.shopStatus = YES;
        self.bankStatus = YES;
        self.pushStatus = YES;
        self.aiStatus = YES;
        self.mobileCode = @"86";
    }
    return self;
}

@end
