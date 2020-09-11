//
//  L_TextTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/4.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface L_TextTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *V_bg;

@property (nonatomic,strong) UILabel *L_left;
@property (nonatomic,strong) UITextField *TF_text;


@end

NS_ASSUME_NONNULL_END
