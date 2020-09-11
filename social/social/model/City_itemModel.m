//
//  City_itemModel.m
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "City_itemModel.h"
#import <MJExtension.h>
@implementation City_itemModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
  return   @{
        @"Id":@"id"
    };
}
@end
