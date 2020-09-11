//
//  ShakeViewController.m
//  social
//
//  Created by QianYuan on 2020/9/8.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "ShakeViewController.h"

@interface ShakeViewController ()
@property (nonatomic,strong) UILabel *L_text;
@end

@implementation ShakeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"摇一摇";
    self.L_text.text = @"摇一摇试试";
}
- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

#pragma mark - 摇动

/**
 *  摇动开始
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake) {
        
        NSLog(@"开始摇了");
        self.L_text.text = @"开始摇了";
        
    }
}

/**
 *  摇动结束
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    NSLog(@"摇动结束");
    
   self.L_text.text = @"摇动结束";
}

/**
 *  摇动取消
 */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    NSLog(@"摇动取消");
    self.L_text.text = @"摇动取消";
   
}

-(UILabel *)L_text{
    
    if (!_L_text) {
        _L_text = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, MainScreenWidth, 50)];
        _L_text.font = [UIFont systemFontOfSize:30];
        _L_text.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_L_text];
    }
    return _L_text;
    
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
