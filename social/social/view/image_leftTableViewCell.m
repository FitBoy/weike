//
//  image_leftTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/14.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "image_leftTableViewCell.h"

@implementation image_leftTableViewCell
-(UIImageView *)IV_image{
    
    if (!_IV_image) {
        _IV_image = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_image];
        [_IV_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(19, 24));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
        }];
        
        [self.L_name mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.IV_image.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.IV_more.mas_left).mas_offset(-5);
        }];
        
    }
    return _IV_image;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
