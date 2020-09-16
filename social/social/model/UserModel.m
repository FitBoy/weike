//
//  UserModel.m
//  social
//
//  Created by QianYuan on 2020/9/5.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "UserModel.h"
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

-(NSAttributedString *)formatterSex_age{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@""];
    
    if ([self.gender integerValue]==0) {
        self.color_sex = [UIColor blackColor];
    }else if ([self.gender integerValue]==1){
        self.color_sex = [UIColor colorWithRed:41/255.0 green:122/255.0 blue:246/255.0 alpha:1];
        NSMutableAttributedString  *sex = [NSMutableAttributedString yy_attachmentStringWithContent:[UIImage imageNamed:@"sex_man"] contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(15, 15) alignToFont:[UIFont systemFontOfSize:12] alignment:YYTextVerticalAlignmentCenter];
        [attr appendAttributedString:sex];
    }else if ([self.gender integerValue]==2){
        self.color_sex = [UIColor colorWithRed:238/255.0 green:139/255.0 blue:197/255.0 alpha:1];
        NSMutableAttributedString  *sex = [NSMutableAttributedString yy_attachmentStringWithContent:[UIImage imageNamed:@"sex_girl"] contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(15, 15) alignToFont:[UIFont systemFontOfSize:12] alignment:YYTextVerticalAlignmentCenter];
              [attr appendAttributedString:sex];
    }
    
    NSMutableAttributedString *age = [[NSMutableAttributedString alloc]initWithString:self.age attributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:12],
        NSForegroundColorAttributeName:[UIColor whiteColor]
        
    }];
          [attr appendAttributedString:age];
    attr.yy_alignment = NSTextAlignmentCenter;
    return attr;
}



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
