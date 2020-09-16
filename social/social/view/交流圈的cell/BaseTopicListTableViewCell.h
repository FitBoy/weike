//
//  BaseTopicListTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
// 最基础的cell

#import <UIKit/UIKit.h>
#import "HeadImageView.h"
#import <YYText.h>
#import <Masonry.h>
#import "TopicModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTopicListTableViewCell : UITableViewCell

@property (nonatomic,strong)UIView *V_bg;

@property (nonatomic,strong) HeadImageView *IV_head;
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong) YYLabel *yl_sex;

@property (nonatomic,strong) YYLabel *yl_time_adress;

@property (nonatomic,strong) UIImageView *IV_zan;
@property (nonatomic,strong) UILabel *L_zan;
@property (nonatomic,strong) UIImageView *IV_liuyan;
@property (nonatomic,strong) UILabel *L_liuyan;
@property (nonatomic,strong) UIImageView *IV_share;




///基本要有的height 60+20+30=110
@property (nonatomic,assign) float height_cell;



@end


NS_ASSUME_NONNULL_END
