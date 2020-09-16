//
//  UserModel.h
//  social
//
//  Created by QianYuan on 2020/9/5.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
@property (nonatomic,copy) NSString * age; //年龄
@property (nonatomic,copy) NSString * avatar; //头像
@property (nonatomic,copy) NSString * head_image; //头像的绝对地址
@property (nonatomic,copy) NSString *city_id;
@property (nonatomic,copy) NSString * created_at;
@property (nonatomic,copy) NSString * department;
@property (nonatomic,copy) NSString * department_text;
@property (nonatomic,copy) NSString * city_text;
@property (nonatomic,copy) NSString * gender;
@property (nonatomic,copy) NSString * Id;
@property (nonatomic,copy) NSString * job_number;//工号
@property (nonatomic,copy) NSString * last_login;
@property (nonatomic,copy) NSString * level_text;
@property (nonatomic,copy) NSString * mobile; //手机
@property (nonatomic,copy) NSString * name; //昵称
@property (nonatomic,copy) NSString * paypwd;
@property (nonatomic,copy) NSString * pid;
@property (nonatomic,copy) NSString * pids;
@property (nonatomic,copy) NSString * realname;
@property (nonatomic,copy) NSString * referral_code;
@property (nonatomic,copy) NSString * referral_img;
@property (nonatomic,copy) NSString * sign;
@property (nonatomic,copy) NSString * station; //岗位
@property (nonatomic,copy) NSString * station_text;
@property (nonatomic,copy) NSString * updated_at;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * birthday;

@property (nonatomic,copy) NSString * gender_text;

@property (nonatomic,strong) UIColor *color_sex;

-(NSString *)birthday;
-(NSString*)head_image;
-(NSString *)sex;

-(NSAttributedString *)formatterSex_age;


@end

NS_ASSUME_NONNULL_END
