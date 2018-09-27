//
//  QCCompanyModel.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCCompanyModel : NSObject

@property (nonatomic, copy) NSString *mobileCode; //手机码

@property (nonatomic, copy) NSString *mobile; //手机号码

@property (nonatomic, copy) NSString *creditCode;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *logoPhoto;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) BOOL nodeStatus; //节点共识状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL gpsStatus; //地理位置状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL shopStatus; //互动店铺状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL bankStatus; //银行账户状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL pushStatus;  //广告推送状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL aiStatus;  //量芯AI助手状态 打开 YES 关闭 NO

@end
