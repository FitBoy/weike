//
//  UserModel.m
//  social
//
//  Created by QianYuan on 2020/9/5.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "UserModel.h"
#import "BaseViewController.h"
#import <MJExtension.h>
@implementation UserModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"Id":@"id"
    };
}
-(NSString*)head_image{
    return [NSString stringWithFormat:@"%@%@",ImageServerAdress,self.avatar];
}

-(NSString *)sex{
    if ([self.gender integerValue]==0) {
        return @"保密";
    }else if ([self.gender integerValue]==1){
        return @"男";
    }else if ([self.gender integerValue]==2){
        return @"女";
    }else{
        return @" ";
    }
};

-(NSString *)birthday{
    
    if (_birthday==nil) {
        _birthday = @" ";
    }
    return _birthday;
}

-(NSString *)department_text{
    if (!_department_text) {
        return @"";
    }else{
        return _department_text;
    }
}
-(NSString *)station_text {
    
    if (!_station_text) {
        return @"";
    }else{
        return _station_text;
    }
}
-(NSString *)city_text{
    
    if (!_city_text) {
        return @"";
    }else{
        return _city_text;
    }
}
@end
