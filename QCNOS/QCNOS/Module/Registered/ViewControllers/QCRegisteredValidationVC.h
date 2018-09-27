//
//  QCRegisteredValidationVC.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCRegisteredHeader.h"

@class QCRegisteredModel, QCResetModel, QCCompanyModel;

@interface QCRegisteredValidationVC : UIViewController

@property (nonatomic, assign) QCRegisteredSource source;

@property (nonatomic, strong) QCRegisteredModel *model;

@property (nonatomic, strong) QCResetModel *resetModel;

@property (nonatomic, strong) QCCompanyModel *companyModel;

@property (nonatomic, assign) QCMessageCodeType codeType;

@end
