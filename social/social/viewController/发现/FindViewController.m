//
//  FindViewController.m
//  social
//
//  Created by QianYuan on 2020/8/31.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "FindViewController.h"
#import <JXCategoryTitleView.h>
#import "add_topicViewController.h"
#import <JXCategoryListContainerView.h>

#import "GuanzhuViewController.h"
#import "TongCityViewController.h"
#import "TuiJianViewController.h"
#import "HotViewController.h"

@interface FindViewController ()<JXCategoryListContainerViewDelegate>

@property (nonatomic,strong) UIImageView *IV_fabu;
@property (nonatomic,strong) JXCategoryTitleView *title_list;
@property (nonatomic,strong) JXCategoryListContainerView  *listContainerView;
@property (nonatomic,strong) NSArray *arr_viewcontrollers;
@property (nonatomic,strong) UIView *V_line;


@end

@implementation FindViewController

#pragma mark -- 发布
-(void)ClickFabu{
    add_topicViewController *Avc = [[add_topicViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //处于第一个item的时候，才允许屏幕边缘手势返回
      // self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =YES;
    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
      self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.IV_fabu.hidden = NO;
    self.navigationItem.title = @"发现";
    self.title_list.listContainer = self.listContainerView;
    self.V_line.alpha =0.6;

}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.title_list.titles.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    return self.arr_viewcontrollers[index];
}
#pragma mark -- 懒加载
-(NSArray *)arr_viewcontrollers{
    if (!_arr_viewcontrollers) {
        GuanzhuViewController *Gvc = [[GuanzhuViewController alloc]init];
        TongCityViewController *Tvc = [[TongCityViewController alloc]init];
        TuiJianViewController *Jvc = [[TuiJianViewController alloc]init];
        HotViewController *Hvc = [[HotViewController alloc]init];
        _arr_viewcontrollers = @[
            Gvc,
            Tvc,
            Jvc,
            Hvc
        ];
    }
    return _arr_viewcontrollers;
}
-(UIImageView *)IV_fabu{
    
    if (!_IV_fabu) {
        _IV_fabu = [[UIImageView alloc]init];
        [self.view addSubview:_IV_fabu];
        [_IV_fabu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
            make.top.mas_equalTo(self.view).mas_offset(StatusbarHeight+10);
        }];
        _IV_fabu.userInteractionEnabled = YES;
        _IV_fabu.image = [UIImage imageNamed:@"fabu"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickFabu)];
        [_IV_fabu addGestureRecognizer:tap];
    }
    return _IV_fabu;
}

-(JXCategoryTitleView *)title_list{
    
    if (!_title_list) {
        _title_list = [[JXCategoryTitleView alloc]init];
        _title_list.titles = @[@"关注",@"同城",@"推荐",@"热门"];
        _title_list.titleLabelZoomEnabled = YES;
        _title_list.titleLabelZoomScale =1.8;
        _title_list.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
        _title_list.titleSelectedColor = [UIColor blackColor];
        _title_list.defaultSelectedIndex =0;

        [self.view addSubview:_title_list];
        [_title_list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.top.mas_equalTo(self.view.mas_top).mas_offset(StatusbarHeight);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
            make.width.mas_equalTo(@240);
        }];
    }
    return _title_list;
}

-(JXCategoryListContainerView *)listContainerView{
    
    if (!_listContainerView) {
      _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.title_list.mas_bottom);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-SafeAreaBottom);
        }];
    }
    return _listContainerView;
}

-(UIView *)V_line{
    
    if (!_V_line) {
        _V_line = [[UIView alloc]init];
        [self.title_list addSubview:_V_line];
        _V_line.backgroundColor = [UIColor grayColor];
        [_V_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.7);
            make.width.mas_equalTo(MainScreenWidth);
            make.left.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.title_list.mas_bottom);
        }];
    }
    return _V_line;
}

@end
