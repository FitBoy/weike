//
//  HolderTextView.m
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "HolderTextView.h"

@implementation HolderTextView
-(void)setPlaceHolder:(NSString * _Nonnull)placeHolder{
    _placeHolder = placeHolder;
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeHolder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    
    // same font
    self.font = [UIFont systemFontOfSize:16.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:16.f];
    
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
