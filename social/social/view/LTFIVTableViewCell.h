//
//  LTFIVTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/4.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTFIVTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *L_left;
@property (nonatomic,strong) UITextField *TF_right;
@property (nonatomic,strong) UIImageView *IV_right;

@property (nonatomic,strong) UIView *V_bg;
@end

NS_ASSUME_NONNULL_END
