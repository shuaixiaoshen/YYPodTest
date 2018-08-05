//
//  OtherView.h
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OtherViewDelegate <NSObject>

- (void)handleSaveOtherInfoWithDic:(NSDictionary *)dic;
- (void)showAlertTitle:(NSString *)alert;
@end

@interface OtherView : UIView<UIScrollViewDelegate>

+ (OtherView *)otherAddSubView:(UIView *)subView;

- (void)startSetUp;

@property(assign, nonatomic) id<OtherViewDelegate>delegate;
@property(strong, nonatomic) NSDictionary *infodic;
@property(assign, nonatomic) NSInteger code;
@end
