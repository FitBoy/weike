//
//  TFTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "TFTableViewCell.h"

@implementation TFTableViewCell

-(UITextField *)TF_text{
    
    if (!_TF_text) {
        _TF_text =[[UITextField alloc]init];
        [self.V_bg addSubview:_TF_text];
        _TF_text.font = [UIFont systemFontOfSize:17];
        [_TF_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg).mas_offset(15);
            make.right.mas_equalTo(self.V_bg).mas_offset(-15);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.V_bg);
        }];
    }
    return _TF_text;
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
