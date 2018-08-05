//
//  FriendeView.h
//  XiaoTest
//
//  Created by shen on 2018/7/28.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendeViewDelegate <NSObject>

- (void)handleSaveFriendeInfoWithDic:(NSDictionary *)dic;
- (void)showAlertTitle:(NSString *)alert;
@end

@interface FriendeView : UIView<UIScrollViewDelegate>

+ (FriendeView *)friendeAddSubView:(UIView *)subView;

- (void)startSetUp;

@property(assign, nonatomic) id<FriendeViewDelegate>delegate;

@property(strong, nonatomic) NSDictionary *infodic;
@property(assign, nonatomic) NSInteger code;
@end
