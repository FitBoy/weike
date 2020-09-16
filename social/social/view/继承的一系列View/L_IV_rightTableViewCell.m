//
//  L_IV_rightTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "L_IV_rightTableViewCell.h"

@implementation L_IV_rightTableViewCell

-(UIImageView *)IV_more{
    
    if (!_IV_more) {
        _IV_more = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_more];
        _IV_more.image = [UIImage imageNamed:@"back"];
        [_IV_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 17.5));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-15);
        }];
    }
    return _IV_more;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
