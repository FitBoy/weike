//
//  ImageSelectedCollectionViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "ImageSelectedCollectionViewCell.h"
#import <Masonry.h>
@implementation ImageSelectedCollectionViewCell
-(UIImageView *)IV_selected{
    if(!_IV_selected){
        _IV_selected = [[UIImageView alloc]init];
        [self.IV_image addSubview:_IV_selected];
        [_IV_selected mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(self.IV_image.mas_right).mas_offset(-5);
            make.top.mas_equalTo(self.IV_image).mas_offset(5);
        }];
        _IV_selected.tag =0;
        _IV_selected.image = [UIImage imageNamed:@"xieyi1"];
    }
    return _IV_selected;
}

-(void)setselected{
    self.IV_selected.image = [UIImage imageNamed:@"xieyi"];
}
-(void)setdisSelected{
    self.IV_selected.image = [UIImage imageNamed:@"xieyi1"];
}
@end
