//
//  IVLLIVTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/8.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "IVLIVTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface IVLLIVTableViewCell : IVLIVTableViewCell
@property (nonatomic,strong) UILabel *L_right;

-(void)setLocalImg:(NSString *)img  left:(NSString*)left  right:(NSString*)right;
@end

NS_ASSUME_NONNULL_END
