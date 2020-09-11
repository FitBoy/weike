//
//  FB_WebViewController.h
//  XiuZhuoYing
//
//  Created by qianyuan on 2020/8/17.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FB_WebViewController :BaseViewController
@property (nonatomic,copy) NSString * nav_title;//导航的标题
@property (nonatomic,copy) NSString * webUrl;
@property (nonatomic,strong) NSString *html;
@end

NS_ASSUME_NONNULL_END
