//
//  TopicModel.h
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "imageBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopicModel : NSObject
@property (nonatomic,copy) NSString * Id;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * user_id;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * is_hidden;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,copy) NSString * is_rec;
@property (nonatomic,copy) NSString * created_at;
@property (nonatomic,copy) NSString * updated_at;
@property (nonatomic,copy) NSString * like_num;
@property (nonatomic,copy) NSString * comment_num;
@property (nonatomic,copy) NSString * view_num;
@property (nonatomic,copy) NSString * lat;
@property (nonatomic,copy) NSString * lng;
@property (nonatomic,copy) NSString * city_code;
@property (nonatomic,copy) NSString * city_id;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * hidden_position;
@property (nonatomic,copy) NSString * collect_num;
@property (nonatomic,copy) NSString * isLike;
@property (nonatomic,copy) NSString * isFollow;
@property (nonatomic,strong) UserModel *user;
@property (nonatomic,copy) NSString * video;
@property (nonatomic,strong) NSArray *images_arr;
@property (nonatomic,copy) NSString * snapshot;

@property (nonatomic,copy) NSString *video_url;

@property (nonatomic,assign) float model_height;

-(NSAttributedString *)formatterTime_address;
-(NSString*)video_url;
-(NSString*)snapshot;
-(UIImage *)likeImage;
@end

NS_ASSUME_NONNULL_END
