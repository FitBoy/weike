//
//  SwitchTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell

-(UISwitch *)S_kai{
    
    if (!_S_kai) {
        _S_kai = [[UISwitch alloc]init];
        [self.V_bg addSubview:_S_kai];
        [_S_kai mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        [_S_kai setOn:YES];
        _S_kai.onTintColor = [UIColor colorWithRed:53/255.0 green:127/255.0 blue:246/255.0 alpha:1];
        [self.L_name mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.S_kai.mas_left).mas_offset(-5);
            make.height.mas_equalTo(30);
        }];

    }
    return _S_kai;
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
