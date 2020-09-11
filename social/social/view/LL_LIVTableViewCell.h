//
//  LL_LIVTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/4.
//  Copyright © 2020 QianYuan. All rights reserved.
//  110;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LL_LIVTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *V_bg;

@property (nonatomic,strong) UILabel *L_left;
@property (nonatomic,strong) UITextField *TF_right;
@property (nonatomic,strong) UILabel *L_tishi;
@property (nonatomic,strong) UIImageView *IV_right;

@property (nonatomic,strong) UIImageView *IV_img;

-(void)setUI;

@end

NS_ASSUME_NONNULL_END
