//
//  ImagesSeeViewController.m
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
// 多图片查看器

#import "ImagesSeeViewController.h"
#import "BaseViewController.h"
#import "ImageCollectionViewCell.h"
@interface ImagesSeeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionV;

@end

@implementation ImagesSeeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"左右滑动图片";
    //[NSString stringWithFormat:@"%ld/%ld",self.Index_default+1,self.arr_images.count];
    [self.collectionV reloadData];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
      [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.Index_default inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr_images.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     ImageCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewcell" forIndexPath:indexPath];
    UIImage *image = self.arr_images[indexPath.item];
    cell.IV_image.contentMode = UIViewContentModeScaleAspectFit;
    cell.IV_image.image = image;
    return cell;
}


-(UICollectionView *)collectionV{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =0.1;
    layout.minimumInteritemSpacing=0.1;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize =CGSizeMake(MainScreenWidth, MainScreenHeight-StatusbarAndNavigationbarHeight);
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.showsVerticalScrollIndicator =NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionV];
        [_collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.top.mas_equalTo(self.view.mas_top).mas_offset(StatusbarAndNavigationbarHeight);
            make.height.mas_equalTo(MainScreenHeight-StatusbarAndNavigationbarHeight);
        }];
        _collectionV.contentInset = UIEdgeInsetsMake(5, 0, 5, 5);
        [_collectionV registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewcell"];
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.pagingEnabled =YES;
    }
    return _collectionV;
}


@end
