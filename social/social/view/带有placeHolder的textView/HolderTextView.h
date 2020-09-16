//
//  HolderTextView.h
//  social
//
//  Created by QianYuan on 2020/9/11.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HolderTextView : UITextView
@property (nonatomic,copy) NSString * placeHolder;

-(void)setPlaceHolder:(NSString * _Nonnull)placeHolder;
@end

NS_ASSUME_NONNULL_END
