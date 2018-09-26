//
//  AppDelegateMain.m
//  WashingCar
//
//  Created by 谭川江 on 2017/6/8.
//  Copyright © 2017年 com.tan. All rights reserved.
//

#import "AppDelegateMain.h"
#import "QCShoppingViewController.h"
#import "QCInteractiveViewController.h"
#import "QCPersonalCenterViewController.h"
#import "QCHotViewController.h"
#import "QCInvitationViewController.h"

@implementation AppDelegateMain

+ (UITabBarController *)loadMainSubViewController {
    
    UITabBarController *mainTabBar = [[UITabBarController alloc] init];
    
    QCShoppingViewController *shoppingVC = [[QCShoppingViewController alloc] init];
    UINavigationController *shoppingNav = [[UINavigationController alloc]
                                       initWithRootViewController:shoppingVC];
    shoppingNav.tabBarItem.title = @"逛街";
    [shoppingNav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName: k_Color_Main_Navigation}
                                      forState:UIControlStateSelected];
    shoppingNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_shopping_none"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    shoppingNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_shopping_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    QCInteractiveViewController *interactiveVC = [[QCInteractiveViewController alloc] init];
    UINavigationController *interactiveNav = [[UINavigationController alloc]
                                     initWithRootViewController:interactiveVC];
    interactiveNav.tabBarItem.title = @"互动";
    [interactiveNav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName: k_Color_Main_Navigation}
                                    forState:UIControlStateSelected];
    interactiveNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_interactive_none"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    interactiveNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_interactive_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    
    QCInvitationViewController *invitationVC = [[QCInvitationViewController alloc] init];
    UINavigationController *invitationNav = [[UINavigationController alloc] initWithRootViewController:invitationVC];
    invitationNav.tabBarItem.title = @"邀约";
    [invitationNav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName: k_Color_Main_Navigation}
                                     forState:UIControlStateSelected];
    invitationNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_invitation_none"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    invitationNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_invitation_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    QCHotViewController *hotVC = [[QCHotViewController alloc] init];
    UINavigationController *hotNav = [[UINavigationController alloc] initWithRootViewController:hotVC];
    hotNav.tabBarItem.title = @"算力";
    [hotNav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName: k_Color_Main_Navigation}
                             forState:UIControlStateSelected];
    hotNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_hot_none"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    hotNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_hot_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    QCPersonalCenterViewController *centerVC = [[QCPersonalCenterViewController alloc] init];
    UINavigationController *centerNav = [[UINavigationController alloc]
                                     initWithRootViewController:centerVC];
    centerNav.tabBarItem.title = @"承载";
    [centerNav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName: k_Color_Main_Navigation}
                                    forState:UIControlStateSelected];
    centerNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_personal_center_none"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    centerNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_personal_center_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    
    mainTabBar.viewControllers = @[shoppingNav, interactiveNav, invitationNav, hotNav, centerNav];
    
    [self setAppAppearance];
    return mainTabBar;
}

+ (void)setAppAppearance {
    [UIApplication sharedApplication].statusBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [UITabBar appearance].translucent = NO;
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    CGSize imageSize = CGSizeMake(10, 10);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    
    [k_Color_Main_Navigation set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UINavigationBar appearance] setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0)
                                                         forBarMetrics:UIBarMetricsDefault];

    NSMutableDictionary * textDic = [NSMutableDictionary dictionary];
    textDic[NSFontAttributeName] = Font(18);
    textDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = textDic;
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"navigation_back"]];

    UIImage *backImage = [UIImage imageNamed:@"navigation_back"];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
    
    [[UITableView appearance] setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [[UITableView appearance] setSeparatorColor:Color_Cell_Separator];
    if (IOS11_OR_LATER) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
}


@end
