//
//  DepartChooseViewController.h
//  social
//
//  Created by QianYuan on 2020/9/5.
//  Copyright © 2020 QianYuan. All rights reserved.
// 部门与岗位的选择

#import "BaseViewController.h"
#import "DepartModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DepartChooseViewController : BaseViewController
@property (nonatomic,weak) id delegate_depart;
@end
@protocol DepartChooseViewControllerDelegate <NSObject>
-(void)getDepat:(DepartModel*)depart gangwei:(DepartModel *)gangwei;
@end

NS_ASSUME_NONNULL_END
