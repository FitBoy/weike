//
//  LIVIVTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/3.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "LIVIVTableViewCell.h"
#import <Masonry.h>
@implementation LIVIVTableViewCell

-(HeadImageView *) IV_head{
    if (!_IV_head) {
        _IV_head = [[HeadImageView alloc]init];
        _IV_head.IV_pre.hidden =NO;
        [self.V_bg addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.IV_right.mas_left).mas_offset(-5);
        }];
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius =15;
        _IV_head.userInteractionEnabled = YES;
    }
    return _IV_head;
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
