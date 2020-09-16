//
//  TopicModel.m
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "TopicModel.h"
#import <MJExtension.h>
#import "BaseViewController.h"
@implementation TopicModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"Id":@"id"
    };
}

-(NSString*)video_url{
    return [NSString stringWithFormat:@"%@%@",VideoServerAdress,self.video];
}
-(NSString*)snapshot{
    return [NSString stringWithFormat:@"%@%@",ImageServerAdress,_snapshot];
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{
        @"images_arr":@"imageBaseModel"
    };
}

-(NSAttributedString *)formatterTime_address{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self.created_at attributes:@{
    NSFontAttributeName:[UIFont systemFontOfSize:15],
    NSForegroundColorAttributeName:[UIColor grayColor]
    }];
    if (self.address.length !=0) {
        NSMutableAttributedString *place = [NSMutableAttributedString yy_attachmentStringWithContent:[UIImage imageNamed:@"place"] contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(19, 24) alignToFont:[UIFont systemFontOfSize:15] alignment:YYTextVerticalAlignmentCenter];
        [attr appendAttributedString:place];
        NSMutableAttributedString *address = [[NSMutableAttributedString alloc]initWithString:self.address attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [attr appendAttributedString:address];
    }
    return attr;
}


-(UIImage *)likeImage{
    UIImage *image = nil;
    if ([self.isLike integerValue]==0) {
        image = [UIImage imageNamed:@"zan_no"];
    }else{
        image = [UIImage imageNamed:@"zan_yes"];
    }
    return image;
}
@end
