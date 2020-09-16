//
//  Image_textTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/16.
//  Copyright © 2020 QianYuan. All rights reserved.
//



#import "Image_textTableViewCell.h"
#import <SDWebImage.h>

@implementation Image_textTableViewCell
/// 隐藏所有的图片
-(void)setImageVHidden{
    self.IV_img0.hidden =YES;
    self.IV_img1.hidden =YES;
    self.IV_img2.hidden =YES;
    
    self.IV_img3.hidden =YES;
    self.IV_img4.hidden =YES;
    self.IV_img5.hidden =YES;
    
    self.IV_img6.hidden =YES;
    self.IV_img7.hidden =YES;
    self.IV_img8.hidden =YES;
    
    self.IV_bofang.hidden =YES;
    
}

-(void)setModel:(TopicModel *)model{
    _model = model;
    
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.user.head_image]];
    self.L_name.text = model.user.name;
    self.yl_sex.attributedText = model.user.formatterSex_age;
    self.yl_sex.backgroundColor = model.user.color_sex;
    self.yl_time_adress.attributedText = model.formatterTime_address;
    self.IV_zan.image = model.likeImage;
    self.L_zan.text = model.like_num;
    self.IV_liuyan.image = [UIImage imageNamed:@"pinglun"];
    self.L_liuyan.text = model.comment_num;
    self.IV_share.image = [UIImage imageNamed:@"share"];
    model.model_height = 110;
    
    [self setImageVHidden];
    
    float space =5;
    float width = (MainScreenWidth-30-space*2)/3.0;
    
    if (model.title.length!=0) {
        self.L_contents.text = model.title;
        CGSize size = [model.title boundingRectWithSize:CGSizeMake(MainScreenWidth-32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        [self.L_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg).mas_offset(15);
            make.right.mas_equalTo(self.V_bg).mas_offset(-15);
            make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(size.height +5);
        }];
        model.model_height = model.model_height +size.height+10;
        if(model.images.count==0){
           //判断是不是视频  这里面要完善信息
            if (model.video.length!=0) {
                self.IV_img0.hidden = NO;
                self.IV_bofang.hidden =NO;
                
                float video_h = MainScreenWidth*2/3.0;
                float video_w = video_h*9/16.0;
                
                [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(video_w, video_h));
                    make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
                    make.top.mas_equalTo(self.L_contents.mas_bottom);
                }];
                [self.IV_img0 sd_setImageWithURL:[NSURL URLWithString:model.snapshot]];
                model.model_height = model.model_height + video_h;
            }
            
        }else if (model.images.count==1){
            //一张图效果
            
            self.IV_img0.hidden = NO;
            imageBaseModel *image0 = model.images_arr[0];
            
            float image0_w;
            float image0_h;
            if ([image0.width floatValue] > [image0.height floatValue]) {
                image0_w = MainScreenWidth *2/3.0;
                image0_h = image0_w *[image0.height floatValue] /[image0.width floatValue];
            }else{
                image0_h =MainScreenWidth *2/3.0;
                image0_w = image0_h *[image0.width floatValue]/[image0.height floatValue];
            }
            
            [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(image0_w, image0_h));
                make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
                make.top.mas_equalTo(self.L_contents.mas_bottom);
            }];
            [self.IV_img0 sd_setImageWithURL:[NSURL URLWithString:image0.src]];
          model.model_height = model.model_height + image0_h;
            
        }else if (model.images.count ==4){
           //四张图效果
            self.IV_img0.hidden = NO;
            [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(width, width));
                make.top.mas_equalTo(self.L_contents.mas_bottom);
                make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
            }];
            [self setImageView4];
            
            model.model_height = model.model_height + width*2+space*2;
            
        }else {
           //其他图的效果
                self.IV_img0.hidden = NO;
                [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(width, width));
                    make.top.mas_equalTo(self.L_contents.mas_bottom);
                    make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
                }];
            [self setImageVWithimageCount:model.images.count];
            
            if (model.images.count < 4) {
                 model.model_height = model.model_height + width+space;
            }else if (model.images.count <7){
                model.model_height = model.model_height + (width+space)*2;
            }else{
              model.model_height = model.model_height + (width+space)*3;
            }
        }
        
    }else{
       //没有文本的图片处理
        self.L_contents.text = nil;
        if(model.images.count==0){
                  //判断是不是视频  这里面要完善信息
                   if (model.video.length!=0) {
                       self.IV_img0.hidden = NO;
                       self.IV_bofang.hidden =NO;
                       
                       float video_h = MainScreenWidth*2/3.0;
                       float video_w = video_h*9/16.0;
                       [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                           make.size.mas_equalTo(CGSizeMake(video_w, video_h));
                           make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
                           make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(space);
                       }];
                       [self.IV_img0 sd_setImageWithURL:[NSURL URLWithString:model.snapshot]];
                       model.model_height = model.model_height + video_h;
                   }
                   
               }else if (model.images.count==1){
                   //一张图效果
                   
                   self.IV_img0.hidden = NO;
                   imageBaseModel *image0 = self.model.images_arr[0];
                   float image0_w;
                   float image0_h;
                   if ([image0.width floatValue] > [image0.height floatValue]) {
                       image0_w = MainScreenWidth *2/3.0;
                       image0_h = image0_w *[image0.height floatValue] /[image0.width floatValue];
                   }else{
                       image0_h =MainScreenWidth *2/3.0;
                       image0_w = image0_h *[image0.width floatValue]/[image0.height floatValue];
                   }
                   
                   [self.IV_img0 sd_setImageWithURL:[NSURL URLWithString:image0.src]];
                   [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.size.mas_equalTo(CGSizeMake(image0_w, image0_h));
                       make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
                       make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(space);
                   }];
                    model.model_height = model.model_height +image0_h;
                   
               }else if (model.images.count ==4){
                  //四张图效果
                   self.IV_img0.hidden = NO;
                   [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.size.mas_equalTo(CGSizeMake(width, width));
                       make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(space);
                       make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
                   }];
                   self.IV_img0.backgroundColor = [UIColor redColor];
                   [self setImageView4];
                   model.model_height = model.model_height + width*2+space*3;
                   
               }else {
                  //其他图的效果
                       self.IV_img0.hidden = NO;
                       [self.IV_img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                           make.size.mas_equalTo(CGSizeMake(width, width));
                           make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(space);
                           make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15);
                       }];
                       self.IV_img0.backgroundColor = [UIColor redColor];
                   [self setImageVWithimageCount:model.images.count];
                   
                          if (model.images.count < 4) {
                                 model.model_height = model.model_height + width+space;
                            }else if (model.images.count <7){
                                model.model_height = model.model_height + (width+space)*2;
                            }else{
                              model.model_height = model.model_height + (width+space)*3;
                            }
               }
        
        
        
        
    }
    
    
}

