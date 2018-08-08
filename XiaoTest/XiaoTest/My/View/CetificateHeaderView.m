//
//  CetificateHeaderView.m
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "CetificateHeaderView.h"

@implementation CetificateHeaderView

+ (CetificateHeaderView *)cetiAddSubView:(UIView *)subView{
    CetificateHeaderView *headerView = [[CetificateHeaderView alloc] init];
    [subView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@64);
        make.left.mas_offset(@25);
        make.right.mas_offset(@-25);
        make.height.mas_offset(@70);
    }];
    return headerView;
}

- (void)startSetUp{
    if (!_sourceArr) {
        _sourceArr = @[@"身份认证",@"信息认证",@"亲属",@"常用联系人",@"运营商",@"淘宝",@"支付宝",@"学信网"];
    }
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@15);
        make.right.mas_offset(@-15);
        make.centerY.equalTo(self);
        make.height.mas_offset(@1);
    }];
    CGFloat width = (KscreenWidth - 80) / 7;
    for (NSInteger i = 0; i < _sourceArr.count; i++) {
        UIImageView *circularImg = [[UIImageView alloc] init];
        circularImg.image = [UIImage imageNamed:@"circular-grey"];
        [self addSubview:circularImg];
        [circularImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(line).mas_offset(-.5);
            make.width.height.mas_offset(@15);
            make.left.mas_offset(width * i + 7.5);
        }];
        if (_sourceType == i) {
            UIImageView *currentImg = [[UIImageView alloc] init];
            currentImg.image = [UIImage imageNamed:@"circular-blue"];
            [self addSubview:currentImg];
            [currentImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(circularImg);
                make.width.height.mas_offset(@25);
            }];
            UILabel *typeLab = [[UILabel alloc] init];
            typeLab.textColor = [UIColor whiteColor];
            typeLab.text = [NSString stringWithFormat:@"%ld",_sourceType + 1] ;
            [self addSubview:typeLab];
            typeLab.font = [UIFont systemFontOfSize:11];
            [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(circularImg);
            }];
        }
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor darkGrayColor];
        titleLab.text = _sourceArr[i];
        [self addSubview:titleLab];
        titleLab.font = [UIFont systemFontOfSize:9];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(circularImg);
            make.top.equalTo(circularImg.mas_bottom).mas_offset(10);
        }];
        
    }
    
    
}



@end
