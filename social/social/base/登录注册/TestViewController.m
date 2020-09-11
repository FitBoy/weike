//
//  TestViewController.m
//  social
//
//  Created by QianYuan on 2020/9/4.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "TestViewController.h"
#import <SDWebImage.h>
@interface TestViewController ()
@property (nonatomic,strong) UIScrollView *scrollV;
@property (nonatomic,strong) UIImageView *IV_img;
@end

@implementation TestViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
}
-(void)setUI{
    
    self.scrollV.contentSize =CGSizeMake(1534*2, 2124*2);
   
    /***
     176,32,1200,432
     472,644,264,144
     276,580,196,144
     
     848,620,212,112
     1064,660,304,160
     172,1208,1016,152
     268,1388,396,156
     876,1392,348,180
     
     156,1564,356,136
     272,1836,432,188
     708,1544,292,124
     1032,1600,272,136
     **/
    
    UIView *v14= [[UIView alloc]initWithFrame:CGRectMake(1032,1600,272,136)];
    [self setStatusWithView:v14];
    [self.IV_img addSubview:v14];
    
    UIView *v13= [[UIView alloc]initWithFrame:CGRectMake(708,1544,292,124)];
       [self setStatusWithView:v13];
       [self.IV_img addSubview:v13];
    UIView *v12= [[UIView alloc]initWithFrame:CGRectMake(272,1836,432,188)];
    [self setStatusWithView:v12];
    [self.IV_img addSubview:v12];
    
    UIView *v11= [[UIView alloc]initWithFrame:CGRectMake(156,1564,356,136)];
    [self setStatusWithView:v11];
    [self.IV_img addSubview:v11];
    
    
    UIView *v10= [[UIView alloc]initWithFrame:CGRectMake(1032,1036,240,140)];
    [self setStatusWithView:v10];
    [self.IV_img addSubview:v10];
    
    UIView *v9= [[UIView alloc]initWithFrame:CGRectMake(744,1028,252,116)];
       [self setStatusWithView:v9];
       [self.IV_img addSubview:v9];
    UIView *v8= [[UIView alloc]initWithFrame:CGRectMake(384,1260,292,152)];
    [self setStatusWithView:v8];
    [self.IV_img addSubview:v8];
    
    UIView *v7= [[UIView alloc]initWithFrame:CGRectMake(148,1072,352,112)];
    [self setStatusWithView:v7];
    [self.IV_img addSubview:v7];
    
    UIView *v6= [[UIView alloc]initWithFrame:CGRectMake(84,944,636,120)];
    [self setStatusWithView:v6];
    [self.IV_img addSubview:v6];
    
    UIView *v5= [[UIView alloc]initWithFrame:CGRectMake(692,540,400,204)];
             [self setStatusWithView:v5];
             [self.IV_img addSubview:v5];
    
    UIView *v4= [[UIView alloc]initWithFrame:CGRectMake(844,412,288,104)];
          [self setStatusWithView:v4];
          [self.IV_img addSubview:v4];
    
    UIView *v3= [[UIView alloc]initWithFrame:CGRectMake(368,700,336,168)];
       [self setStatusWithView:v3];
       [self.IV_img addSubview:v3];
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(68,84,1212,356)];
    [self setStatusWithView:v1];
    [self.IV_img addSubview:v1];
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(192,448,304,136)];
    [self setStatusWithView:v2];
    [self.IV_img addSubview:v2];
    
    
    
}

-(void)setStatusWithView:(UIView *)view {
    
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.borderWidth=1;
    
}

-(UIImageView *)IV_img{
    
    if (!_IV_img) {
       _IV_img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1534, 2124)];
        [self.scrollV addSubview:_IV_img];
        _IV_img.image = [UIImage imageNamed:@"111.jpg"];
   
        
        
        
    }
    return _IV_img;
}

-(UIScrollView *)scrollV{
    
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1534, 2124)];
        _scrollV.scrollEnabled =YES;
        [self.view addSubview:_scrollV];
    }
    return _scrollV;
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
