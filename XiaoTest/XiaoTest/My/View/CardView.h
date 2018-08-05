//
//  CardView.h
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardViewDelegate <NSObject>

- (void)handlePushCardPhotoWithImg:(UIImageView *)img;

- (void)handlePostCardRequestWithDic:(NSDictionary *)dic;

@end


@interface CardView : UIView<UIScrollViewDelegate>

+ (CardView *)cardAddSubView:(UIView *)subView;

- (void)startSetUp;

@property(assign, nonatomic) id<CardViewDelegate>delegate;

@property(strong, nonatomic) UIImageView *img1;
@property(strong, nonatomic) UIImageView *img2;
@property(strong, nonatomic) UIImageView *img3;

@property(strong, nonatomic) UITextField *nameField;
@property(strong, nonatomic) UITextField *cardField;


@property(strong, nonatomic) NSDictionary *infodic;
@property(assign, nonatomic) NSInteger code;

@end
