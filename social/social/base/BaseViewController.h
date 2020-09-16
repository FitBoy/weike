//
//  BaseViewController.h
//  social
//
//  Created by QianYuan on 2020/8/31.
//  Copyright © 2020 QianYuan. All rights reserved.
// 所有的viewConteoller 都继承于他，除非有特殊的要求

#define  userDefault  [NSUserDefaults standardUserDefaults]
#define  firstIn @"firstIn"
#define isLogin @"isLogin"
#define AMap_key @"a7a9d0c15e35ea1a9052a676f47b6ed9"

#define  font(m)  [UIFont systemFontOfSize:m]

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <YYText.h>
#import "baseModel.h"
#import <EasyShowView.h>
#import "SXTHTTPTool.h"
#import <RongIMKit/RongIMKit.h>
#import <SDWebImage.h>
#import <TZImagePickerController.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (BOOL)isPhoneNumWithPhone:(NSString *)phone;
-(NSString *)base64FromImage:(UIImage *)image;
-(void)saoyisao;
/// 清除本地缓存的用户信息
-(void)clearLocalData;

-(void)jumpWebVcWithtype:(NSString*)type;
/// 上传图片
-(void)UploadImages:(NSArray*)image block:(void (^)(BOOL isSuccess ,NSString *tstr))block;
@end

NS_ASSUME_NONNULL_END
