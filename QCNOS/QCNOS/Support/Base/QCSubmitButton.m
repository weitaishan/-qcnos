//
//  QCSubmitButton.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/21.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCSubmitButton.h"

@implementation QCSubmitButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
        
    }
    return self;
}
- (void)initView{
    
    self.backgroundColor = [UIColor colorFromHexString:@"#497fef"];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = Font(13);
}


@end
