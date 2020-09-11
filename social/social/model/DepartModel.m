//
//  DepartModel.m
//  social
//
//  Created by QianYuan on 2020/9/5.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "DepartModel.h"
#import <MJExtension.h>
@implementation DepartModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
        @"Id":@"id"
    };
}
@end
