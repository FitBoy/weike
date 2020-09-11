//
//  Update_phoneViewController.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "Update_phoneViewController.h"
#import "TF_CodeTableViewCell.h"
#import "FooterView.h"
@interface Update_phoneViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arr_placeholder;
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) FooterView *footer;
@end

@implementation Update_phoneViewController

-(void)ClickQueding{
    TFTableViewCell *cell0 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    TFTableViewCell *cell1 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    TF_CodeTableViewCell *cell2 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (cell1.TF_text.text.length ==0 || cell2.TF_text.text.length ==0 || cell0.TF_text.text.length ==0) {
        [EasyTextView showErrorText:@"信息不能为空"];
        return;
    }
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,user_changeMobile] parameters:@{
        @"old_mobile":cell0.TF_text.text,
        @"mobile":cell1.TF_text.text,
        @"code":cell2.TF_text.text
    } success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            [EasyTextView showSuccessText:@"修改成功"];
            [userDefault setObject:cell1.TF_text.text forKey:user_phone];
            [userDefault synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            
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
    self.navigationItem.title = @"修改手机号";
    [self setDataSorce];
}
-(void)setDataSorce{
    arr_placeholder = @[
    @"请输入旧手机号",
    @"请输入新手机号",
    @"请输入验证码"
    ];
    [self.tableV reloadData];

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_placeholder.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==2) {
        TF_CodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId1"];
        cell.TF_text.placeholder = arr_placeholder[indexPath.row];
        cell.countDownCode.hidden = NO;
        return cell;
    }else{
        TFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        cell.TF_text.placeholder = arr_placeholder[indexPath.row];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -- 懒加载
-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom) style:UITableViewStylePlain];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.rowHeight =60;
        [_tableV registerClass:[TFTableViewCell class] forCellReuseIdentifier:@"cellId"];
        [_tableV registerClass:[TF_CodeTableViewCell class] forCellReuseIdentifier:@"cellId1"];
        _tableV.tableFooterView = self.footer;
        _tableV.backgroundColor = self.footer.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    }
    return _tableV;
}
-(FooterView *)footer{
    
    if (!_footer) {
        _footer = [[FooterView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 200)];
        _footer.L_search.text = @"确定";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickQueding)];
        [_footer.L_search addGestureRecognizer:tap];
        
    }
    return _footer;
}

@end
