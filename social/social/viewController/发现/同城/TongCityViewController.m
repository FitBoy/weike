//
//  TongCityViewController.m
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "TongCityViewController.h"

@interface TongCityViewController ()

@end

@implementation TongCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    arr_models = [NSMutableArray arrayWithCapacity:0];
    scene = @"2";
    [self.tableV.mj_header beginRefreshing];

}
-(void)setdata{
   
    [self.tableV reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
