//
//  MyViewController.m
//  social
//
//  Created by QianYuan on 2020/8/31.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "MyViewController.h"
#import "IVLIVTableViewCell.h"
#import "MyHeadView.h"
#import "ShakeViewController.h"
#import "SheZhiViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_names;
    NSArray *arr_images;
    UserModel *user;
    
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) MyHeadView *headV;


@end

@implementation MyViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title= @"我的";
    [self setData];
    [self setDatasorce];
}
-(void)setData{
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,auth_me] parameters:@{} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            NSDictionary *tdic = responseObject[@"data"];
            self->user  = [UserModel mj_objectWithKeyValues:tdic];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.headV setModel:self->user];
                self.tableV.tableHeaderView = self.headV;
            });
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}

-(void)setDatasorce{
    arr_names = @[
    @[
        @"扫一扫",
        @"摇一摇"
    ],
    @[
    @"我的动态",
    @"谁看过我",
    @"我看过谁",
    @"收藏"
    ],
    @[
    @"设置"
    ]
    ];
    
    arr_images = @[
    @[
    @"saoyisao",
    @"yaoyiyao"
    ],
    @[
    @"my_dongtai",
    @"my_whoseeme",
    @"my_IseeWho",
    @"my_shoucang",
    ],
    @[
    @"my_shezhi"
    ]
    ];
    
    [self.tableV reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr_names.count;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tarr = arr_names[section];
    return tarr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IVLIVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *tarr = arr_names[indexPath.section];
    NSArray *tarr_image =arr_images[indexPath.section];
    cell.IV_img.image = [UIImage imageNamed:tarr_image[indexPath.row]];
    cell.L_text.text = tarr[indexPath.row];
    if (indexPath.section ==0) {
        cell.IV_more.hidden =YES;
    }else{
       cell.IV_more.hidden =NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            //扫一扫
            [self saoyisao];
        }else if (indexPath.row ==1){
            //摇一摇
            ShakeViewController *Svc = [[ShakeViewController alloc]init];
            [self.navigationController pushViewController:Svc animated:YES];
            
        }else{
            
        }
    }else if (indexPath.section ==1 ){
        
        
    }else if(indexPath.section ==2){
       //设置
        SheZhiViewController *Svc = [[SheZhiViewController alloc]init];
        
        [self.navigationController pushViewController:Svc animated:YES];
        
    }else{
        
        
    }
}

#pragma mark -- 懒加载
-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.rowHeight =60;
        [_tableV registerClass:[IVLIVTableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableV;
}

-(MyHeadView *)headV{
    
    if (!_headV) {
        _headV = [[MyHeadView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 150)];
        _headV.backgroundColor = [UIColor whiteColor];
        
    }
    return _headV;
}



@end
