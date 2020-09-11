//
//  Update_passwordViewController.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "Update_passwordViewController.h"
#import "TF_CodeTableViewCell.h"
#import "FooterView.h"
@interface Update_passwordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *phone;
    NSMutableArray *arr_content;
    NSArray *arr_placeholder;
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) FooterView *footer;

@end

@implementation Update_passwordViewController
#pragma mark -- 私有的方法
#pragma mark -- 确定
-(void)ClickQueding{
    TFTableViewCell *cell1 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    TFTableViewCell *cell2 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    TF_CodeTableViewCell *cell3 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell1.TF_text.text.length ==0 || cell2.TF_text.text.length ==0) {
         [EasyTextView showText:@"密码不能为空"];
        return;
    }
    if (![cell1.TF_text.text isEqualToString:cell2.TF_text.text]) {
        [EasyTextView showText:@"两次输入密码不一致"];
        return;
    }
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/auth/changpwd"] parameters:@{
        @"password":cell1.TF_text.text,
        @"code":cell3.TF_text.text
    } success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            [EasyTextView showText:@"修改成功"];
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
    self.navigationItem.title = @"修改密码";
    phone = [userDefault objectForKey:user_phone];
    if (phone==nil) {
        [EasyTextView showErrorText:@"未获取到手机号，请重新登录"];
    }
    
    [self setDataSource];

}
-(void)setDataSource{
    
    arr_placeholder = @[
    @"请输入旧密码",
    @"请输入新密码",
    @"再次输入新密码",
    @"请输入验证码"
    ];
    
    arr_content = [NSMutableArray arrayWithArray:@[
    @"",
    @"",
    @"",
    @""
    ]];
    
    [self.tableV reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_content.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==3) {
        TF_CodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId1"];
        cell.TF_text.placeholder = arr_placeholder[indexPath.row];
        cell.countDownCode.hidden =NO;
        return cell;
    }else{
        TFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        cell.TF_text.placeholder =  arr_placeholder[indexPath.row];
        cell.TF_text.secureTextEntry = YES;
        return cell;
    }
    
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -- 懒加载

-(FooterView *)footer{
    
    if (!_footer) {
        _footer = [[FooterView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 200)];
        _footer.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    }
    return _footer;
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
        [_tableV registerClass:[TFTableViewCell class] forCellReuseIdentifier:@"cellId"];
        [_tableV registerClass:[TF_CodeTableViewCell class] forCellReuseIdentifier:@"cellId1"];
        _tableV.tableFooterView = self.footer;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickQueding)];
        [self.footer.L_search addGestureRecognizer:tap];
        self.footer.L_search.text = @"确定";
        _tableV.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    }
    return _tableV;
}



@end
