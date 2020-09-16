//
//  CircleImageView.h
//  social
//
//  Created by QianYuan on 2020/9/16.
//  Copyright © 2020 QianYuan. All rights reserved.
// 圆角的imageView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleImageView : UIImageView

-(instancetype)init;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,weak) id delegate_imageV;

@end
@protocol CircleImageViewDelegate <NSObject>

-(void)getClickImageV:(NSInteger)index  imageV:(UIImageView *)imageV;

@end

NS_ASSUME_NONNULL_END
