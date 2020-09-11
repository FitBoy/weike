//
//  AbouutOur_SZViewController.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "AbouutOur_SZViewController.h"
#import "LLIVTableViewCell.h"
#import "App_HeaderView.h"
@interface AbouutOur_SZViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arr_names;
    NSString *version;
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) App_HeaderView *header;

@end

@implementation AbouutOur_SZViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    [self setDataSource];
}

-(void)setDataSource{
    arr_names = @[
    @"平台介绍",
    @"检查新版本",
    @"清除缓存",
    @"用户协议",
    @"隐私协议",
    @"平台行为规范"
    ];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
   NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    version = app_Version;

    
    [self.tableV reloadData];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLIVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.L_left.text = arr_names[indexPath.row];
    if (indexPath.row ==1) {
        cell.L_right.font = [UIFont systemFontOfSize:15];
        cell.L_right.text = [NSString stringWithFormat:@"当前版本：%@",version];
    }else{
        cell.L_right.text = nil;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self jumpWebVcWithtype:@"1"];
            break;
        case 1:{
            //检查新版本
            [EasyLoadingView showLoading];
            [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/index/version"] parameters:@{
                @"scene":@"1"
            } success:^(id  _Nonnull responseObject) {
                [EasyLoadingView hidenLoading];
                if ([responseObject[@"code"] integerValue] ==1) {
                    NSDictionary *tdic = responseObject[@"data"];
                    NSString *ver = tdic[@"num"];
                    NSString *url = tdic[@"url"];
                    if ([ver isEqualToString:self->version]) {
                        [EasyTextView showText:@"当前是最新版本"];
                    }else{
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:@"是否跳转到appStore更新" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
                                [[UIApplication sharedApplication]  openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
                            }
                        }]];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }
                    
                    
                }else{
                    [EasyTextView showErrorText:responseObject[@"msg"]];
                }
            } error:^(NSError * _Nonnull error) {
                
            }];
            
        }break;
        case 2:{
            //清除缓存
            
        }break;
        case 3:{
            //用户协议
            [self jumpWebVcWithtype:@"2"];
        }break;
        case 4:{
            // 隐私协议
            [self jumpWebVcWithtype:@"3"];
        }break;
        case 5:{
            // 平台行为规范
            [self jumpWebVcWithtype:@"4"];
        }break;
            
        default:
            break;
    }
    
    
    
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
        [_tableV registerClass:[LLIVTableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableV.tableHeaderView = self.header;
    }
    return _tableV;
}

-(App_HeaderView *)header{
    
    if (!_header) {
        _header = [[App_HeaderView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240)];
        _header.IV_name.hidden = NO;
        _header.IV_logo.hidden =NO;
    }
    return _header;
}

@end
