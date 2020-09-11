//
//  registerThreeView.h
//  social
//
//  Created by QianYuan on 2020/9/1.
//  Copyright © 2020 QianYuan. All rights reserved.
// 第三方注册的样式

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface registerThreeView : UIView
@property (nonatomic,strong)UIImageView *IV_line;

@property (nonatomic,strong) UIImageView *IV_wechat;
@property (nonatomic,strong) UIImageView *IV_qq;
@property (nonatomic,strong) UIImageView *IV_weibo;

-(void)setImge;


@end

NS_ASSUME_NONNULL_END
