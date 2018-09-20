//
//  QCRegisteredModel.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/30.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredModel.h"

@implementation QCRegisteredModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.nodeStatus = YES;
        self.gpsStatus = YES;
        self.shopStatus = YES;
        self.bankStatus = YES;
        self.pushStatus = YES;
        self.aiStatus = YES;
        self.nationName = @"中国";
        self.nationCode = @"CHN";
        self.mobileCode = @"86";
        self.languageDescription = @"简体中文";
        self.gender = @"FEMALE";
    }
    return self;
}

@end
