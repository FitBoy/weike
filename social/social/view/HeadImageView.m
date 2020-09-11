//
//  HeadImageView.m
//  social
//
//  Created by QianYuan on 2020/9/3.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "HeadImageView.h"
#import <Masonry.h>
@implementation HeadImageView

-(UIImageView *) IV_pre{
    if(!_IV_pre){
        _IV_pre = [[UIImageView alloc]init];
        [self addSubview:_IV_pre];
        [_IV_pre mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(self);
        }];
        _IV_pre.image = [UIImage imageNamed:@"head_pre"];
        _IV_pre.userInteractionEnabled= YES;
    }
    return _IV_pre;
}

@end
