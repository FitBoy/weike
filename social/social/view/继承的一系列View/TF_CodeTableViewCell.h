//
//  TF_CodeTableViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
// 带有验证码的cell

#import "TFTableViewCell.h"
#import <JKCountDownButton.h>
NS_ASSUME_NONNULL_BEGIN

@interface TF_CodeTableViewCell : TFTableViewCell
@property (nonatomic,strong) JKCountDownButton *countDownCode;
@property (nonatomic,weak) id delegate_code;
@end
@protocol TF_CodeTableViewCellDelegate <NSObject>

-(void)WillSendcode;

@end

NS_ASSUME_NONNULL_END
