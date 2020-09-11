//
//  RegisterViewController.m
//  social
//
//  Created by QianYuan on 2020/9/2.
//  Copyright © 2020 QianYuan. All rights reserved.
// 

#import "RegisterViewController.h"
#import "LineTextField.h"
#import <JKCountDownButton.h>
#import "registerThreeView.h"
#import "LoginViewController.h"
#import "FB_WebViewController.h"
@interface RegisterViewController ()
@property (nonatomic,strong) UILabel *L_title;
@property (nonatomic,strong) LineTextField *TF_phone;
@property (nonatomic,strong) LineTextField *TF_yan;
@property (nonatomic,strong) LineTextField *TF_pass;
@property (nonatomic,strong) JKCountDownButton *countDownCode;

@property (nonatomic,strong) UILabel *L_login;//注册
@property (nonatomic,strong) UILabel *L_tologin;//去登陆

@property (nonatomic,strong) registerThreeView *V_register;

@property (nonatomic,strong) UIImageView *IV_xieyi;
@property (nonatomic,strong) YYLabel *yl_xieyi;


@end

@implementation RegisterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self setUI];
}
-(void)setUI{
    self.L_title.text= @"注册";
    self.TF_phone.placeholder = @"请输入手机号";
    self.TF_phone.keyboardType = UIKeyboardTypeNumberPad;
    self.TF_yan.placeholder = @"请输入验证码";

    self.TF_pass.placeholder = @"请输入密码";
    self.TF_pass.secureTextEntry = YES;
    self.L_login.text = @"注册";
    self.L_tologin.text = @"已有账号，前去登录";
    self.countDownCode.hidden = NO;
    [self.V_register setImge];
    
    self.IV_xieyi.hidden= NO;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"用户登录注册代表同意用户协议和隐私条款"] attributes:@{NSFontAttributeName:font(13),NSForegroundColorAttributeName:[UIColor grayColor]}];
    [attr yy_setTextHighlightRange:NSMakeRange(attr.length-9, 9) color:RGBColor(53, 127, 246) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //点击用户协议和隐私条款
        
        [SXTHTTPTool  postData:[NSString stringWithFormat:@"%@%@",ServerAdress,index_page] parameters:@{
            @"type":@"1"
        } success:^(id  _Nonnull responseObject) {
            
            if ([responseObject[@"code"] integerValue] ==1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    FB_WebViewController *Wvc = [[FB_WebViewController alloc]init];
                    Wvc.nav_title = @"用户协议与隐私条款";
                    Wvc.html = responseObject[@"data"][@"content"];
                    [self.navigationController pushViewController:Wvc animated:YES];
                });
            }else{
                [EasyTextView showErrorText:responseObject[@"msg"]];
            }
            
        } error:^(NSError * _Nonnull error) {
            
        }];
        
        
    }];
    self.yl_xieyi.attributedText =attr;
    
}

