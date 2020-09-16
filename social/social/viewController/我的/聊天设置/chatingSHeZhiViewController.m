//
//  chatingSHeZhiViewController.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "chatingSHeZhiViewController.h"
#import "L_IV_rightTableViewCell.h"
#import "ChatBgViewController.h"
@interface chatingSHeZhiViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arr_names;
}
@property (nonatomic,strong)  UITableView *tableV;


@end

@implementation chatingSHeZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"聊天设置";
   arr_names =@[
       @"设置聊天背景",
       @"清空聊天记录"
   ];
    [self.tableV reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    L_IV_rightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.L_name.text =arr_names[indexPath.row];
    cell.IV_more.hidden =NO;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        //设置聊天背景
        ChatBgViewController *Bvc = [[ChatBgViewController alloc]init];
        [self.navigationController pushViewController:Bvc animated:NO];
    }else if(indexPath.row ==1 ){
        //清空聊天记录
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"将清除所有个人和群的聊天记录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
           [self presentViewController:alert animated:YES completion:nil];
        });
       
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
    }
    return _tableV;
}



@end
