//
//  QCUserManager.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCUserManager.h"

@implementation QCUserManager

+ (QCUserManager *)standardUserManager {
    QCUserManager *manger = [[QCUserManager alloc] init];
    RLMResults<QCUserInformation *> *results = [QCUserInformation allObjects];
    if (results.count > 0) {
        manger.user = results.lastObject;
    }
    return manger;
}

+ (void)userManagerSaveUserDataWithDictionary:(NSDictionary *)dictionary {
    RLMRealm *realm = [RLMRealm defaultRealm];
    QCUserInformation *user = [QCUserInformation yy_modelWithDictionary:dictionary];
    [realm transactionWithBlock:^{
        [realm addObject:user];
    }];
}

+ (void)clearUserDatas {
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<QCUserInformation *> *users = [QCUserInformation allObjects];
    [realm transactionWithBlock:^{
        [realm deleteObjects:users];
    }];
}

@end
