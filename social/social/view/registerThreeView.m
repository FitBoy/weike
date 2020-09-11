//
//  registerThreeView.m
//  social
//
//  Created by QianYuan on 2020/9/1.
//  Copyright © 2020 QianYuan. All rights reserved.
//
#define width_height  60
#import "registerThreeView.h"
#import <Masonry.h>
@implementation registerThreeView

-(void)setImge{
    
    self.IV_qq.image = [UIImage imageNamed:@"qq"];
    self.IV_weibo.image =[UIImage imageNamed:@"weibo"];
    self.IV_wechat.image =[UIImage imageNamed:@"wechat"];
    self.IV_line.image = [UIImage imageNamed:@"register_other"];
}
-(UIImageView *) IV_line {
    
    if (!_IV_line) {
        _IV_line = [[UIImageView alloc]init];
        [self addSubview:_IV_line];
        [_IV_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300, 13));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self);
        }];
    }
    return _IV_line;
}

-(UIImageView *) IV_qq{
    
    if (!_IV_qq) {
        
        _IV_qq = [[UIImageView alloc]init];
        [self addSubview:_IV_qq];
        [_IV_qq mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width_height, width_height));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        _IV_qq.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Click_qq)];
        [_IV_qq addGestureRecognizer:tap];
        
    }
    return _IV_qq;
}

-(UIImageView *)IV_wechat{
    if (!_IV_wechat) {
        _IV_wechat = [[UIImageView alloc]init];
        [self addSubview:_IV_wechat];
        [_IV_wechat mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width_height, width_height));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.IV_qq.mas_left).mas_offset(-width_height);
        }];
        _IV_wechat.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_wechat)];
        [_IV_wechat addGestureRecognizer:tap];
    }
    return _IV_wechat;
}
-(UIImageView *)IV_weibo{
    
    if (!_IV_weibo) {
        _IV_weibo = [[UIImageView alloc]init];
        [self addSubview:_IV_weibo];
        [_IV_weibo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width_height, width_height));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_qq.mas_right).mas_offset(width_height);
        }];
        _IV_weibo.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_weibo)];
        [_IV_weibo addGestureRecognizer:tap];
        
        
    }
    return _IV_weibo;
}

-(UIViewController *)viewController{
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}

-(void)Click_qq{
    UIViewController *vc = [self viewController];
    
    
}
-(void)click_wechat{
   UIViewController *vc = [self viewController];
    
}
-(void)click_weibo{
   UIViewController *vc = [self viewController];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
