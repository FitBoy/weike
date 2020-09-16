//
//  CircleImageView.m
//  social
//
//  Created by QianYuan on 2020/9/16.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "CircleImageView.h"
#import "indexPathTapGestureRecognizer.h"
@implementation CircleImageView
-(instancetype)init{
    
    if (self =[super init]) {
        self.userInteractionEnabled = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius =6;
        [self setContentScaleFactor:[[UIScreen mainScreen] scale]];
          self.contentMode =  UIViewContentModeScaleAspectFill;
          self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
          self.clipsToBounds  = YES;
        indexPathTapGestureRecognizer *tap = [[indexPathTapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickTap:)];
        tap.index = self.index;
        [self addGestureRecognizer:tap];
    }
    return self;;
}

-(void)ClickTap:(indexPathTapGestureRecognizer *)tap{
    if ([self.delegate_imageV  respondsToSelector:@selector(getClickImageV:imageV:)]) {
        [self.delegate_imageV getClickImageV:self.index imageV:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
