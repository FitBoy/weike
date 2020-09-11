//
//  IVLIVTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "IVLIVTableViewCell.h"
#import <Masonry.h>
@implementation IVLIVTableViewCell

-(UIImageView *)IV_more{
    
    if (!_IV_more) {
        _IV_more = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_more];
        _IV_more.image = [UIImage imageNamed:@"back"];
        [_IV_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 17.5));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-15);
        }];
    }
    return _IV_more;
    
}

-(UILabel *)L_text{
    
    if (!_L_text) {
        _L_text = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_text];
        _L_text.font = [UIFont systemFontOfSize:18];
        [_L_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(20);
            make.right.mas_equalTo(self.IV_more.mas_left).mas_offset(-5);
        }];
    }
    return _L_text;
}

-(UIImageView *)IV_img{
    
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
        }];
    }
    return _IV_img;
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
