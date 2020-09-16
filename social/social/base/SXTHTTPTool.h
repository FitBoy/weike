//
//  SXTHTTPTool.h
//  BestGuessNoAnswerDemo
//
//  Created by zmh on 2019/7/19.
//  Copyright © 2019 AntTechnology. All rights reserved.
//

//用户信息
#define UserInfo                        [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"]
//token
#define TokenInfo                       [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]
//用户ID
#define UserId                          [NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"id"]]


//占位图
#define ZdyPlaceholderImage             [UIImage imageNamed:@"404.jpg"]
//服务器地址
#define ServerAdress                    @"http://sfn.zhucaiyan.cn"
//WEB图片地址
#define WebServerAdress                 @"http://xzy.zgzntc.cn"
//图片地址
#define ImageServerAdress               @"https://developbucket.oss-cn-qingdao.aliyuncs.com/"
//视频地址
#define VideoServerAdress               @"https://developbucket.oss-cn-qingdao.aliyuncs.com/"

#define topic_sendsuccess @"topic_sendsuccess"

#define index_page @"/api/index/page"

#define register @"/api/auth/register" //注册
#define sms @"/api/sms" //发送短信
#define auth_login @"/api/auth/login"
#define auth_fastlogin @"/api/auth/fastlogin"
#define auth_forget @"/api/auth/forget"
#define auth_me  @"/api/auth/me"  //获取个人信息
#define base64Upload  @"/api/base64Upload"
#define user_department  @"/api/user/department"
#define getStationByDepartment  @"/api/user/getStationByDepartment"
#define getLetterCity  @"/api/getLetterCity"
#define user_profile @"/api/user/profile" //修改个人信息
#define user_changeMobile @"/api/auth/changeMobile" //修改手机号
#define userSetting  @"/api/user/userSetting" // 用户设置
#define getUserSetting  @"/api/user/getUserSetting"
#define  user_setBackground  @"/api/user/setBackground"


#import <AFNNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^requestSuccessBlock)(id responseObject);
typedef void(^requestErrorBlock)(NSError *error);

@interface SXTHTTPTool : AFHTTPSessionManager

+ (void)addHeaderToken:(NSString *)token;

#pragma mark --GET请求
+ (void)getData:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)returnSuccess error:(requestErrorBlock)returnError;

#pragma mark --POST请求
+ (void)postData:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)returnSuccess error:(requestErrorBlock)returnError;

#pragma mark --POST提交请求（视频）
+ (void)postData:(NSString *)url parameters:(NSDictionary *)param constructBody:(NSArray *)bodyArry success:(requestSuccessBlock)returnSuccess error:(requestErrorBlock)returnError;

//#pragma mark --网络监听
//- (void)reachabilityManager;

@end

NS_ASSUME_NONNULL_END
