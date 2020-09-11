//
//  CityViewController.m
//  social
//
//  Created by QianYuan on 2020/9/7.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "CityViewController.h"
@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr_models;
}
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation CityViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"城市";
    arr_models = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
}
-(void)loadData{
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,getLetterCity] parameters:@{} success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            NSArray *tarr = responseObject[@"data"];
            self->arr_models = [CityModel mj_objectArrayWithKeyValuesArray:tarr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableV reloadData];
            });
           
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
        
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr_models.count;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     CityModel *tmodel = arr_models[section];
    return tmodel.item.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = font(17);
    CityModel *tmodel = arr_models[indexPath.section];
    City_itemModel *itemModel = tmodel.item[indexPath.row];
    cell.textLabel.text = itemModel.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate_city respondsToSelector:@selector(getCity:)]){
        CityModel *model = arr_models[indexPath.section];
        City_itemModel *tmodel = model.item[indexPath.row];
        [self.delegate_city getCity:tmodel];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *tarr =  [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_models.count; i++) {
        CityModel *model = arr_models[i];
        [tarr addObject:model.title];
    }
    return tarr;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return index;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CityModel *model = arr_models[section];
    return model.title;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    return tview;
}


#pragma mark -- 懒加载
-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom-NavigationbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.rowHeight =50;
        UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableV.tableHeaderView = head;
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableV;
}


@end
