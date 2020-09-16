//
//  imagePlayCollectionViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "imagePlayCollectionViewCell.h"
#import <Masonry.h>
@implementation imagePlayCollectionViewCell

-(UIImageView *)IV_play{
    
    if (!_IV_play) {
        _IV_play = [[UIImageView alloc]init];
        [self.IV_image addSubview:_IV_play];
        [_IV_play mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.center.mas_equalTo(self.IV_image);
        }];
        _IV_play.userInteractionEnabled = YES;
        _IV_play.image = [UIImage imageNamed:@"videoPlay"];
    }
    return _IV_play;
}
@end
