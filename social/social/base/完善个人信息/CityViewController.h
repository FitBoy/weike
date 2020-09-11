//
//  CityViewController.h
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
// 城市的选择  

#import "BaseViewController.h"
#import "CityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityViewController : BaseViewController
@property (nonatomic,weak) id delegate_city;

@end

@protocol CityViewControllerDelegate <NSObject>
-(void)getCity:(City_itemModel *)city;


@end

NS_ASSUME_NONNULL_END
