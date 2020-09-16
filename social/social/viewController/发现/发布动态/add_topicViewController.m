//
//  add_topicViewController.m
//  social
//
//  Created by QianYuan on 2020/9/14.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "add_topicViewController.h"
#import "HolderTextView.h"
#import "image_leftTableViewCell.h"
#import "ImageCollectionViewCell.h"
#import "FooterView.h"
#import <TZImagePickerController.h>
#import "ImagesSeeViewController.h"
#import "imagePlayCollectionViewCell.h"
#import "LocationListViewController.h"
@interface add_topicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,LocationListViewControllerDelegate>
{
    NSMutableArray *arr_images;
    BOOL Is_Video;
    
    UIImage *videoImage;
    NSString *videoPath;
    PHAsset * video_asset;
    AMapPOI  *location_poi;
}

@property (nonatomic,strong) HolderTextView *textV;
@property (nonatomic,strong) UICollectionView *collectionV;
@property (nonatomic,strong) image_leftTableViewCell *cell;

@property (nonatomic,strong) FooterView *footer_V;
@property (nonatomic,strong) TZImagePickerController *picker_muti; //照片选择器
@property (nonatomic,strong) TZImagePickerController *picker_video;//视频选择器




@end

@implementation add_topicViewController
#pragma mark -- 获取选择的定位
-(void)getLocationPoi:(AMapPOI *)poi{
    self.cell.L_name.text = poi.name;
    location_poi = poi;
}

#pragma mark -- 定位
-(void)ClickPlace{
    
    LocationListViewController *Lvc = [[LocationListViewController alloc]init];
    Lvc.delegate_location = self;
    [self.navigationController pushViewController:Lvc animated:YES];
}

#pragma mark -- 发布
-(void)Clcikfabu{
    
    if(self.textV.text.length ==0 && arr_images.count ==0 &&  videoPath ==nil){
        [EasyTextView showErrorText:@"不能发布没有内容的信息"];
        return;
    }
    
    [EasyLoadingView showLoading];
    NSMutableDictionary *tdic = [NSMutableDictionary dictionary];
    if (self.textV.text.length !=0) {
        [tdic setObject:self.textV.text forKey:@"title"];
    }
    if(location_poi!=nil){
         [tdic setObject:@"0" forKey:@"hidden_position"];
        [tdic setObject:[NSString stringWithFormat:@"%f",location_poi.location.latitude] forKey:@"lat"];
        [tdic setObject:[NSString stringWithFormat:@"%f",location_poi.location.longitude] forKey:@"lng"];
        [tdic setObject:location_poi.citycode forKey:@"city_code"];
        [tdic setObject:location_poi.name forKey:@"address"];
        
    }else{
        [tdic setObject:@"1" forKey:@"hidden_position"];
        
    }
    
    
    if(Is_Video == NO){
        if (arr_images.count!=0) {
            [self UploadImages:arr_images block:^(BOOL isSuccess, NSString * _Nonnull tstr) {
                [tdic setObject:tstr forKey:@"images"];
                [self fabuWithdic:tdic];
             
            }];
        }else{
          [self fabuWithdic:tdic];
        }
        
    }else{
        //video
    
        NSData *data = [[NSData alloc]initWithContentsOfFile:videoPath];
        [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/postFile"] parameters:@{} constructBody:@[data] success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] integerValue] ==1) {
                [tdic setObject:responseObject[@"data"][@"videoPath"] forKey:@"video"];
                [self fabuWithdic:tdic];
            }else{
                [EasyTextView showErrorText:responseObject[@"msg"]];
            }
        } error:^(NSError * _Nonnull error) {
            
        }];
        
    }
    
    
}

