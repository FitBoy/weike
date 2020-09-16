//
//  Image_textTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/16.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "TextTopicTableViewCell.h"
#import "CircleImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface Image_textTableViewCell : TextTopicTableViewCell<CircleImageViewDelegate>


@property (nonatomic,strong) UIImageView *IV_bofang;

@property (nonatomic,strong) CircleImageView *IV_img0;
@property (nonatomic,strong) CircleImageView *IV_img1;
@property (nonatomic,strong) CircleImageView *IV_img2;
@property (nonatomic,strong) CircleImageView *IV_img3;
@property (nonatomic,strong) CircleImageView *IV_img4;
@property (nonatomic,strong) CircleImageView *IV_img5;
@property (nonatomic,strong) CircleImageView *IV_img6;
@property (nonatomic,strong) CircleImageView *IV_img7;
@property (nonatomic,strong) CircleImageView *IV_img8;

@property (nonatomic,strong) TopicModel *model;
-(void)setModel:(TopicModel *)model;

@property (nonatomic,weak) id delegate_image_text;

@end

@protocol Image_textTableViewCellDelegate <NSObject>

-(void)ClickHeadWIthModel:(TopicModel *)topicModel;
-(void)ClickNickNameWIthModel:(TopicModel *)topicModel;
-(void)ClickZanWIthModel:(TopicModel *)topicModel;
-(void)ClickLiuYanWIthModel:(TopicModel *)topicModel;
-(void)ClickShareWIthModel:(TopicModel *)topicModel;

-(void)ClickImageV:(NSInteger)index Model:(TopicModel*)model;

@end

NS_ASSUME_NONNULL_END
