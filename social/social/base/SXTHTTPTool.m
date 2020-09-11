//
//  SXTHTTPTool.m
//  BestGuessNoAnswerDemo
//
//  Created by zmh on 2019/7/19.
//  Copyright © 2019 AntTechnology. All rights reserved.
//

#import "SXTHTTPTool.h"

static SXTHTTPTool *manager = nil;

@implementation SXTHTTPTool

+ (void)addHeaderToken:(NSString *)token{
    //添加请求头
    NSString *header = [NSString stringWithFormat:@"bearer%@",token];
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
}

+ (instancetype)shareInstance{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [SXTHTTPTool manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"text/javascript",@"application/x-www-form-urlencoded",@"multipart/form-data",@"text/html",nil];
        //容错处理
        AFJSONResponseSerializer *JSONResponseSerializer = [AFJSONResponseSerializer serializer];
       // JSONResponseSerializer.removesKeysWithNullValues = YES;
        manager.responseSerializer = JSONResponseSerializer;

    });
    //添加请求头
          NSString *headerToken = [NSString stringWithFormat:@"bearer%@",TokenInfo];
          [manager.requestSerializer setValue:headerToken forHTTPHeaderField:@"Authorization"];
    return manager;
}

#pragma mark --GET请求
+ (void)getData:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)returnSuccess error:(requestErrorBlock)returnError{    
    [[SXTHTTPTool shareInstance] GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (returnSuccess) {
            returnSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (returnError) {
            returnError(error);
        }
    }];
}

#pragma mark --POST请求
+ (void)postData:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)returnSuccess error:(requestErrorBlock)returnError{
    [[SXTHTTPTool shareInstance] POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (returnSuccess) {
            returnSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (returnError) {
            returnError(error);
        }
    }];
}



#pragma mark --POST提交请求（图片file）
+ (void)postData:(NSString *)url parameters:(NSDictionary *)param constructBody:(NSArray *)bodyArry success:(requestSuccessBlock)returnSuccess error:(requestErrorBlock)returnError{
    [[SXTHTTPTool shareInstance] POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<bodyArry.count; i++) {
            NSData *tdata = bodyArry[i];
            [formData appendPartWithFileData:tdata name:@"file" fileName:@"video.mp4" mimeType:@"video/mp4"];
        }
        
        
        /*此方法参数
         1. 要上传的[二进制数据]
         2. 我这里的imgFile是对应后台给你url里面的图片参数，别瞎带。
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
//        for (NSDictionary *dic in bodyArry) {
//            [formData appendPartWithFileData:[dic objectForKey:@"data"] name:[[dic objectForKey:@"name"] isEqualToString:@"sfz"]?@"cardPic":@"zhizhao" fileName:[dic objectForKey:@"fileName"] mimeType:@"image/jpeg"];
//        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (returnSuccess) {
            returnSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (returnError) {
            returnError(error);
        }
    }];
}

#pragma mark --网络监听
//- (void)reachabilityManager{
//    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager manager];
//    [reachabilityManager startMonitoring];
//    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//                //当网络不可用（无网络或请求延时）
//            case AFNetworkReachabilityStatusNotReachable:
//                ZDYLog(@"当网络不可用（无网络或请求延时）");
//                break;
//                
//                //当为手机WiFi时
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                ZDYLog(@"当为手机WiFi时");
//                break;
//                
//                //当为手机蜂窝数据网
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                ZDYLog(@"当为手机蜂窝数据网");
//                break;
//                
//                //其它情况
//            default:
//                break;
//        }
//    }];
//    //    //停止网络监听（若需要一直检测网络状态，可以不停止，使其一直运行）
////    [reachabilityManager stopMonitoring];
//}

@end