-(void)fabuWithdic:(NSDictionary *)dic {
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/topic/add"] parameters:dic success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            [EasyTextView showSuccessText:@"发布成功"];
            [userDefault setBool:YES forKey:topic_sendsuccess];
            [userDefault synchronize];
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
    self.navigationItem.title = @"发布动态";
    arr_images = [NSMutableArray arrayWithCapacity:0];
    self.textV.hidden = NO;
    [self.collectionV reloadData];
    Is_Video = NO;
    location_poi = nil;

}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        [footer addSubview:self.cell];
        [self.cell mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(footer);
            make.height.mas_equalTo(60);
            make.top.mas_equalTo(footer).mas_offset(10);
        }];
        [footer addSubview:self.footer_V];
        return footer;
    }else if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header addSubview:self.textV];
        return header;
    }else{
        return nil;
    }
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (Is_Video ==NO) {
        if (arr_images.count >8) {
                  return arr_images.count;
              }else{
                return arr_images.count+1;
              }
    }else{
   return 1;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (Is_Video ==NO) {
    if (arr_images.count<9 && indexPath.row ==arr_images.count) {
        if (arr_images.count ==0) {
        UIAlertController *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"相册",@"视频"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i==0) {
                    //相册
                   // self.picker_muti.maxImagesCount = 9-self->arr_images.count;
                    self.picker_muti.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:self.picker_muti animated:YES completion:nil];
                    
                }else if (i==1 ){
                //视频
                    self.picker_video.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:self.picker_video animated:YES completion:nil];
                    
                }else{
                    
                    //拍视频
                }
                
                  }]];
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:nil];
        });
        }else{
            self.picker_muti.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:self.picker_muti animated:YES completion:nil];
        }
    }else{
        ImagesSeeViewController *Svc = [[ImagesSeeViewController alloc]init];
        Svc.arr_images =arr_images;
        Svc.Index_default = indexPath.row;
        [self.navigationController pushViewController:Svc animated:YES];
    }
    }else{
      
        TZVideoPlayerController *Videovc = [[TZVideoPlayerController alloc]init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:video_asset type:TZAssetModelMediaTypeVideo];
        Videovc.model = model;
        Videovc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:Videovc animated:YES completion:nil];
        
    }
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (Is_Video ==NO) {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewcell" forIndexPath:indexPath];
    if (arr_images.count<9 && indexPath.row ==arr_images.count ) {
        cell.IV_image.image = [UIImage imageNamed:@"image_add"];
    }else{
        cell.IV_image.image = arr_images[indexPath.row];
    }
    
    return cell;
    }else{
    imagePlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewcell1" forIndexPath:indexPath];
        cell.IV_image.image = videoImage;
        cell.IV_play.hidden = NO;
        return cell;
    }
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [arr_images removeAllObjects];
    [arr_images addObjectsFromArray:photos];
    Is_Video =NO;
    [self.collectionV reloadData];
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
}
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset{
    
    videoImage = coverImage;
    Is_Video = YES;
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetLowQuality success:^(NSString *outputPath) {
         // NSData *data = [NSData dataWithContentsOfFile:outputPath];
         NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        self->videoPath  = outputPath;
        self->video_asset =asset;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionV reloadData];
        });
     } failure:^(NSString *errorMessage, NSError *error) {
         NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
     }];
    
}



#pragma mark -- 懒加载
-(TZImagePickerController *)picker_video{
    
    if (!_picker_video) {
        _picker_video = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        _picker_video.allowTakeVideo = YES;
        _picker_video.allowPickingVideo = YES;
        _picker_video.allowPickingImage = NO;
        _picker_video.videoMaximumDuration = 60;
        [_picker_video setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
         imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        }];
        
    }
    return _picker_video;
}


-(TZImagePickerController *)picker_muti{
    
    if (!_picker_muti) {
        _picker_muti = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
        _picker_muti.allowTakeVideo =YES;
        _picker_muti.allowPickingVideo = NO;
        
    }
    return _picker_muti;
}

-(UICollectionView *)collectionV{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =5;
    layout.minimumInteritemSpacing=0.1;
    layout.footerReferenceSize = CGSizeMake(MainScreenWidth, 200);
    layout.headerReferenceSize = CGSizeMake(MainScreenWidth, 150);
    float width = (MainScreenWidth -40)/3.0;
    layout.itemSize =CGSizeMake(width, width);
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom) collectionViewLayout:layout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.showsVerticalScrollIndicator =NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionV];
        /*
        [_collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.textV.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-SafeAreaBottom);
        }];*/
       _collectionV.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
        [_collectionV registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewcell"];
         [_collectionV registerClass:[imagePlayCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewcell1"];
        _collectionV.backgroundColor = [UIColor whiteColor];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionV;
}

-(FooterView *)footer_V{
    
    if (!_footer_V) {
        _footer_V = [[FooterView alloc]initWithFrame:CGRectMake(0, 70, MainScreenWidth, 120)];
        _footer_V.L_search.text = @"发布";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clcikfabu)];
        [_footer_V.L_search addGestureRecognizer:tap];
    }
    return _footer_V;
}

-(image_leftTableViewCell *)cell{
    
    if (!_cell) {
        _cell = [[image_leftTableViewCell alloc]initWithFrame:CGRectMake(0, 20, MainScreenWidth, 50)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickPlace)];
        [_cell addGestureRecognizer:tap];
        _cell.IV_image.image = [UIImage imageNamed:@"place"];
           _cell.L_name.text =@"所在位置";
           _cell.IV_more.hidden = NO;
        
        
    }
    return _cell;
}

-(HolderTextView *)textV{
    
    if (!_textV) {
        _textV = [[HolderTextView alloc]initWithFrame:CGRectMake(15, 0, MainScreenWidth-30, 150)];
        [self.view addSubview:_textV];
        _textV.placeHolder = @"这一刻的想法";
        /*
        [_textV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.view.mas_top).mas_offset(StatusbarAndNavigationbarHeight);
            make.height.mas_equalTo(160);
        }];*/
    }
    return _textV;
}


@end
