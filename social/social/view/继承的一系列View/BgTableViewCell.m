//
//  BgTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "BgTableViewCell.h"

@implementation BgTableViewCell

-(UIView *)V_bg{
    
    if (!_V_bg) {
     _V_bg =  [[UIView alloc]init];
        [self addSubview:_V_bg];
        _V_bg.backgroundColor = [UIColor whiteColor];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
    }
    return _V_bg;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
