//
//  SheZhiViewController.m
//  social
//
//  Created by QianYuan on 2020/9/8.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "SheZhiViewController.h"
#import "LoginViewController.h"
#import "baseNavigationViewController.h"
#import "QIeHuanViewController.h"
#import "AccountAndSafeViewController.h"

#import "MessageNoticeViewController.h"
#import "Message_SendViewController.h"
#import "chatingSHeZhiViewController.h"
#import "Secret_SZViewController.h"
#import "AbouutOur_SZViewController.h"
#import "Help_SZViewController.h"
@interface SheZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_names;
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIView *V_footer;
@property (nonatomic,strong) UILabel *L_QieHuan;//切换账号
@property (nonatomic,strong) UILabel *L_quit;//退出登录
@end

@implementation SheZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";

    [self setDataSource];
}
-(void)setDataSource{
    
    arr_names = @[
    @"账号与安全",
    @"消息通知",
    @"消息群发",
    @"聊天设置",
    @"隐私",
    @"关于我们",
    @"帮助反馈"
    ];
    [self.tableV reloadData];
}
#pragma mark -- 退出登录
-(void)ClickQuit{
    [self clearLocalData];
    LoginViewController  *loginvc = [[LoginViewController alloc]init];
           baseNavigationViewController *nav = [[baseNavigationViewController alloc]initWithRootViewController:loginvc];
    self.view.window.rootViewController = nav;
}
#pragma mark -- 切换
-(void)ClickQiehuan{
    QIeHuanViewController *Qvc = [[QIeHuanViewController alloc]init];
    [self.navigationController pushViewController:Qvc animated:YES];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = font(17);
    cell.textLabel.text = arr_names[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        //账户与安全
        AccountAndSafeViewController *Avc = [[AccountAndSafeViewController alloc]init];
        [self.navigationController pushViewController:Avc animated:YES];
    }else if (indexPath.row ==1){
        //消息通知
        MessageNoticeViewController *Nvc = [[MessageNoticeViewController alloc]init];
        [self.navigationController pushViewController:Nvc animated:YES];
        
    }else if (indexPath.row ==2){
        
    //消息群发
        Message_SendViewController *Svc = [[Message_SendViewController alloc]init];
        [self.navigationController pushViewController:Svc animated:YES];

    }else if (indexPath.row ==3){
        
        //聊天设置
        
        chatingSHeZhiViewController *Cvc = [[chatingSHeZhiViewController alloc]init];
        [self.navigationController pushViewController:Cvc animated:YES];
        
    }else if (indexPath.row ==4){
        //隐私
        Secret_SZViewController *Svc = [[Secret_SZViewController alloc]init];
        [self.navigationController pushViewController:Svc animated:YES];
    }else if (indexPath.row ==5){
        //关于我们
        AbouutOur_SZViewController *Avc = [[AbouutOur_SZViewController alloc]init];
        [self.navigationController pushViewController:Avc animated:YES];
    }else if (indexPath.row == 6){
        // 帮助反馈
        Help_SZViewController *Hvc = [[Help_SZViewController alloc]init];
        [self.navigationController pushViewController:Hvc animated:YES];
    }else{
        
    }
}

-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom) style:UITableViewStylePlain];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.rowHeight =60;
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableV.tableHeaderView = tview;
        
        self.V_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 200)];
        _tableV.tableFooterView =self.V_footer;
        self.L_QieHuan.hidden = NO;
        self.L_quit.hidden=NO;
        
    }
    return _tableV;
}

-(UILabel *)L_QieHuan{
    
    if (!_L_QieHuan) {
        _L_QieHuan = [[UILabel alloc]init];
        [self.V_footer addSubview:_L_QieHuan];
        _L_QieHuan.layer.masksToBounds = YES;
        _L_QieHuan.layer.cornerRadius =25;
        _L_QieHuan.textColor = [UIColor whiteColor];
        _L_QieHuan.textAlignment = NSTextAlignmentCenter;
        _L_QieHuan.text = @"切换账号";
        _L_QieHuan.font = font(19);
        _L_QieHuan.backgroundColor = RGBColor(53, 127, 246);
        [_L_QieHuan mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(MainScreenWidth/2.0, 50));
            make.centerX.mas_equalTo(self.V_footer.mas_centerX);
            make.bottom.mas_equalTo(self.V_footer.mas_centerY).mas_offset(-15);
        }];
      
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickQiehuan)];
        _L_QieHuan.userInteractionEnabled = YES;
        [_L_QieHuan addGestureRecognizer:tap];
        
    }
    return _L_QieHuan;
}

-(UILabel *)L_quit{
    if (!_L_quit) {
       
        _L_quit = [[UILabel alloc]init];
        [self.V_footer addSubview:_L_quit];
        _L_quit.layer.masksToBounds = YES;
        _L_quit.layer.cornerRadius =25;
        _L_quit.textColor = [UIColor whiteColor];
        _L_quit.textAlignment = NSTextAlignmentCenter;
        _L_quit.font = font(19);
        _L_quit.text = @"退出登录";
        _L_quit.backgroundColor = RGBColor(53, 127, 246);
        [_L_quit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(MainScreenWidth/2.0, 50));
            make.centerX.mas_equalTo(self.V_footer.mas_centerX);
            make.top.mas_equalTo(self.V_footer.mas_centerY).mas_offset(15);
        }];
        
        _L_quit.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickQuit)];
        [_L_quit addGestureRecognizer:tap];
        
    }
    return _L_quit;
}



@end
