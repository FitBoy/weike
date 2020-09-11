//
//  ForgetPasswordViewController.m
//  social
//
//  Created by QianYuan on 2020/9/2.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LineTextField.h"
#import <JKCountDownButton.h>
@interface ForgetPasswordViewController ()
@property (nonatomic,strong) LineTextField *TF_phone;//手机号
@property (nonatomic,strong) LineTextField *TF_yan; //验证码
@property (nonatomic,strong) LineTextField *TF_pass; //新密码
@property (nonatomic,strong) LineTextField *TF_passnew; //确认密码

@property (nonatomic,strong) JKCountDownButton *countDownCode; //获取验证码

@property (nonatomic,strong) UILabel *L_login;// 确定

@end

@implementation ForgetPasswordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    [self setUI];
    
}
-(void)setUI{
    self.TF_phone.placeholder = @"请输入手机号";
    self.TF_yan.placeholder = @"请输入验证码";
    self.TF_pass.placeholder = @"请输入新密码";
    self.TF_passnew.placeholder = @"请确认新密码";
    self.TF_pass.secureTextEntry = YES;
    self.TF_passnew.secureTextEntry =YES;
    self.L_login.text = @"确定";
    self.countDownCode.hidden = NO;
    
}
#pragma mark -- 确定
-(void)ClickLogin{
    if (![self.TF_pass.text isEqualToString:self.TF_passnew.text]) {
        [EasyTextView showErrorText:@"两次密码输入不一致"];
        return;
    }
    if(![self isPhoneNumWithPhone:self.TF_phone.text]){
        [EasyTextView showErrorText:@"请输入正确的手机号"];
        return;
    }
    if (self.TF_yan.text.length ==0) {
        [EasyTextView showErrorText:@"请输入验证码"];
    }
    
    
    self.L_login.enabled =NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.L_login.enabled =YES;
    });
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,auth_forget] parameters:@{
        @"mobile":self.TF_phone.text,
        @"password":self.TF_pass.text,
        @"code":self.TF_yan.text
    } success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark -- 懒加载
-(JKCountDownButton *)countDownCode{
    
    if (!_countDownCode) {
        _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
       // _countDownCode.frame = CGRectMake(81, 200, 108, 32);
        [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _countDownCode.backgroundColor =RGBColor(244, 187, 141);
        _countDownCode.layer.masksToBounds =YES;
        _countDownCode.layer.cornerRadius =15;
        [self.view addSubview:_countDownCode];

         [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            sender.enabled = NO;

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
            make.centerY.mas_equalTo(self.TF_yan.mas_centerY);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
        }];
    }
    return _countDownCode;
}

-(UILabel *) L_login{
    
    if (!_L_login) {
       
        _L_login = [[UILabel alloc]init];
        [self.view addSubview:_L_login];
        _L_login.font = font(23);
        _L_login.backgroundColor = RGBColor(53, 127, 246);
        _L_login.textAlignment = NSTextAlignmentCenter;
        
        _L_login.layer.masksToBounds = YES;
        _L_login.layer.cornerRadius = 25;
        _L_login.textColor = [UIColor whiteColor];
        [_L_login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(MainScreenWidth/2.0+50, 50));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.TF_passnew.mas_bottom).mas_offset(30);
        }];
        
        _L_login.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickLogin)];
        [_L_login addGestureRecognizer:tap];
    }
    return _L_login;
}


-(LineTextField *)TF_passnew{
    
    if (!_TF_passnew) {
        _TF_passnew = [[LineTextField alloc]init];
        [self.view addSubview:_TF_passnew];
        _TF_passnew.font = font(18);
        [_TF_passnew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
            make.top.mas_equalTo(self.TF_pass.mas_bottom).mas_offset(20);
        }];
        
    }
    return _TF_passnew;
    
}

-(LineTextField *)TF_pass {
    
    if(!_TF_pass ){
        _TF_pass = [[LineTextField alloc]init];
        [self.view addSubview:_TF_pass];
        _TF_pass.font = font(18);
        [_TF_pass mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(50);
         make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
         make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
         make.top.mas_equalTo(self.TF_yan.mas_bottom).mas_offset(20);
        }];
    }
    return _TF_pass;
}

-(LineTextField *) TF_phone{
    
    if (!_TF_phone) {
        _TF_phone = [[LineTextField alloc]init];
        [self.view addSubview:_TF_phone];
        _TF_phone.font = [UIFont systemFontOfSize:18];
        [_TF_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
            make.top.mas_equalTo(self.view.mas_top).mas_offset(StatusbarAndNavigationbarHeight+10);
        }];
        
    }
    return _TF_phone;;
}

-(LineTextField *)TF_yan{
    
    if (!_TF_yan) {
        
        _TF_yan = [[LineTextField alloc]init];
        [self.view addSubview:_TF_yan];
        _TF_yan.font = [UIFont systemFontOfSize:18];
        [_TF_yan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
            make.right.mas_equalTo(self.countDownCode.mas_left).mas_offset(-5);
            make.top.mas_equalTo(self.TF_phone.mas_bottom).mas_offset(20);
        }];
    }
    return _TF_yan;;
}



@end
