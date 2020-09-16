//
//  Help_SZViewController.m
//  social
//
//  Created by QianYuan on 2020/9/10.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "Help_SZViewController.h"
#import "L_IV_rightTableViewCell.h"
#import "HolderTextView.h"
#import "ImageCollectionViewCell.h"
#import "FooterView.h"
#import "ImagesSeeViewController.h"
#import "IndexLongPressGestureRecognizer.h"
@interface Help_SZViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>
{
    NSMutableArray *arr_imgs;
}
@property (nonatomic,strong) L_IV_rightTableViewCell *cell_shuoming;
//@property (nonatomic,strong) UILabel *L_fankui;
@property (nonatomic,strong) HolderTextView *textView;
@property (nonatomic,strong) UICollectionView *collectionV;
@property (nonatomic,strong) FooterView *footer;

@end

@implementation Help_SZViewController
#pragma mark -- 反馈
-(void)ClickFankui{
    
    if (self.textView.text.length==0) {
        [EasyTextView showErrorText:@"请输入反馈信息"];
        return;
    }
    
    
    [EasyLoadingView showLoading];
    
    NSMutableString *str_imgs = [NSMutableString string];
    for (int i=0; i<arr_imgs.count; i++) {
          NSString *tstr = [self base64FromImage:arr_imgs[i]];
        if (i==arr_imgs.count-1) {
          
            [str_imgs appendString:tstr];
        }else{
            [str_imgs appendFormat:@"%@-",tstr];
        }
    }
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/multiBase64Upload"] parameters:@{
        @"imgurl":str_imgs
    } success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            //再次上传反馈信息
            [self fankuiWithimages:responseObject[@"data"][@"str"]];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- 上传反馈的信息
-(void)fankuiWithimages:(NSString*)imgs{
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/user/addFeedback"] parameters:@{
        @"content":self.textView.text,
        @"imgs":imgs
    } success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            [EasyTextView showSuccessText:@"反馈成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助反馈";
    [self setUI];
    
}
-(void)setUI{
    arr_imgs =[NSMutableArray arrayWithCapacity:0];
    self.cell_shuoming.L_name.text = @"查看使用说明";
    self.textView.placeHolder =@"输入要反馈的问题";
    self.footer.L_search.text = @"反馈";
    [self.collectionV reloadData];
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (arr_imgs.count ==9) {
        return 9;;
    }else{
        return arr_imgs.count+1;
    }
  
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row !=8 && indexPath.row ==arr_imgs.count) {
        TZImagePickerController *elcPicker = [[TZImagePickerController alloc] initWithMaxImagesCount:9-arr_imgs.count delegate:self];
        
        elcPicker.modalPresentationStyle = UIModalPresentationFullScreen;
      [self presentViewController:elcPicker animated:YES completion:nil];
        
    }else{
       
        ImagesSeeViewController *Svc = [[ImagesSeeViewController alloc]init];
        Svc.arr_images = arr_imgs;
        Svc.Index_default =indexPath.row;
        [self.navigationController pushViewController:Svc animated:YES];
      
        
    }
}

-(void)collectionViewUpdateLayout{
    float width = (MainScreenWidth -40)/3.0;
       if (arr_imgs.count>2 && arr_imgs.count <6) {
           [self.collectionV mas_updateConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(width+width+10);
               
           }];
       }else if (arr_imgs.count<3){
           [self.collectionV mas_updateConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(width+5);
                 }];
       }else{
           [self.collectionV mas_updateConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo((width+5)*3);
             }];
           
       }
        [self.collectionV layoutIfNeeded];
       [self.collectionV reloadData];
    
}


#pragma mark -- 相册的协议代理
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [arr_imgs addObjectsFromArray:photos];
    [self collectionViewUpdateLayout];
    
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewcell" forIndexPath:indexPath];
    if (arr_imgs.count<9 && indexPath.row ==arr_imgs.count) {
        cell.IV_image.image = [UIImage imageNamed:@"image_add"];
    }else{
        cell.IV_image.image=arr_imgs[indexPath.row];
        IndexLongPressGestureRecognizer *longPress = [[IndexLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(ClickLongPress:)];
        longPress.indexPath = indexPath;
        [cell.IV_image addGestureRecognizer:longPress];
    }
    
    return cell;
}

-(void)ClickLongPress:(IndexLongPressGestureRecognizer*)longPress{
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self->arr_imgs removeObjectAtIndex:longPress.indexPath.row];
        [self collectionViewUpdateLayout];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    
}


#pragma mark -- 懒加载

-(FooterView *)footer{
    
    if (!_footer) {
        _footer = [[FooterView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)];
        _footer.L_search.text = @"反馈";
        [self.view addSubview:_footer];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickFankui)];
        [_footer.L_search addGestureRecognizer:tap];
        [_footer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(MainScreenWidth, 100));
            make.left.mas_equalTo(self.view);
            make.top.mas_equalTo(self.collectionV.mas_bottom);
        }];
    }
    return _footer;
}
-(L_IV_rightTableViewCell *)cell_shuoming{
    
    if (!_cell_shuoming) {
        _cell_shuoming = [[L_IV_rightTableViewCell alloc]init];
        [self.view addSubview:_cell_shuoming];
        [_cell_shuoming mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(MainScreenWidth, 50));
            make.top.mas_equalTo(self.view.mas_top).mas_offset(StatusbarAndNavigationbarHeight);
            make.left.mas_equalTo(self.view.mas_left);
        }];
    }
    return _cell_shuoming;
}

-(HolderTextView *)textView{
    if (!_textView) {
        _textView = [[HolderTextView alloc]init];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.cell_shuoming.mas_bottom);
        }];
    }
    return _textView;
    
}

-(UICollectionView *)collectionV{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =0.1;
    layout.minimumInteritemSpacing=0.1;
    float width = (MainScreenWidth -40)/3.0;
    layout.itemSize =CGSizeMake(width, width);
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
            make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(width+5);
        }];
        _collectionV.contentInset = UIEdgeInsetsMake(5, 0, 5, 5);
        [_collectionV registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewcell"];
        _collectionV.backgroundColor = [UIColor whiteColor];
    }
    return _collectionV;
}

@end
