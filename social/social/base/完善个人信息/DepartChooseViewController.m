//
//  DepartChooseViewController.m
//  social
//
//  Created by QianYuan on 2020/9/5.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "DepartChooseViewController.h"

@interface DepartChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_models;
    NSMutableArray *arr_models_right;
    DepartModel *model_depart;
    
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UITableView *tableV_right;


@end

@implementation DepartChooseViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"部门/岗位";
    arr_models = [NSArray array];
    arr_models_right = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
    
}
-(void)loadData{
    
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,user_department] parameters:@{} success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            NSArray *tarr = responseObject[@"data"];
            self->arr_models = [DepartModel mj_objectArrayWithKeyValuesArray:tarr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableV reloadData];
                self->model_depart = self->arr_models[0];
                [self loaddepartDataWith:self->model_depart.Id];
            });
            
           
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    
    
}
-(void)loaddepartDataWith:(NSString *)departId{
    
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,getStationByDepartment] parameters:@{
        @"department_id":departId
    } success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            NSArray *tarr = responseObject[@"data"];
            [self->arr_models_right removeAllObjects];
            self->arr_models_right = [DepartModel mj_objectArrayWithKeyValuesArray:tarr];
            dispatch_async(dispatch_get_main_queue(), ^{
              [self.tableV_right reloadData];
                [self.tableV_right scrollsToTop];
            });
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.tableV) {
        return arr_models.count;
    }else{
        return arr_models_right.count;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (tableView ==self.tableV) {
        cell.textLabel.font = font(18);
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        DepartModel *model = arr_models[indexPath.row];
        cell.textLabel.text = model.name;
    }else{
        cell.textLabel.font = font(15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        DepartModel *model = arr_models_right[indexPath.row];
       cell.textLabel.text = model.name;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView ==self.tableV) {
        return 60;
    }
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.tableV) {
        DepartModel *model = arr_models[indexPath.row];
        [self loaddepartDataWith:model.Id];
        model_depart = model;
    }else{
        DepartModel *model = arr_models_right[indexPath.row];
        if ([self.delegate_depart respondsToSelector:@selector(getDepat:gangwei:)]) {
            [self.delegate_depart getDepat:model_depart gangwei:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

#pragma mark -- 懒加载

-(UITableView *)tableV_right{
    
    if (!_tableV_right) {
        _tableV_right = [[UITableView alloc]initWithFrame:CGRectMake(120, 0,MainScreenWidth-120, MainScreenHeight-SafeAreaBottom) style:UITableViewStylePlain];
        [self.view addSubview:_tableV_right];
        _tableV_right.delegate =self;
        _tableV_right.dataSource = self;
        _tableV_right.showsVerticalScrollIndicator = NO;
        _tableV_right.showsHorizontalScrollIndicator = NO;
        [_tableV_right registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _tableV_right;
}
-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120, MainScreenHeight-SafeAreaBottom) style:UITableViewStylePlain];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _tableV;
}


@end
