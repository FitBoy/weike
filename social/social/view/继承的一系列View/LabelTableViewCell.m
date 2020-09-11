//
//  LabelTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "LabelTableViewCell.h"

@implementation LabelTableViewCell

-(UILabel *)L_name{
    
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.V_bg).mas_offset(-15);
            make.centerY.mas_equalTo(self.V_bg);
        }];
    }
    return _L_name;
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
