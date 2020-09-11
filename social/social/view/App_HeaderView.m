//
//  App_HeaderView.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "App_HeaderView.h"
#import <Masonry.h>
@implementation App_HeaderView

-(UIImageView *)IV_name{
    
    if (!_IV_name) {
     _IV_name = [[UIImageView alloc]init];
        [self addSubview:_IV_name];
        _IV_name.image = [UIImage imageNamed:@"app_name"];
        [_IV_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(113, 23));
            make.centerX.mas_equalTo(self.IV_logo.mas_centerX);
            make.top.mas_equalTo(self.IV_logo.mas_bottom).mas_offset(15);
        }];
    }
    return _IV_name;
}


-(UIImageView *)IV_logo{
    
    if (!_IV_logo) {
        _IV_logo = [[UIImageView alloc]init];
        [self addSubview:_IV_logo];
        [_IV_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.center.mas_equalTo(self);
        }];
        _IV_logo.layer.masksToBounds = YES;
        _IV_logo.layer.cornerRadius = 15;
        _IV_logo.image= [UIImage imageNamed:@"app_logo"];
    }
    return _IV_logo;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
