//
//  IVLLIVTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/8.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "IVLLIVTableViewCell.h"
#import <Masonry.h>

@implementation IVLLIVTableViewCell

-(void)setLocalImg:(NSString *)img  left:(NSString*)left  right:(NSString*)right{
    
    [self.L_text mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(20);
        make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.L_right.mas_left).mas_offset(-5);
    }];
    self.IV_img.image = [UIImage imageNamed:img];
    self.L_text.text = left;
    self.L_right.text = right;
    
}

-(UILabel *)L_right{
    
    if (!_L_right) {
        _L_right = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_right];
        _L_right.font = [UIFont systemFontOfSize:13];
        _L_right.textAlignment = NSTextAlignmentRight;
        _L_right.textColor = [UIColor grayColor];
        [_L_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.IV_more.mas_left).mas_offset(-5);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.L_text.mas_right);
        }];
    }
    return _L_right;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
