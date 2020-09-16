//
//  GuanzhuViewController.m
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "GuanzhuViewController.h"

@interface GuanzhuViewController ()

@end

@implementation GuanzhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_models = [NSMutableArray arrayWithCapacity:0];
    page =@"1";
    scene = @"1";
    [self.tableV.mj_header beginRefreshing];
}

-(void)loadheaderData{
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/topic/index"] parameters:@{
        @"page":@"1",
        @"scene":scene
    } success:^(id  _Nonnull responseObject) {
        [self.tableV.mj_footer endRefreshing];
        [self.tableV.mj_header endRefreshing];
        if ([responseObject[@"code"] integerValue] ==1) {
            [self->arr_models removeAllObjects];
            NSDictionary *dic = responseObject[@"data"];
            NSArray *tarr = dic[@"list"];
            NSInteger total = [dic[@"total"] integerValue];
            self->page = [NSString stringWithFormat:@"%ld",[dic[@"page"] integerValue]+1];
            self->arr_models = [TopicModel mj_objectArrayWithKeyValuesArray:tarr];
            if(total ==self->arr_models.count){
                [self.tableV.mj_footer endRefreshingWithNoMoreData];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                  [self.tableV reloadData];
            });

        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}
-(void)loadFooterData{
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/topic/index"] parameters:@{
          @"page":page,
          @"scene":scene
      } success:^(id  _Nonnull responseObject) {
          [self.tableV.mj_footer endRefreshing];
          [self.tableV.mj_header endRefreshing];
          if ([responseObject[@"code"] integerValue] ==1) {
             
              NSDictionary *dic = responseObject[@"data"];
              NSArray *tarr = dic[@"list"];
              NSInteger total = [dic[@"total"] integerValue];
              self->page = [NSString stringWithFormat:@"%ld",[dic[@"page"] integerValue]+1];
               [self->arr_models  addObjectsFromArray:[TopicModel mj_objectArrayWithKeyValuesArray:tarr]];
              if(total ==self->arr_models.count){
                  [self.tableV.mj_footer endRefreshingWithNoMoreData];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableV reloadData];
              });

          }else{
              [EasyTextView showErrorText:responseObject[@"msg"]];
          }
      } error:^(NSError * _Nonnull error) {
          
      }];
}


-(UIView *)listView{
    return self.view;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_models.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicModel *model = arr_models[indexPath.row];
    return model.model_height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Image_textTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   TopicModel *model = arr_models[indexPath.row];
    [cell setModel:model];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom-StatusbarAndNavigationbarHeight-TabBarHeight) style:UITableViewStylePlain];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.rowHeight =110;
        [_tableV registerClass:[Image_textTableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadheaderData)];
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
        footer.hidden=YES;
        _tableV.mj_footer =footer;
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableV;
}


@end
