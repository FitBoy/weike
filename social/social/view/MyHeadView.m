//
//  MyHeadView.m
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "MyHeadView.h"
#import <Masonry.h>
#import <SDWebImage.h>
@implementation MyHeadView

-(void)setModel:(UserModel * _Nonnull)model{
    
    _model = model;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.head_image]];
    self.L_name.text = model.name;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:model.job_number attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    NSMutableAttributedString *depart = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" | %@ | %@",model.department_text,model.station_text] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [attr appendAttributedString:depart];
    self.yl_more.attributedText = attr;
}
-(YYLabel *)yl_more{
    if (!_yl_more) {
        _yl_more = [[YYLabel alloc]init];
        [self addSubview:_yl_more];
        
        [_yl_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.L_name.mas_left);
            make.top.mas_equalTo(self.IV_head.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
    }
    return _yl_more;
}


-(UILabel *)L_name{
    
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font  = [UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(20);
            make.right.mas_equalTo(self.mas_right).mas_offset(-5);
            make.bottom.mas_equalTo(self.IV_head.mas_centerY);
        }];
    }
    return _L_name;
}
-(UIImageView *)IV_head{
    
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        [self addSubview:_IV_head];
        _IV_head.layer.masksToBounds =YES;
        _IV_head.layer.cornerRadius =15;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _IV_head;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
