//
//  ImageModel.h
//  social
//
//  Created by QianYuan on 2020/9/14.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject
@property (nonatomic,copy) NSString * Id;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * image_address;

@property (nonatomic,strong) NSString *isSlelected;
@end

NS_ASSUME_NONNULL_END
