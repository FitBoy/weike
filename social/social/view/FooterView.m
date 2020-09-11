//
//  FooterView.m
//  TemplateProject
//
//  Created by QianYuan on 2020/9/9.
//  Copyright © 2020 Qianyuan. All rights reserved.
//

#import "FooterView.h"
#import <Masonry.h>
@implementation FooterView

-(UILabel*)L_search{
    
    if (!_L_search) {
        _L_search = [[UILabel alloc]init];
        [self addSubview:_L_search];
        [_L_search mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.center.mas_equalTo(self);
        }];
        _L_search.textAlignment = NSTextAlignmentCenter;
        _L_search.textColor = [UIColor whiteColor];
        _L_search.backgroundColor = [UIColor colorWithRed:53/255.0 green:127/255.0 blue:246/255.0 alpha:1];
        _L_search.userInteractionEnabled = YES;
        _L_search.layer.masksToBounds = YES;
        _L_search.layer.cornerRadius =25;
        _L_search.font = [UIFont systemFontOfSize:19];
    }
    return _L_search;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
