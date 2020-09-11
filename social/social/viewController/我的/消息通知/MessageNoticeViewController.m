//
//  MessageNoticeViewController.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "MessageNoticeViewController.h"
#import "SwitchTableViewCell.h"
#import "SheZhiModel.h"
@interface MessageNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_names;
    NSMutableArray *arr_status;
}
@property (nonatomic,strong) UITableView *tableV;

@end

@implementation MessageNoticeViewController
-(void)ClickSwitch:(UISwitch *)S_kai {
    NSString *tstr = @"1";
    if (S_kai.isOn == NO) {
        tstr = @"0";
    }
    NSString *key = @"notice_shake";
    if (S_kai.tag ==1) {
        key = @"notice_voice";
    }
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,userSetting] parameters:@{
        key:tstr
    } success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            [self->arr_status replaceObjectAtIndex:S_kai.tag withObject:tstr];
            dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableV reloadData];
            });
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息通知";
    [self setdataSource];
}
-(void)setdataSource{
    arr_names = @[
        @"震动",
        @"声音"
    ];
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,getUserSetting] parameters:@{} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            SheZhiModel *tmodel = [SheZhiModel mj_objectWithKeyValues:responseObject[@"data"]];
            self->arr_status = [NSMutableArray arrayWithArray:@[
               tmodel.notice_shake,
               tmodel.notice_voice
               ]];
            dispatch_async(dispatch_get_main_queue(), ^{
               [self.tableV reloadData];
            });

        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    
   
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.L_name.text = arr_names[indexPath.row];
    [cell.S_kai setOn:[arr_status[indexPath.row] integerValue]==0? NO:YES];
    cell.S_kai.tag =indexPath.row;
    [cell.S_kai addTarget:self action:@selector(ClickSwitch:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
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
        [_tableV registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableV;
}

@end