#pragma mark -- 四张图片的展示效果
-(void)setImageView4{
    
           float space =5;
           float width = (MainScreenWidth-30-space*2)/3.0;
             self.IV_img1.hidden = NO;
               [self.IV_img1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.size.mas_equalTo(CGSizeMake(width, width));
                   make.top.mas_equalTo(self.IV_img0);
                   make.left.mas_equalTo(self.IV_img0.mas_right).mas_offset(space);
               }];
               
               self.IV_img2.hidden = NO;
               [self.IV_img2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.size.mas_equalTo(CGSizeMake(width, width));
                   make.top.mas_equalTo(self.IV_img0.mas_bottom).mas_offset(space);
                   make.left.mas_equalTo(self.IV_img0.mas_left);
               }];
               
               self.IV_img3.hidden = NO;
               [self.IV_img3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.size.mas_equalTo(CGSizeMake(width, width));
                   make.top.mas_equalTo(self.IV_img0.mas_bottom).mas_offset(space);
                   make.left.mas_equalTo(self.IV_img2.mas_right).mas_offset(space);
               }];
    
               imageBaseModel *image0 = self.model.images_arr[0];
               imageBaseModel *image1 = self.model.images_arr[1];
               imageBaseModel *image2 = self.model.images_arr[2];
               imageBaseModel *image3 = self.model.images_arr[3];
               
               [self.IV_img0 sd_setImageWithURL:[NSURL URLWithString:image0.src]];
               [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:image1.src]];
               [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:image2.src]];
               [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:image3.src]];
    
}

