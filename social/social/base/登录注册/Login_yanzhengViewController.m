//
//  Login_yanzhengViewController.m
//  social
//
//  Created by QianYuan on 2020/9/1.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "Login_yanzhengViewController.h"
#import <JKCountDownButton.h>
#import "LineTextField.h"
#import "registerThreeView.h"

#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"
#import "PersonDetailViewController.h"
@interface Login_yanzhengViewController ()
@property (nonatomic,strong) UILabel *L_title;

@property (nonatomic,strong) LineTextField *TF_phone;
@property (nonatomic,strong) LineTextField *TF_pass;
@property (nonatomic,strong) UILabel *L_yanzheng;
@property (nonatomic,strong) YYLabel *yl_forget;

@property (nonatomic,strong) UILabel *L_login;
@property (nonatomic,strong) registerThreeView *V_register;

@property (nonatomic,strong) JKCountDownButton *countDownCode;


@end

@implementation Login_yanzhengViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
       [self setUI];
}
-(void)setUI{
    self.navigationItem.title = @"短信登录";
    self.L_title.text = @"短信登录";
    self.TF_phone.placeholder = @"请输入手机号/工号";
    self.TF_pass.placeholder =@"请输入验证码";
    self.L_yanzheng.text = @"账号登录";
    self.L_login.text = @"登录";
    self.countDownCode.hidden = NO;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"忘记密码 | 立即注册"] attributes:@{NSFontAttributeName:font(15)}];
    [attr yy_setTextHighlightRange:NSMakeRange(0, 4) color:RGBColor(149, 188, 249) backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        ForgetPasswordViewController *Fvc = [[ForgetPasswordViewController alloc]init];
              dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:Fvc animated:YES];
              });
    }];
    [attr yy_setTextHighlightRange:NSMakeRange(attr.length-4, 4) color:RGBColor(149, 188, 249) backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        RegisterViewController *Rvc = [[RegisterViewController alloc]init];
               dispatch_async(dispatch_get_main_queue(), ^{
                   [self.navigationController pushViewController:Rvc animated:YES];
               });
    }];
    attr.yy_alignment = NSTextAlignmentCenter;
    self.yl_forget.attributedText = attr;
    [self.V_register setImge];
}


#pragma mark -- 点击账号登录
-(void)ClickYanzheng{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -- 登录
-(void)ClickLogin{
    
    self.L_login.enabled =NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.L_login.enabled =YES;
    });
    if (self.TF_phone.text.length ==0) {
        [EasyTextView showErrorText:@"请输入手机号/工号"];
        return;
    }
    if(self.TF_pass.text.length ==0)
    {
        [EasyTextView showText:@"请输入验证码"];
        return;
    }
    
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,auth_fastlogin] parameters:@{
        @"mobile":self.TF_phone.text,
        @"code":self.TF_pass.text
    } success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            NSDictionary *tdic = responseObject[@"data"];
                      [userDefault setObject:tdic[@"token"] forKey:user_token];
                      [userDefault setObject:tdic[@"id"] forKey:user_userId];
                      [userDefault setObject:self.TF_phone.text forKey:user_phone];
                      [userDefault synchronize];
                      dispatch_async(dispatch_get_main_queue(), ^{
                          PersonDetailViewController *Dvc = [[PersonDetailViewController alloc]init];
                          [self.navigationController pushViewController:Dvc animated:YES];
                      });
                      
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    
    
    
}

#pragma mark -- 懒加载

-(registerThreeView *)V_register{
    
    if (!_V_register) {
        _V_register = [[registerThreeView alloc]init];
        [self.view addSubview:_V_register];
     
        [_V_register mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@150);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-SafeAreaBottom);
            make.width.mas_equalTo(@300);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
    }
    return _V_register;;
}

-(YYLabel *)yl_forget{
    
    if (!_yl_forget) {
        _yl_forget = [[YYLabel alloc]init];
        [self.view addSubview:_yl_forget];
        _yl_forget.textAlignment = NSTextAlignmentCenter;
        [_yl_forget mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self.L_login);
            make.top.mas_equalTo(self.L_login.mas_bottom).mas_offset(25);
        }];
    }
    return _yl_forget;
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
            make.top.mas_equalTo(self.view.mas_centerY).mas_offset(20);
        }];
        
        _L_login.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickLogin)];
        [_L_login addGestureRecognizer:tap];
    }
    return _L_login;
}

-(LineTextField *) TF_phone{
    if (!_TF_phone) {
        _TF_phone = [[LineTextField alloc]init];
        [self.view addSubview:_TF_phone];
        _TF_phone.font = font(18);
        [_TF_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.TF_pass.mas_left);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-60);
            make.bottom.mas_equalTo(self.TF_pass.mas_top).mas_offset(-25);
        }];
    }
    return _TF_phone;
}


-(LineTextField *)TF_pass{
    
    if (!_TF_pass) {
        
        _TF_pass = [[LineTextField alloc]init];
        [self.view addSubview:_TF_pass];
        _TF_pass.font = font(18);
        [_TF_pass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(60);
            make.right.mas_equalTo(self.countDownCode.mas_left).mas_offset(-5);
            make.bottom.mas_equalTo(self.L_yanzheng.mas_top).mas_offset(-15);
        }];
    }
    return _TF_pass;
}

-(UILabel *)L_yanzheng{
    
    if (!_L_yanzheng) {
        _L_yanzheng = [[UILabel alloc]init];
        [self.view addSubview:_L_yanzheng];
        _L_yanzheng.textColor = RGBColor(47, 130, 247);
        _L_yanzheng.font = font(15);
        [_L_yanzheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.TF_pass.mas_left);
            make.bottom.mas_equalTo(self.view.mas_centerY);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.TF_pass.mas_right);
        }];
        _L_yanzheng.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickYanzheng)];
        [_L_yanzheng addGestureRecognizer:tap];
        
    }
    return  _L_yanzheng;
}

-(UILabel *) L_title{
    
    if (!_L_title) {
        _L_title = [[UILabel alloc]init];
        [self.view addSubview:_L_title];
        _L_title.font = [UIFont systemFontOfSize:24];
        _L_title.textAlignment = NSTextAlignmentCenter;
        [_L_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(self.view.mas_top).mas_offset(100);
            make.left.right.mas_equalTo(self.view);
        }];
        
    
    }
    return _L_title;
}

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
             if (self.TF_phone.text.length ==0) {
                 [EasyTextView showErrorText:@"请输入正确的手机号"];
                 return;
             }
             sender.enabled = NO;
             
            [sender startCountDownWithSecond:60];
             [SXTHTTPTool  postData:[NSString stringWithFormat:@"%@%@",ServerAdress,sms] parameters:@{
                             @"mobile":self.TF_phone.text
                         } success:^(id  _Nonnull responseObject) {
                             if ([responseObject[@"code"] integerValue]==1) {
                                 [EasyTextView showSuccessText:responseObject[@"msg"]];
                             }
                         } error:^(NSError * _Nonnull error) {
                             [EasyTextView showErrorText:@"网络错误，请重试！"];
                         }];

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
            make.centerY.mas_equalTo(self.TF_pass.mas_centerY);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-60);
        }];
    }
    return _countDownCode;
}


@end
