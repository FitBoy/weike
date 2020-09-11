//
//  LabelTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
// 只有一个文字显示的cell

#import "BgTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LabelTableViewCell : BgTableViewCell
@property (nonatomic,strong) UILabel *L_name;
@end

NS_ASSUME_NONNULL_END
