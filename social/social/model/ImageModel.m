//
//  ImageModel.m
//  social
//
//  Created by QianYuan on 2020/9/14.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "ImageModel.h"
#import <MJExtension.h>
#import "BaseViewController.h"
@implementation ImageModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
        @"Id":@"id"
    };
}

-(NSString *)image_address{
    
    return [NSString stringWithFormat:@"%@%@",ImageServerAdress,self.image];
}
@end
