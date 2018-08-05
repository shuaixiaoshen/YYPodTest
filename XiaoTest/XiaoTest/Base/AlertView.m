//
//  AlertView.m
//  XiaoTest
//
//  Created by shen on 2018/7/30.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView{
    UIImage *alertImg;
    NSString *alertTitle;
}

- (instancetype)initWithFrame:(CGRect)frame AlertImg:(UIImage *)img AlertTitle:(NSString *)title{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        alertImg = img;
        alertTitle = title;
        [self common];
    }
    return self;
}

- (void)common{
    UIImageView *alertImage = [[UIImageView alloc] initWithImage:alertImg];
    alertImage.contentMode = UIViewContentModeCenter;
    [self addSubview:alertImage];
    [alertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_offset(@215);
        make.height.mas_offset(@150);
    }];
    UILabel *alertLab = [[UILabel alloc] init];
    alertLab.text = alertTitle;
    alertLab.font = [UIFont systemFontOfSize:15];
    alertLab.textColor = [UIColor grayColor];
    [self addSubview:alertLab];
    [alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertImage.mas_bottom).mas_offset(0);
        make.centerX.equalTo(self);
    }];
    UITapGestureRecognizer *tapHand = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapSeletate)];
    [self addGestureRecognizer:tapHand];
}

- (void)handleTapSeletate{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleProtocolAlert:)]) {
        [self.delegate handleProtocolAlert:alertTitle];
    }
}

@end
