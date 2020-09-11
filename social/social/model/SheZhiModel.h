//
//  SheZhiModel.h
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SheZhiModel : NSObject

@property (nonatomic,copy) NSString * user_id;
@property (nonatomic,copy) NSString * stranger;
@property (nonatomic,copy) NSString * verify;
@property (nonatomic,copy) NSString * job_number;
@property (nonatomic,copy) NSString * mobile;
@property (nonatomic,copy) NSString * notice_shake; //震动
@property (nonatomic,copy) NSString * notice_voice;//声音
@property (nonatomic,copy) NSString * background_img;
@property (nonatomic,copy) NSString * background_id;

@end

NS_ASSUME_NONNULL_END