#pragma mark -- 以 第一张图片为参考，来调整其他的布局  num = 2,3,5,6,7,8,9
-(void)setImageVWithimageCount:(NSInteger)num{
    float space =5;
    float width = (MainScreenWidth-30-space*2)/3.0;
    imageBaseModel *image0 = self.model.images_arr[0];
    [self.IV_img0 sd_setImageWithURL:[NSURL URLWithString:image0.src]];
    
    [self addEvent];
    if (num >1) {
        self.IV_img1.hidden =NO;
        [self.IV_img1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.mas_equalTo(self.IV_img0.mas_right).mas_offset(space);
            make.top.mas_equalTo(self.IV_img0);
        }];
        imageBaseModel *image1 = self.model.images_arr[1];
        [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:image1.src]];
        if (num>2) {
            self.IV_img2.hidden =NO;
            [self.IV_img2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(width, width));
                make.top.mas_equalTo(self.IV_img0);
                make.left.mas_equalTo(self.IV_img1.mas_right).mas_offset(space);
            }];
            imageBaseModel *image2= self.model.images_arr[2];
            [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:image2.src]];
            if (num >4) {
                self.IV_img3.hidden = NO;
                [self.IV_img3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(width, width));
                    make.top.mas_equalTo(self.IV_img0.mas_bottom).mas_offset(space);
                    make.left.mas_equalTo(self.IV_img0);
                }];
                imageBaseModel *image3= self.model.images_arr[3];
                [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:image3.src]];
                
                
                self.IV_img4.hidden =NO;
                [self.IV_img4 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(width, width));
                    make.top.mas_equalTo(self.IV_img0.mas_bottom).mas_offset(space);
                    make.left.mas_equalTo(self.IV_img3.mas_right).mas_offset(space);
                }];
                imageBaseModel *image4 = self.model.images_arr[4];
                [self.IV_img4 sd_setImageWithURL:[NSURL URLWithString:image4.src]];
                
                if (num >5) {
                    self.IV_img5.hidden = NO;
                    [self.IV_img5 mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(width, width));
                        make.top.mas_equalTo(self.IV_img0.mas_bottom).mas_offset(space);
                        make.left.mas_equalTo(self.IV_img4.mas_right).mas_offset(space);
                    }];
                    imageBaseModel *image5 = self.model.images_arr[5];
                    [self.IV_img5 sd_setImageWithURL:[NSURL URLWithString:image5.src]];
                    if (num >6) {
                        self.IV_img6.hidden =NO;
                        [self.IV_img6 mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.size.mas_equalTo(CGSizeMake(width, width));
                            make.top.mas_equalTo(self.IV_img3.mas_bottom).mas_offset(space);
                            make.left.mas_equalTo(self.IV_img3);
                        }];
                        imageBaseModel *image6 = self.model.images_arr[6];
                        [self.IV_img6 sd_setImageWithURL:[NSURL URLWithString:image6.src]];
                        if (num >7) {
                            self.IV_img7.hidden =NO;
                            [self.IV_img7 mas_remakeConstraints:^(MASConstraintMaker *make) {
                                make.size.mas_equalTo(CGSizeMake(width, width));
                                make.top.mas_equalTo(self.IV_img3.mas_bottom).mas_offset(space);
                                make.left.mas_equalTo(self.IV_img6.mas_right).mas_offset(space);
                            }];
                            
                            imageBaseModel *image7 = self.model.images_arr[7];
                            [self.IV_img7 sd_setImageWithURL:[NSURL URLWithString:image7.src]];
                            if (num >8) {
                                self.IV_img8.hidden =NO;
                                [self.IV_img8 mas_remakeConstraints:^(MASConstraintMaker *make) {
                                    make.size.mas_equalTo(CGSizeMake(width, width));
                                    make.top.mas_equalTo(self.IV_img3.mas_bottom).mas_offset(space);
                                    make.left.mas_equalTo(self.IV_img7.mas_right).mas_offset(space);
                                }];
                                imageBaseModel *image8 = self.model.images_arr[8];
                                [self.IV_img8 sd_setImageWithURL:[NSURL URLWithString:image8.src]];
                            }
                        }
                    }
                }
            }
        }
    }
    
}

