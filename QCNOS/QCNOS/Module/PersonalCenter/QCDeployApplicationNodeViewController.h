//
//  QCDeployApplicationNodeViewController.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "WTSBaseViewController.h"

@interface QCDeployApplicationNodeViewController : WTSBaseViewController

/** 0为应用区块，1为部署应用节点, 2为确认应用区块配置*/
@property (nonatomic, assign) NSUInteger type;

@end
