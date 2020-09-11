//
//  TF_CodeTableViewCell.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "TF_CodeTableViewCell.h"
#import "SXTHTTPTool.h"
#import "BaseViewController.h"
@implementation TF_CodeTableViewCell

-(JKCountDownButton *)countDownCode{
    
    if (!_countDownCode) {
        _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
       // _countDownCode.frame = CGRectMake(81, 200, 108, 32);
        [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _countDownCode.backgroundColor =[UIColor colorWithRed:244/255.0 green:187/255.0 blue:141/255.0 alpha:1];
        _countDownCode.layer.masksToBounds =YES;
        _countDownCode.layer.cornerRadius =15;
        [self.V_bg addSubview:_countDownCode];

         [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            sender.enabled = NO;
             if ([self.delegate_code respondsToSelector:@selector(WillSendcode)]) {
                 [self.delegate_code WillSendcode];
             }else{
                 

                      [SXTHTTPTool  postData:[NSString stringWithFormat:@"%@%@",ServerAdress,sms] parameters:@{
                             @"mobile":[userDefault objectForKey:user_phone]
                         } success:^(id  _Nonnull responseObject) {
                             if ([responseObject[@"code"] integerValue]==1) {
                                 [EasyTextView showSuccessText:responseObject[@"msg"]];
                             }
                         } error:^(NSError * _Nonnull error) {
                             [EasyTextView showErrorText:@"网络错误，请重新登录！"];
                         }];
             
                }
            [sender startCountDownWithSecond:60];

            [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                return @"获取验证码";
                
            }];

        }];
        
        [_countDownCode  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 30));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-10);
        }];
        
        [self.TF_text mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg).mas_offset(15);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.V_bg);
            make.right.mas_equalTo(self.countDownCode.mas_left).mas_offset(-5);
        }];
        
        
    }
    return _countDownCode;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
