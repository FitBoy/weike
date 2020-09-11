//
//  LineTextField.m
//  social
//
//  Created by QianYuan on 2020/9/1.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "LineTextField.h"

@implementation LineTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context =UIGraphicsGetCurrentContext();

    //设置下划线的颜色

    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);

    //设置textField的frame

    CGContextFillRect(context,CGRectMake(0,CGRectGetHeight(self.frame) -0.5,CGRectGetWidth(self.frame),0.5));

}

@end
