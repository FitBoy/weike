//
//  ChatBgViewController.m
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "ChatBgViewController.h"
#import "L_IV_rightTableViewCell.h"
#import "FooterView.h"
#import "ImageSelectedCollectionViewCell.h"
#import "ImageModel.h"
@interface ChatBgViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    NSArray *arr_images;
    NSInteger Id_selected;
}
@property (nonatomic,strong) L_IV_rightTableViewCell *cell_top;
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong) UICollectionView *collectionV;
@property (nonatomic,strong) FooterView *footer;
@property (nonatomic,strong) UIImagePickerController *picker;
@end

@implementation ChatBgViewController
#pragma mark -- 从相册选择
-(void)ClickPhoto{
    [self presentViewController:self.picker animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"设置聊天背景";
    self.cell_top.hidden=NO;
    self.L_name.hidden=NO;
    Id_selected = 0;
    [self loadData];
}
-(void)loadData{
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/user/backgroundIndex"] parameters:@{} success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            NSArray *tarr = responseObject[@"data"];
            self->arr_images = [ImageModel mj_objectArrayWithKeyValuesArray:tarr];
            dispatch_async(dispatch_get_main_queue(), ^{
               [self.collectionV reloadData];
            });
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr_images.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageSelectedCollectionViewCell *cell =(ImageSelectedCollectionViewCell *) [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:Id_selected inSection:0]];
    [cell setdisSelected];
    
    ImageSelectedCollectionViewCell *cell_sele =(ImageSelectedCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [cell_sele setselected];
    
    Id_selected =indexPath.row;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageSelectedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewcell" forIndexPath:indexPath];
    ImageModel *model = arr_images[indexPath.row];
    [cell.IV_image sd_setImageWithURL:[NSURL URLWithString:model.image_address]];
    [cell setdisSelected];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        FooterView *tfooter = [[FooterView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 120)];
        tfooter.L_search.text = @"确定";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickSure)];
        [tfooter.L_search addGestureRecognizer:tap];
        [footer addSubview:tfooter];
        return footer;
    }
    return nil;
    
}

#pragma mark -- 确定
-(void)ClickSure{
    
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,user_setBackground] parameters:@{
        @"background_id":@(Id_selected)
    } success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            [EasyTextView showSuccessText:@"设置成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- 设置聊天背景
-(void)setBgWithStr:(NSString *)baseImage{
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,user_setBackground] parameters:@{
        @"background_img":baseImage
    } success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            [EasyTextView showSuccessText:@"自定义背景设置成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark -- 相册的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [EasyLoadingView showLoading];
    [self UploadImages:@[image] block:^(BOOL isSuccess, NSString * _Nonnull tstr) {
        [self setBgWithStr:tstr];
    }];
}
#pragma mark -- 懒加载
-(UILabel *)L_name{
    
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self.view addSubview:_L_name];
        _L_name.text = @"选择背景图";
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.top.mas_equalTo(self.cell_top.mas_bottom);
        }];
    }
    return _L_name;
}

-(L_IV_rightTableViewCell *)cell_top{
    
    if (!_cell_top) {
        _cell_top = [[L_IV_rightTableViewCell alloc]init];
        [self.view addSubview:_cell_top];
        _cell_top.IV_more.hidden =NO;
        _cell_top.L_name.text = @"从相册中选择";
        [_cell_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(60);
            make.top.mas_equalTo(self.view.mas_top).mas_offset(StatusbarAndNavigationbarHeight);
        }];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickPhoto)];
        [_cell_top addGestureRecognizer:tap];
    }
    return _cell_top;
}
-(UICollectionView *)collectionV{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =0.1;
    layout.minimumInteritemSpacing=0.1;
    layout.footerReferenceSize = CGSizeMake(MainScreenWidth, 120);
    float width = (MainScreenWidth -40)/3.0;
    layout.itemSize =CGSizeMake(width, width*16/9.0);
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.showsVerticalScrollIndicator =NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionV];
        [_collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.L_name.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-SafeAreaBottom);
        }];
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
        [_collectionV registerClass:[ImageSelectedCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewcell"];
        _collectionV.backgroundColor = [UIColor whiteColor];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionV;
}

-(UIImagePickerController *)picker{
    
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        _picker.allowsEditing = YES;
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.delegate = self;
    }
    return _picker;
}


@end
