//
//  QCRegisteredModel.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/30.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
//注册账号的数据模型
@interface QCRegisteredModel : NSObject

@property (nonatomic, copy) NSString *mobile; //手机号码

@property (nonatomic, copy) NSString *code; //验证码

@property (nonatomic, copy) NSString *realName; //真实姓名

@property (nonatomic, copy) NSString *nickName; //昵称

@property (nonatomic, copy) NSString *gender; //性别

@property (nonatomic, copy) NSString *idNumber;  //证件号码

@property (nonatomic, copy) NSString *password;  //密码

@property (nonatomic, copy) NSString *nationCode;

@property (nonatomic, copy) NSString *nationName; //国家

@property (nonatomic, copy) NSString *provinceCode;

@property (nonatomic, copy) NSString *provinceName; //省

@property (nonatomic, copy) NSString *cityCode;

@property (nonatomic, copy) NSString *cityName; //市

@property (nonatomic, copy) NSString *regionCode;

@property (nonatomic, copy) NSString *regionName; //区

@property (nonatomic, assign) BOOL nodeStatus; //节点共识状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL gpsStatus; //地理位置状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL shopStatus; //互动店铺状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL bankStatus; //银行账户状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL pushStatus;  //广告推送状态 打开 YES 关闭 NO

@property (nonatomic, assign) BOOL aiStatus;  //量芯AI助手状态 打开 YES 关闭 NO

@property (nonatomic, copy) NSString *headPhoto; //头像

@property (nonatomic, copy) NSString *languageDescription; //官方语言-官方语言描述

@property (nonatomic, copy) NSString *mobileCode; //手机码

@end
