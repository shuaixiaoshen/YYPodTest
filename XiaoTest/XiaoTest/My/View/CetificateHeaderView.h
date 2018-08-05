//
//  CetificateHeaderView.h
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CetificateHeaderView : UIView

+ (CetificateHeaderView *)cetiAddSubView:(UIView *)subView;

@property(assign,nonatomic) NSInteger sourceType;

@property(strong, nonatomic) NSArray *sourceArr;

- (void)startSetUp;

@end
