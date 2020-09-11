//
//  AccountAndSafeViewController.m
//  social
//
//  Created by QianYuan on 2020/9/8.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "AccountAndSafeViewController.h"
#import "IVLLIVTableViewCell.h"
#import "Update_passwordViewController.h"
#import "Update_phoneViewController.h"
@interface AccountAndSafeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr;
    NSArray *arr_imgs;
    
}
@property (nonatomic,strong) UITableView *tableV;

@end

@implementation AccountAndSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户与安全";
    [self setDataSource];
}
-(void)setDataSource{
    
    arr = @[
    @[
    @"修改登录密码",
    @"修改手机号"
    ],
    @[
    @"QQ",
    @"微信",
    @"新浪微博"
    ]
    ];
    
    arr_imgs = @[
    @[
    @"mima",
    @"phone_update"
    ],
    @[
    @"qq_1",
    @"wechat_1",
    @"weibo_1"
    ]
    ];
    
    [self.tableV reloadData];
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }else{
        return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else{
        return @"第三方账号";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr.count;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tarr = arr[section];
    return tarr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IVLLIVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *tarr_img = arr_imgs[indexPath.section];
    NSArray *tarr = arr[indexPath.section];
    NSString *right = @"未绑定";
    if (indexPath.section ==0 && indexPath.row==0) {
        right = @"修改密码";
    }else if (indexPath.section ==0 && indexPath.row==1){
        right = @"修改手机号";
    }else{
        
    }
    [cell setLocalImg:tarr_img[indexPath.row] left:tarr[indexPath.row] right:right];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.section ==0){
        switch (indexPath.row) {
            case 0:
            {
                //修改登录密码
                Update_passwordViewController *Pvc = [[Update_passwordViewController alloc]init];
                [self.navigationController pushViewController:Pvc animated:YES];
  
            }
                break;
            case 1:{
                // 修改手机号
                Update_phoneViewController *phone = [[Update_phoneViewController alloc]init];
                [self.navigationController pushViewController:phone animated:YES];
                
            }break;
                
            default:
                break;
        }
    }
    
}

#pragma mark -- 懒加载
-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.rowHeight =60;
        [_tableV registerClass:[IVLLIVTableViewCell class] forCellReuseIdentifier:@"cellId"];
        
        UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableV.tableHeaderView =tview;
    }
    return _tableV;
}


@end
