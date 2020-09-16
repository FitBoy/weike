//
//  TextTopicTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "TextTopicTableViewCell.h"

@implementation TextTopicTableViewCell

-(UILabel *)L_contents{
    
    if (!_L_contents) {
        _L_contents =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_contents];
        _L_contents.numberOfLines =0;
        _L_contents.font = [UIFont systemFontOfSize:16];
        [_L_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-15);
        }];
    }
    return _L_contents;
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
