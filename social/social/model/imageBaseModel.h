//
//  imageBaseModel.h
//  social
//
//  Created by QianYuan on 2020/9/16.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface imageBaseModel : NSObject
@property (nonatomic,copy) NSString * src;
@property (nonatomic,copy) NSString *width;
@property (nonatomic,copy) NSString *height;

@end

NS_ASSUME_NONNULL_END
