//
//  GuanzhuViewController.h
//  social
//
//  Created by QianYuan on 2020/9/15.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "BaseViewController.h"
#import "Image_textTableViewCell.h"
#import "TopicModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GuanzhuViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr_models;
    NSString *page;
    NSString *scene;
}
@property (nonatomic,strong) UITableView *tableV;
-(void)loadheaderData;
-(void)loadFooterData;


@end

NS_ASSUME_NONNULL_END
