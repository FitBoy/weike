//
//  CityModel.h
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City_itemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CityModel : NSObject
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) NSArray *item;

@end

NS_ASSUME_NONNULL_END
