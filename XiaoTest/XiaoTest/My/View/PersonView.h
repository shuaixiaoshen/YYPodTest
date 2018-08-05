//
//  PersonView.h
//  XiaoTest
//
//  Created by shen on 2018/7/14.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonViewDelegate <NSObject>

- (void)handleSaveUserInfoWithDic:(NSDictionary *)dic;
- (void)handlePushUserPhotoWithImg:(UIImageView *)img;
- (void)showAlertTitle:(NSString *)alert;

@end

@interface PersonView : UIView<UIScrollViewDelegate>

+ (PersonView *)personAddSubView:(UIView *)subView;

- (void)startSetUp;

@property(assign, nonatomic) id<PersonViewDelegate>delegate;

@property(strong, nonatomic) UIImageView *img1;
@property(strong, nonatomic) UIImageView *img2;

@property(assign, nonatomic) BOOL isStu;

@property(strong, nonatomic) NSDictionary *infodic;
@property(assign, nonatomic) NSInteger code;
@end
