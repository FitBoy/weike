//
//  LL_LIVTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/4.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "LL_LIVTableViewCell.h"
#import <Masonry.h>

@implementation LL_LIVTableViewCell
-(void)setUI{
    self.L_left.text = @"工号";
    self.IV_right.hidden =NO;
    self.L_tishi.text = @"* 无工号不能出现在附近人列表";
    self.IV_img.hidden = NO;
    
}
-(UIImageView *)IV_img{
    
    if (!_IV_img) {
       _IV_img = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(95, 61));
            make.centerX.mas_equalTo(self.V_bg.mas_centerX);
            make.top.mas_equalTo(self.L_tishi.mas_bottom);
        }];
        _IV_img.image = [UIImage imageNamed:@"camera_gonghao"];
    }
    return _IV_img;
}

-(UILabel *)L_tishi{
    if (!_L_tishi) {
        _L_tishi = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_tishi];
        [_L_tishi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.L_left.mas_bottom);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-15);
            make.height.mas_equalTo(20);
        }];
        _L_tishi.font = [UIFont systemFontOfSize:13];
        _L_tishi.textColor = [UIColor redColor];
        _L_tishi.text = @"* 无工号不能出现在附近人列表";
    }
    return _L_tishi;
}

-(UIImageView *)IV_right{
    
    if (!_IV_right) {
      _IV_right = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_right];
        _IV_right.image = [UIImage imageNamed:@"back"];
        [_IV_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 17.5));
            make.centerY.mas_equalTo(self.L_left.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-15);
        }];
        
    }
    return _IV_right;
}
-(UITextField *)TF_right{
    
    if (!_TF_right) {
      
        _TF_right = [[UITextField alloc]init];
        [self.V_bg addSubview:_TF_right];
        [_TF_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.IV_right.mas_left).mas_offset(-5);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.L_left.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.V_bg).mas_offset(5);
        }];
        _TF_right.textAlignment = NSTextAlignmentRight;
        _TF_right.font = [UIFont systemFontOfSize:17];
    }
    return _TF_right;
}

-(UILabel *)L_left{
    if (!_L_left) {
        _L_left = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left];
        [_L_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
        }];
        _L_left.font = [UIFont systemFontOfSize:17];
        _L_left.text = @"工号";
        
    }
    return _L_left ;
}
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
