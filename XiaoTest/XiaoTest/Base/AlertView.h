//
//  AlertView.h
//  XiaoTest
//
//  Created by shen on 2018/7/30.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol   AlertViewDelegate<NSObject>

- (void)handleProtocolAlert:(NSString *)alertMessage;

@end

@interface AlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame AlertImg:(UIImage *)img AlertTitle:(NSString *)title;


@property(assign, nonatomic) id<AlertViewDelegate>delegate;

@end
