//
//  Secret_SZViewController.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "Secret_SZViewController.h"
#import "L_IV_rightTableViewCell.h"
#import "SwitchTableViewCell.h"
#import "wayOfAddMeViewController.h"

@interface Secret_SZViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arr_names;
    NSString *stranger;
    NSString *verify;

}

@property (nonatomic,strong) UITableView *tableV;


@end

@implementation Secret_SZViewController
-(void)ClickKai:(UISwitch *)S_kai{
    NSString *value = @"0";
    if (S_kai.isOn!=NO) {
        value = @"1";
    }
    NSString *key = @"stranger";
    if(S_kai.tag !=0){
        key = @"verify";
    }
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,userSetting] parameters:@{
        key:value
    } success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            [self loadData];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self setdataSource];
    [self loadData];
    
   
}
#pragma mark -- 获取设置方式
-(void)loadData{
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/user/getUserSetting"] parameters:@{} success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            NSDictionary *dic = responseObject[@"data"];
            self->stranger = dic[@"stranger"];
            self->verify = dic[@"verify"];
            [self.tableV reloadData];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}
-(void)setdataSource{
    self.navigationItem.title = @"隐私";
    stranger = @"0";
    verify = @"0";
    arr_names =@[
    @"骚扰招呼拦截",
    @"黑名单",
    @"加我为朋友时需要验证",
    @"添加我的方式",
    @"不让他（她）看",
    @"不看他（她）"
    ];
    [self.tableV reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==0 || indexPath.row ==2){
        SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId1"];
        cell.L_name.text = arr_names[indexPath.row];
        if(indexPath.row ==0){
           [cell.S_kai setOn:[stranger integerValue] ==0?NO:YES];
        }else{
            [cell.S_kai setOn:[verify integerValue] == 0?NO:YES];
        }
        cell.S_kai.tag = indexPath.row;
        [cell.S_kai addTarget:self action:@selector(ClickKai:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }else{
    
    L_IV_rightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.L_name.text = arr_names[indexPath.row];
        cell.IV_more.hidden = NO;
    return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==3){
        ///添加我的方式
        wayOfAddMeViewController *Wvc = [[wayOfAddMeViewController alloc]init];
        [self.navigationController pushViewController:Wvc animated:YES];
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
        [_tableV registerClass:[L_IV_rightTableViewCell class] forCellReuseIdentifier:@"cellId"];
        [_tableV registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:@"cellId1"];
    }
    return _tableV;
}

@end
