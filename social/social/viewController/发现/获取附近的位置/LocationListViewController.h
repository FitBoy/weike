//
//  LocationListViewController.h
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
// 附近的位置

#import "BaseViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationListViewController : BaseViewController

@property (nonatomic,weak) id delegate_location;

@end

@protocol LocationListViewControllerDelegate <NSObject>

///获取搜索结果
-(void)getLocationPoi:(AMapPOI *)poi;

@end

NS_ASSUME_NONNULL_END
