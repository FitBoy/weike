//
//  IVLIVTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IVLIVTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *V_bg;

@property (nonatomic,strong) UIImageView *IV_img;
@property (nonatomic,strong) UILabel *L_text;
@property (nonatomic,strong) UIImageView *IV_more;

@end

NS_ASSUME_NONNULL_END
