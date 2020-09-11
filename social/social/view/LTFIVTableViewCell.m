//
//  LTFIVTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/4.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "LTFIVTableViewCell.h"
#import <Masonry.h>
@implementation LTFIVTableViewCell

-(UITextField *)TF_right{
    
    if (!_TF_right) {
        _TF_right =[[UITextField alloc]init];
        [self.V_bg addSubview:_TF_right];
        _TF_right.font = [UIFont systemFontOfSize:17];
        _TF_right.textAlignment = NSTextAlignmentRight;
        [_TF_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.IV_right.mas_left).mas_offset(-5);
            make.left.mas_equalTo(self.L_left.mas_right).mas_equalTo(5);
            make.height.mas_equalTo(30);
        }];
        
    }
    return _TF_right;
}


-(UIImageView *)IV_right{
    
    if (!_IV_right) {
      _IV_right = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_right];
        _IV_right.image = [UIImage imageNamed:@"back"];
        [_IV_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 17.5));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-15);
        }];
        
    }
    return _IV_right;
}
-(UILabel *)L_left{
    if (!_L_left) {
        _L_left = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left];
        _L_left.font = [UIFont systemFontOfSize:17];
        [_L_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@100);
        }];

    }
    return _L_left;;
}


-(UIView *)V_bg{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(self);
        }];
        _V_bg.backgroundColor = [UIColor whiteColor];
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