#pragma mark -- 注册
-(void)ClickLogin{
    if(![self isPhoneNumWithPhone:self.TF_phone.text]){
        [EasyTextView showErrorText:@"请输入正确的手机号"];
        return;
    }
    if (self.TF_yan.text.length ==0) {
        [EasyTextView showErrorText:@"请输入验证码"];
        return;
    }
    if (self.TF_pass.text.length ==0) {
        [EasyTextView showErrorText:@"请输入密码"];
        return;
    }
    if (self.IV_xieyi.tag ==0) {
        [EasyTextView showErrorText:@"请先勾选用户协议与隐私条款"];
        return;
    }
    
    [EasyLoadingView showLoading];
    NSDictionary *dic = @{
        @"mobile":self.TF_phone.text,
        @"code":self.TF_yan.text,
        @"password":self.TF_pass.text
    };
    
    [EasyTextView showText:@"正在加载"];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,register] parameters:dic success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            [EasyTextView showSuccessText:@"注册成功，请登录"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self click_tologin];
            });
        }else{
              [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark -- 去登陆
-(void)click_tologin{
    NSArray *arr_viewcontrollers = self.navigationController.viewControllers;
    LoginViewController *Lvc =nil;
    for (int i=0; i<arr_viewcontrollers.count; i++) {
        UIViewController *vc = arr_viewcontrollers[i];
        if ([vc isKindOfClass:[LoginViewController class]]) {
            Lvc = (LoginViewController*)vc;
            break;
        }
    }
    [self.navigationController popToViewController:Lvc animated:YES];
}

#pragma mark -- 切换协议
-(void)clickXieyi{
    if (self.IV_xieyi.tag ==0) {
       self.IV_xieyi.tag = 1;
        self.IV_xieyi.image = [UIImage imageNamed:@"xieyi"];
    }else{
        self.IV_xieyi.tag = 0;
        self.IV_xieyi.image = [UIImage imageNamed:@"xieyi1"];
    }
    
    
    
}

#pragma mark -- 懒加载

-(UILabel *)L_tologin{
    
    if (!_L_tologin) {
        _L_tologin = [[UILabel alloc]init];
        [self.view addSubview:_L_tologin];
        _L_tologin.font = font(13);
        _L_tologin.textAlignment = NSTextAlignmentCenter;
        [_L_tologin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.L_login.mas_bottom).mas_offset(10);
            make.width.centerX.mas_equalTo(self.L_login);
        }];
        _L_tologin.userInteractionEnabled = YES;
        _L_tologin.textColor = RGBColor(159, 195, 250);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_tologin)];
        [_L_tologin addGestureRecognizer:tap];
    }
    return _L_tologin;;
}

-(YYLabel *)yl_xieyi {
    
    if (!_yl_xieyi) {
        _yl_xieyi = [[YYLabel alloc]init];
        [self.view addSubview:_yl_xieyi];
        _yl_xieyi.font = font(13);
        
        [_yl_xieyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-SafeAreaBottom-20);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(@260);
        }];
        //_yl_xieyi.backgroundColor = [UIColor redColor];
    }
    return _yl_xieyi;;
}


-(UIImageView *)IV_xieyi{
    
    if (!_IV_xieyi) {
        _IV_xieyi = [[UIImageView alloc]init];
        [self.view addSubview:_IV_xieyi];
        [_IV_xieyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.yl_xieyi.mas_centerY);
            make.right.mas_equalTo(self.yl_xieyi.mas_left);
        }];
        _IV_xieyi.userInteractionEnabled = YES;
        _IV_xieyi.tag =0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickXieyi)];
        [_IV_xieyi addGestureRecognizer:tap];
        _IV_xieyi.image = [UIImage imageNamed:@"xieyi1"];
    }
    return _IV_xieyi;
}

-(LineTextField *)TF_pass{
    
    if (!_TF_pass) {
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
             if (![self isPhoneNumWithPhone:self.TF_phone.text]) {
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
            make.centerY.mas_equalTo(self.TF_yan.mas_centerY);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
        }];
    }
    return _countDownCode;
}

-(LineTextField *)TF_yan{
    
    if (!_TF_yan) {
        _TF_yan = [[LineTextField alloc]init];
        [self.view addSubview:_TF_yan];
        _TF_yan.font = font(18);
        [_TF_yan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
        make.right.mas_equalTo(self.countDownCode.mas_left).mas_offset(-5);
        make.top.mas_equalTo(self.TF_phone.mas_bottom).mas_offset(20);
        }];
    }
    return _TF_yan;;
}


-(LineTextField *)TF_phone{
    
    if (!_TF_phone) {
        _TF_phone = [[LineTextField alloc]init];
        [self.view addSubview:_TF_phone];
        _TF_phone.font = font(18);
        [_TF_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
            make.top.mas_equalTo(self.L_title.mas_bottom).mas_offset(40);
        }];
    }
    return _TF_phone;
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
            make.top.mas_equalTo(self.TF_pass.mas_bottom).mas_offset(30);
        }];
        
        _L_login.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickLogin)];
        [_L_login addGestureRecognizer:tap];
    }
    return _L_login;
}


-(registerThreeView *)V_register{
    
    if (!_V_register) {
        _V_register = [[registerThreeView alloc]init];
        [self.view addSubview:_V_register];
     
        [_V_register mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@150);
            make.bottom.mas_equalTo(self.IV_xieyi.mas_top);
            make.width.mas_equalTo(@300);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
    }
    return _V_register;;
}

@end
