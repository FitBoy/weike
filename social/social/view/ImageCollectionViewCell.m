//
//  ImageCollectionViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import <Masonry.h>
@implementation ImageCollectionViewCell
-(UIImageView *)IV_image{
    
    if (!_IV_image) {
       _IV_image = [[UIImageView alloc]init];
        [self addSubview:_IV_image];
        _IV_image.userInteractionEnabled =YES;
        _IV_image.layer.masksToBounds =YES;
        _IV_image.layer.cornerRadius = 6;
        [_IV_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return _IV_image;
}
@end
