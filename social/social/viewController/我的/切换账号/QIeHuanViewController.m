//
//  QIeHuanViewController.m
//  social
//
//  Created by QianYuan on 2020/9/8.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "QIeHuanViewController.h"

@interface QIeHuanViewController ()

@end

@implementation QIeHuanViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"切换账号";

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
