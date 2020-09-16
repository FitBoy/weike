//
//  ImageSelectedCollectionViewCell.h
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "ImageCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageSelectedCollectionViewCell : ImageCollectionViewCell
@property (nonatomic,strong) UIImageView *IV_selected;

-(void)setselected;
-(void)setdisSelected;
@end

NS_ASSUME_NONNULL_END
