//
//  ToolMacro.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h
// ===================== 设备App相关===================
// app名称
#define App_Name [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
// app版本
#define App_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// app build版本
#define App_Build [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//手机序列号
#define IdentifierNumber [[UIDevice currentDevice] uniqueIdentifier]
//手机别名： 用户定义的名称
#define UserPhoneName [[UIDevice currentDevice] name]
//设备名称
#define DeviceName [[UIDevice currentDevice] systemName]
//手机系统版本
#define PhoneVersion [[UIDevice currentDevice] systemVersion]
//手机型号
#define PhoneModel [[UIDevice currentDevice] model]
//地方型号  （国际化区域名称）
#define LocalPhoneModel [[UIDevice currentDevice] localizedModel]
//本地化
#define NSUSERDEFAULTS [NSUserDefaults standardUserDefaults]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define __kScreenHeight ([[UIScreen mainScreen]bounds].size.height)
#define __kScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_MAX_LENGTH (MAX(__kScreenWidth, __kScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(__kScreenWidth, __kScreenHeight))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define  KEY_USERNAME_PASSWORD  @"com.company.app.usernamepassword"
#define  KEY_USERNAME           @"com.company.app.username"
#define  KEY_PASSWORD           @"com.company.app.password"
#define TYPE @"type"
#define USER @"user"
#define KUserManager [UserManager shareManagerInfo].user
#define UtilsManager [Utils shareInstance]

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d  \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//NSLog(...) NSLog(__VA_ARGS__);
//#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define NSLog(...) ;
//#define LOG_METHOD ;
#endif



#define WEAKSELF typeof(self) __weak weakSelf = self;
// ===================== 链接字符串 =================== LBConnectString(我是字符串)
#define LBConnectString(str) [NSString stringWithFormat:@"%@", @#str]

// ===================== 系统相关 =====================
#define APP_DELEGATE() ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 7)
#define IsIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 8.0)
#define IsIOS9 (([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 9.0) && [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<10.0)
#define IsIOS10 ([[[UIDevice currentDevice] systemVersion] compare:@"10" options:NSNumericSearch] != NSOrderedAscending)

#define IOS11_OR_LATER  ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 )



//#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0)

#define VerifyValue(value)\
({id tmp;\
if ([value isKindOfClass:[NSNull class]])\
tmp = nil;\
else\
tmp = value;\
tmp;\
})\
/**
 *  获取window
 */
#define GET_WINDOW [[UIApplication sharedApplication].delegate window]


// ===================== 尺寸相关 =====================
/** 屏幕尺寸*/
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 不同手机适配比例
#define AdaptationRatio(w) (SCREEN_WIDTH / 375)* w

// 数字转字符串
#define IntStr(num) [NSString stringWithFormat:@"%ld", (long)num]


/** 状态栏高度*/
#define  StatusBarHeight 20.f

/** 导航栏高度*/
#define  NavigationBarHeight 44.f

/** 标签栏高度*/
#define  TabbarHeight 49.f

/** 状态栏高度 + 导航栏高度*/
#define  StatusBarAndNavigationBarHeight (20.f + 44.f)

// ===================== 字体相关 =====================
/** 系统字体*/
//#define SystemFont(fSize) [UIFont systemFontOfSize:(AdaptationRatio(fSize)) > 10 ? (AdaptationRatio(fSize)): 10]
#define SystemFont(fSize) [UIFont systemFontOfSize:(fSize+1)]//(AdaptationRatio(fSize))]


#define Font(fSize) [UIFont systemFontOfSize:fSize]

#define ScreenMargin 20
#define ScreenMargin_15 15
#define ScreenMargin_10 10
#endif /* ToolMacro_h */








