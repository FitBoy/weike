//
//  indexPathTapGestureRecognizer.h
//  social
//
//  Created by QianYuan on 2020/9/16.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface indexPathTapGestureRecognizer : UITapGestureRecognizer
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
