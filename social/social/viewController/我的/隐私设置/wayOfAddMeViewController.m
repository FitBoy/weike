//
//  wayOfAddMeViewController.m
//  social
//
//  Created by QianYuan on 2020/9/14.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "wayOfAddMeViewController.h"
#import "SwitchTableViewCell.h"
@interface wayOfAddMeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_names;
    NSString *job_number;
    NSString *mobile;
}
@property (nonatomic,strong) UITableView *tableV;

@end

@implementation wayOfAddMeViewController
-(void)ClickKai:(UISwitch *)S_kai{
    NSString *value = @"0";
    if (S_kai.isOn) {
        value = @"1";
    }
    NSString *key = @"job_number";
    if (S_kai.tag ==1) {
        key = @"mobile";
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setdataSource];
    [self loadData];
    
}

-(void)loadData{
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,getUserSetting] parameters:@{} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            NSDictionary *dic = responseObject[@"data"];
            self->job_number = dic[@"job_number"];
            self->mobile = dic[@"mobile"];
            [self.tableV reloadData];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}

-(void)setdataSource{
    self.navigationItem.title = @"添加我的方式";
    arr_names=@[
@"工号",
@"手机号"
    ];
    job_number = @"0";
    mobile = @"0";
    [self.tableV reloadData];
 
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.L_name.text = arr_names[indexPath.row];
     cell.S_kai.tag = indexPath.row;
    if (indexPath.row ==0) {
        [cell.S_kai setOn:[job_number integerValue]==0? NO :YES];
    }else{
         [cell.S_kai setOn:[mobile integerValue]==0? NO :YES];
    }
    [cell.S_kai addTarget:self action:@selector(ClickKai:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        [_tableV registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableV;
}

@end
