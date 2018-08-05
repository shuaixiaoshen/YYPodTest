//
//  CardView.m
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "CardView.h"

@implementation CardView{
    UIScrollView *scrollView;
    UIView *baseView;
}

+ (CardView *)cardAddSubView:(UIView *)subView{
    CardView *headerView = [[CardView alloc] init];
    [subView addSubview:headerView];
    return headerView;
}

- (void)layoutSubviews{
    scrollView.contentSize = CGSizeMake(KscreenWidth, 800);
}

- (void)startSetUp{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    scrollView.contentSize = CGSizeMake(KscreenWidth, 800);
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,KscreenWidth, scrollView.contentSize.height)];
    [scrollView addSubview:baseView];
    
    [self addCardWithTitle:@"拍摄人像面" img:@"card——1" type:0];
    [self addCardWithTitle:nil img:@"card——2" type:1];
    UIImageView *img = [self addCardWithTitle:nil img:@"card——3" type:2];
    UIView *nameView = [self addBottomViewWithView:img title:@"姓名"];
    UIView *cardView = [self addBottomViewWithView:nameView title:@"身份证号"];
    if (_code != 10) {
        UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        requestBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
        requestBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [requestBtn setTitle:@"确认申请" forState:UIControlStateNormal];
        [baseView addSubview:requestBtn];
        [requestBtn addTarget:self action:@selector(handleRequestBtn) forControlEvents:UIControlEventTouchUpInside];
        [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@35);
            make.left.mas_offset(@40);
            make.right.mas_offset(@-40);
            make.top.equalTo(cardView.mas_bottom).mas_offset(15);
        }];
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
}


- (void)handleRequestBtn{
    if (_nameField.text.length > 0 && _cardField.text.length > 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:_nameField.text  forKey:@"name"];
        [dic setObject:_cardField.text forKey:@"identity"];
        NSUserDefaultsSave(_cardField.text, @"Card_No");
        NSUserDefaultsSave(_nameField.text, @"Card_Name");
        if (self.delegate && [self.delegate respondsToSelector:@selector(handlePostCardRequestWithDic:)]) {
            [self.delegate handlePostCardRequestWithDic:dic];
        }

    }
}





- (void)handlePushImg:(UIButton *)btn{
    UIImageView *img = [scrollView viewWithTag:btn.tag - 3333];
    if (self.delegate && [self.delegate respondsToSelector:@selector(handlePushCardPhotoWithImg:)]) {
        [self.delegate handlePushCardPhotoWithImg:img];
    }
}

- (UIView *)addBottomViewWithView:(UIView *)aView title:(NSString *)aTitle{
    UIView *nameView = [[UIView alloc] init];
    [baseView addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.mas_bottom);
        make.left.right.mas_offset(@0);
        make.height.mas_offset(@35);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [nameView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.bottom.mas_offset(@0);
        make.height.mas_offset(@1);
    }];
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = aTitle;
    nameLab.font = [UIFont systemFontOfSize:14];
    [nameView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@20);
        make.width.mas_offset(@70);
        make.centerY.equalTo(nameView);
    }];
    UITextField *nameField = [[UITextField alloc] init];
    [nameView addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(KscreenWidth - 100);
        make.centerY.equalTo(nameLab);
        make.right.mas_offset(@15);
        make.height.mas_offset(@35);
    }];
    if ([aTitle isEqualToString:@"姓名"]) {
        _nameField = nameField;
    }else{
        _cardField = nameField;
    }
    return nameView;
}

- (UIImageView *)addCardWithTitle:(NSString *)title img:(NSString *)imgStr type:(NSInteger)type{
    UIImageView *cardImg = [[UIImageView alloc] init];
    cardImg.tag = 3333 + type;
    if (type == 0) {
        _img1 = cardImg;
    }else if (type == 1){
        _img2 = cardImg;
    }else{
        _img3 = cardImg;
    }
    [baseView addSubview:cardImg];
    cardImg.userInteractionEnabled = YES;
    cardImg.image = [UIImage imageNamed:imgStr];
    [cardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@75);
        make.right.mas_offset(@-75);
        make.height.mas_offset(@117);
        make.top.mas_offset(15 + (117 +15) * type);
    }];
    UIImageView *touchImg = [[UIImageView alloc] init];
    [cardImg addSubview:touchImg];
    touchImg.image = [UIImage imageNamed:@"card_carmer"];
    [touchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@60);
        make.centerX.equalTo(cardImg);
        make.centerY.equalTo(cardImg);
    }];
    if (title) {
        UILabel *cardLab = [[UILabel alloc] init];
        cardLab.text = title;
        cardLab.font = [UIFont systemFontOfSize:12];
        cardLab.textColor = [UIColor blackColor];
        [cardImg addSubview:cardLab];
        [cardLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(touchImg);
            make.top.equalTo(touchImg.mas_bottom).mas_offset(5);
        }];
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cardImg addSubview:btn];
    btn.tag = 6666 + type;
    [btn addTarget:self action:@selector(handlePushImg:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(@0);
    }];
    return cardImg;
}


@end
