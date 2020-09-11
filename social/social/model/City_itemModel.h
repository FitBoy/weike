//
//  City_itemModel.h
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface City_itemModel : NSObject
@property (nonatomic,copy) NSString * Id;
@property (nonatomic,copy) NSString * parent_id;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * created_at;
@property (nonatomic,copy) NSString * updated_at;
@property (nonatomic,copy) NSString * letter;
@property (nonatomic,copy) NSString * depth;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,copy) NSString * key;

@end

NS_ASSUME_NONNULL_END
