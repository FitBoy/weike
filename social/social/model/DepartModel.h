//
//  DepartModel.h
//  social
//
//  Created by QianYuan on 2020/9/5.
//  Copyright © 2020 QianYuan. All rights reserved.
// 部门岗位的模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DepartModel : NSObject
@property (nonatomic,copy) NSString * Id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * status;

@property (nonatomic,copy) NSString * department_id;//岗位多出来的字段
@end

NS_ASSUME_NONNULL_END
