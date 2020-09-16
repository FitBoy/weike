//
//  BaseTopicListTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "BaseTopicListTableViewCell.h"

@implementation BaseTopicListTableViewCell

-(UIImageView *)IV_share{
    
    if (!_IV_share) {
       _IV_share = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_share];
        [_IV_share mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.IV_liuyan.mas_centerY);
            make.left.mas_equalTo(self.L_liuyan.mas_right).mas_offset(5);
        }];
        _IV_share.userInteractionEnabled =YES;
    }
    return _IV_share;
}

-(UILabel *)L_liuyan{
    
    if (!_L_liuyan) {
        _L_liuyan = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_liuyan];
        _L_liuyan.font = [UIFont systemFontOfSize:15];
        _L_liuyan.textColor = [UIColor grayColor];
        [_L_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.centerY.mas_equalTo(self.IV_liuyan.mas_centerY);
            make.left.mas_equalTo(self.IV_liuyan.mas_right).mas_offset(5);
        }];
    }
    return _L_liuyan;
}

-(UIImageView *)IV_liuyan{
    
    if (!_IV_liuyan) {
        _IV_liuyan = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_liuyan];
        [_IV_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(self.L_zan.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.IV_zan.mas_centerY);
        }];
        
        _IV_liuyan.userInteractionEnabled = YES;
      
    }
    return _IV_liuyan;
}

-(UILabel *)L_zan{
    
    if (!_L_zan) {
        _L_zan = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_zan];
        _L_zan.font = [UIFont systemFontOfSize:15];
        _L_zan.textColor = [UIColor grayColor];
        [_L_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.left.mas_equalTo(self.IV_zan.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.IV_zan.mas_centerY);
        }];
    }
    return _L_zan;
}

-(UIImageView *)IV_zan{
    
    if (!_IV_zan) {
        _IV_zan = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_zan];
        [_IV_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.bottom.mas_equalTo(self.V_bg).mas_offset(-5);
        }];
        _IV_zan.userInteractionEnabled = YES;
        _IV_zan.image = [UIImage imageNamed:@"zan_no"];
        
      
    }
    return _IV_zan;
    
}
-(YYLabel *)yl_time_adress{
    
    if (!_yl_time_adress) {
        _yl_time_adress = [[YYLabel alloc]init];
        [self.V_bg addSubview:_yl_time_adress];
        [_yl_time_adress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.V_bg).mas_offset(-15);
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(self.IV_zan.mas_top).mas_offset(-5);
        }];
    }
    return _yl_time_adress;
}
-(YYLabel *)yl_sex{
    
    if (!_yl_sex) {
        _yl_sex = [[YYLabel alloc]init];
        [self.V_bg addSubview:_yl_sex];
        _yl_sex.layer.masksToBounds =YES;
        _yl_sex.layer.cornerRadius =7.5;
        [_yl_sex mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 15));
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.L_name.mas_bottom);
        }];
    }
    return _yl_sex;
}

-(UILabel *)L_name{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-5);
            make.top.mas_equalTo(self.IV_head.mas_top);
        }];
        _L_name.userInteractionEnabled = YES;
      
    }
    return _L_name;
}


-(HeadImageView *)IV_head{
    
    if (!_IV_head) {
        _IV_head = [[HeadImageView alloc]init];
        [self.V_bg addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.V_bg).mas_offset(5);
        }];
        _IV_head.userInteractionEnabled = YES;
      
    }
    return _IV_head;
}

-(UIView *)V_bg{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
    }
    return _V_bg;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
