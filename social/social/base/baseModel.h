//
//  baseModel.h
//  social
//
//  Created by QianYuan on 2020/8/31.
//  Copyright © 2020 QianYuan. All rights reserved.
// 宏定义的类
/** RGB颜色 **/
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/** 屏幕的宽度 **/
#define MainScreenWidth ([UIScreen mainScreen].bounds.size.width)
/** 屏幕的高度 **/
#define MainScreenHeight ([UIScreen mainScreen].bounds.size.height)
/** 判读是否为iPhone X及以上 **/
//#define IPHONE_X  @available(iOS 11.0, *) && UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom > 0.0
///MARK:  iPhone X 刘海屏系列宏定义判断（适用目前所有的iPhone刘海屏）
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})


/** 宽度倍率 **/
#define MLWidthScale MainScreenWidth/375
/** 高度的倍率 **/
#define MLHeightScale MainScreenHeight/667
/** 导航栏高度 **/
#define NavigationbarHeight ((self.navigationController.navigationBar.frame.size.height))
/** 状态栏高度 **/
#define StatusbarHeight (IPHONE_X ?44:20)
/** 状态栏加导航栏高度 **/
#define StatusbarAndNavigationbarHeight (IPHONE_X ?88:64)
/** tabbar高度 **/
#define TabBarHeight (IPHONE_X ? (49.f+34.f) :49.f)
/** 底部安全区域 **/
#define SafeAreaBottom  (IPHONE_X ? 34:0)

#define user_token @"token"
#define user_userId @"id"
#define user_phone @"phone"





#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface baseModel : NSObject


@end

NS_ASSUME_NONNULL_END