-(void)getClickImageV:(NSInteger)index imageV:(UIImageView *)imageV{
    
    if ([self.delegate_image_text respondsToSelector:@selector(ClickImageV:Model:)]) {
        [self.delegate_image_text ClickImageV:index Model:self.model];
    }
}

-(void)addEvent{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickHead)];
    [self.IV_head addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicknickname)];
      [self.L_name addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickZan)];
    [self.IV_zan addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickShare)];
    [self.IV_share addGestureRecognizer:tap3];
    
    
    
}
#pragma mark -- 分享
-(void)ClickShare{
    if ([self.delegate_image_text respondsToSelector:@selector(ClickShareWIthModel:)]) {
        [self.delegate_image_text ClickShareWIthModel:self.model];
    }
}
#pragma mark -- 点赞
-(void)ClickZan{
    if ([self.delegate_image_text respondsToSelector:@selector(ClickZanWIthModel:)]) {
        [self.delegate_image_text ClickZanWIthModel:self.model];
    }
}
#pragma mark -- 昵称
-(void)Clicknickname{
    if ([self.delegate_image_text respondsToSelector:@selector(ClickNickNameWIthModel:)]) {
        [self.delegate_image_text ClickNickNameWIthModel:self.model];
    }
}
#pragma mark -- 头像
-(void)ClickHead{
    if ([self.delegate_image_text respondsToSelector:@selector(ClickHeadWIthModel:)]) {
        [self.delegate_image_text ClickHeadWIthModel:self.model];
    }
}
-(CircleImageView *)IV_img0{
    
    if (!_IV_img0) {
       _IV_img0 = [[CircleImageView alloc]init];
        _IV_img0.index = 0;
        _IV_img0.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img0];
       
    }
    return _IV_img0;
}
-(CircleImageView *)IV_img1{
    
    if (!_IV_img1) {
       _IV_img1 = [[CircleImageView alloc]init];
        _IV_img1.index = 1;
        _IV_img1.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img1];
       
    }
    return _IV_img1;
}
-(CircleImageView *)IV_img2{
    
    if (!_IV_img2) {
       _IV_img2 = [[CircleImageView alloc]init];
        _IV_img2.index = 2;
        _IV_img2.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img2];
       
    }
    return _IV_img2;
}
-(CircleImageView *)IV_img3{
    
    if (!_IV_img3) {
       _IV_img3 = [[CircleImageView alloc]init];
        _IV_img3.index = 3;
        _IV_img3.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img3];
       
    }
    return _IV_img3;
}
-(CircleImageView *)IV_img4{
    
    if (!_IV_img4) {
       _IV_img4 = [[CircleImageView alloc]init];
        _IV_img4.index = 4;
        _IV_img4.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img4];
       
    }
    return _IV_img4;
}

-(CircleImageView *)IV_img5{
    
    if (!_IV_img5) {
       _IV_img5 = [[CircleImageView alloc]init];
        _IV_img5.index = 5;
        _IV_img5.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img5];
       
    }
    return _IV_img5;
}
-(CircleImageView *)IV_img6{
    
    if (!_IV_img6) {
       _IV_img6 = [[CircleImageView alloc]init];
        _IV_img6.index = 6;
        _IV_img6.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img6];
       
    }
    return _IV_img6;
}
-(CircleImageView *)IV_img7{
    
    if (!_IV_img7) {
       _IV_img7 = [[CircleImageView alloc]init];
        _IV_img7.index = 7;
        _IV_img7.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img7];
       
    }
    return _IV_img7;
}
-(CircleImageView *)IV_img8{
    
    if (!_IV_img8) {
       _IV_img8 = [[CircleImageView alloc]init];
        _IV_img8.index = 8;
        _IV_img8.delegate_imageV =self;
        [self.V_bg addSubview:_IV_img8];
       
    }
    return _IV_img8;
}

-(UIImageView *)IV_bofang{
    
    if (!_IV_bofang) {
        _IV_bofang = [[UIImageView alloc]init];
        [self.IV_img0 addSubview:_IV_bofang];
        [_IV_bofang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.center.mas_equalTo(self.IV_img0);
        }];
        _IV_bofang.image = [UIImage imageNamed:@"videoPlay"];
        _IV_bofang.userInteractionEnabled = YES;
    }
    return _IV_bofang;
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
