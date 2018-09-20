//
//  NSNull+WTSNatural.m
//  SmallNail
//
//  Created by 魏太山 on 2017/7/17.
//  Copyright © 2017年 SmallNail. All rights reserved.
//

#import "NSNull+WTSNatural.h"

@implementation NSNull (WTSNatural)
-(void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;

}
@end
