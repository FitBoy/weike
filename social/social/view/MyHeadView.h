//
//  MyHeadView.h
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import <YYText.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyHeadView : UIView
@property (nonatomic,strong) UIImageView *IV_head;
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong) YYLabel *yl_more;

@property (nonatomic,strong) UserModel *model;

-(void)setModel:(UserModel * _Nonnull)model;

@end

NS_ASSUME_NONNULL_END
