//
//  LocationListViewController.m
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "LocationListViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface LocationListViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>
{
    NSMutableArray *arr_models;
}
@property (nonatomic,strong) AMapLocationManager *locationManger;
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) AMapPOIAroundSearchRequest *request;

@end

@implementation LocationListViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"附近";
    [AMapServices sharedServices].apiKey = AMap_key;
    arr_models = [NSMutableArray arrayWithCapacity:0];
    
    
    [self.locationManger requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            [EasyTextView showErrorText:@"定位错误，网络异常"];
        }else{
            
            self.request.location =[AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.search AMapPOIAroundSearch:self.request];
            });
            
        }
        
    }];
    
}

#pragma mark -- 定位的协议代理
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count==0) {
        [EasyTextView showErrorText:@"网络错误"];
        return;
    }else{
        [arr_models removeAllObjects];
        [arr_models addObjectsFromArray:response.pois];
        [self.tableV reloadData];
    }
    
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AMapPOI *poi = arr_models[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate_location respondsToSelector:@selector(getLocationPoi:)]) {
        AMapPOI *poi = arr_models[indexPath.row];
        [self.delegate_location  getLocationPoi:poi];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -- 懒加载

-(AMapPOIAroundSearchRequest*)request{
    
    if (!_request) {
        _request = [[AMapPOIAroundSearchRequest alloc]init];
        _request.sortrule = 0;
        _request.requireExtension = YES;
    }
    return _request;
}
-(AMapSearchAPI *)search{
    
    if (!_search) {
        _search = [[AMapSearchAPI alloc]init];
        _search.delegate = self;
        
    }
    return _search;
}
-(AMapLocationManager *)locationManger{
    
    if(!_locationManger){
        _locationManger = [[AMapLocationManager alloc]init];
        [_locationManger setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        [_locationManger setReGeocodeTimeout:10];
        [_locationManger setLocationTimeout:10];
    }
    return _locationManger;
    
}
-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom) style:UITableViewStylePlain];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.rowHeight =60;
       // [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    }
    return _tableV;
}


@end
