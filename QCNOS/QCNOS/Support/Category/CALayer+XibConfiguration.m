//
//  CALayer+XibConfiguration.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)
-(void)setBorderUIColor:(UIColor*)color

{
    
    self.borderColor = color.CGColor;
    
}

-(UIColor*)borderUIColor

{
    
    return [UIColor colorWithCGColor:self.borderColor];
    
}
@end
