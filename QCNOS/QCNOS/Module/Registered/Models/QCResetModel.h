//
//  QCResetModel.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

//重置密码数据提交模型
@interface QCResetModel : NSObject

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *idNumber;

@end
