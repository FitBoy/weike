//
//  L_TextTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/4.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "L_TextTableViewCell.h"
#import <Masonry.h>

@implementation L_TextTableViewCell

-(UITextField *)TF_text{
    
    if (!_TF_text) {
        _TF_text = [[UITextField alloc]init];
        [self.V_bg addSubview:_TF_text];
        _TF_text.font = [UIFont systemFontOfSize:17];
        [_TF_text  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(self.V_bg).mas_offset(15);
            make.right.mas_equalTo(self.V_bg).mas_offset(-15);
            make.top.mas_equalTo(self.L_left.mas_bottom).mas_offset(5);
        }];
        _TF_text.placeholder = @"请输入个性签名";
    }
    return _TF_text;
}


-(UILabel *)L_left{
    
    if(!_L_left){
        _L_left = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left];
        [_L_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
        }];
        _L_left.font = [UIFont systemFontOfSize:17];
    }
    return _L_left;
}

-(UIView *)V_bg{
    
    if (!_V_bg) {
      _V_bg =  [[UIView alloc]init];
        [self addSubview:_V_bg];
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
