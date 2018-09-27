//
//  QCRegisteredSetVC.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCRegisteredHeader.h"

@class QCRegisteredModel, QCCompanyModel;

@interface QCRegisteredSetVC : UIViewController

@property (nonatomic, strong) QCRegisteredModel *model;

@property (nonatomic, strong) QCCompanyModel *companyModel;
//目前只有企业和个人注册
@property (nonatomic, assign) QCRegisteredSource source;

@end
