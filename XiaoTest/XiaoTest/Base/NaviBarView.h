//
//  NaviBarView.h
//  YYTest
//
//  Created by shen on 2017/3/22.
//  Copyright © 2017年 dingyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviBarView : UIView

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIButton *backBtn;
@property (assign, nonatomic) BOOL isHidden;
@property (assign, nonatomic) BOOL isLine;
@property (assign, nonatomic) BOOL isBackRootVC;

@end
