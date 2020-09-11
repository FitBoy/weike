//
//  LIVIVTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/3.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LIVIVTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *L_left;
@property (nonatomic,strong) HeadImageView *IV_head;
@property (nonatomic,strong) UIImageView *IV_right;

@property (nonatomic,strong) UIView *V_bg;

@end

NS_ASSUME_NONNULL_END
