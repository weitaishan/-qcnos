//
//  QCResetViewController.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/30.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCRegisteredHeader.h"

@class QCResetModel;

@interface QCResetViewController : UIViewController

@property (nonatomic, assign) QCMessageCodeType codeType;

@property (nonatomic, strong) QCResetModel *resetModel;

@end
