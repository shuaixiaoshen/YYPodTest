//
//  FriendeView.m
//  XiaoTest
//
//  Created by shen on 2018/7/28.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "FriendeView.h"

@implementation FriendeView{
    UIScrollView *scrollView;
    UIView *baseView;
    NSArray *fieldTestArr;
}

+ (FriendeView *)friendeAddSubView:(UIView *)subView{
    FriendeView *friend = [[FriendeView alloc] init];
    [subView addSubview:friend];
    return friend;
}
- (NSString *)tranfromWithKey:(NSString *)key{
    return [NSString stringWithFormat:@"%@",_infodic[key]];
}
- (void)startSetUp{
    if (_infodic) {
       fieldTestArr = @[[self tranfromWithKey:@"family_linkone_name"],[self tranfromWithKey:@"family_linkone_sex"],[self tranfromWithKey:@"family_linkone_phone"],[self tranfromWithKey:@"family_linkone_relation"],[self tranfromWithKey:@"family_linkone_address"],[self tranfromWithKey:@"family_linktwo_name"],[self tranfromWithKey:@"family_linktwo_sex"],[self tranfromWithKey:@"family_linktwo_phone"],[self tranfromWithKey:@"family_linktwo_relation"],[self tranfromWithKey:@"family_linktwo_address"]];
    }else{
        fieldTestArr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    scrollView.contentSize = CGSizeMake(KscreenWidth, 800);
    scrollView.delegate = self;
    [self addSubview:scrollView];
    baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, scrollView.contentSize.height)];
    [scrollView addSubview:baseView];
    UIView *headerView = [[UIView alloc] init];
    [baseView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(@0);
        make.height.mas_offset(@30);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.bottom.mas_offset(@0);
        make.height.mas_offset(@1);
    }];
    UILabel *friend1Lab = [[UILabel alloc] init];
    friend1Lab.textColor = [UIColor blackColor];
    friend1Lab.text = @"亲属 1";
    friend1Lab.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:friend1Lab];
    [friend1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@15);
        make.centerY.equalTo(headerView);
    }];
    UIImageView *active1Lab = [[UIImageView alloc] init];
    active1Lab.image = [UIImage imageNamed:@"updown"];
    [headerView addSubview:active1Lab];
    [active1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@-15);
        make.width.mas_offset(@20);
        make.height.mas_offset(@20);
        make.centerY.equalTo(headerView);
    }];
    UIView *namelab = [self addBottomViewWithView:headerView title:@"姓名" aIndex:0];
    UIView *sexlab = [self addBottomViewWithView:namelab title:@"性别" aIndex:1];
    UIView *minlab = [self addBottomViewWithView:sexlab title:@"手机号" aIndex:2];
    UIView *chulab = [self addBottomViewWithView:minlab title:@"关系" aIndex:3];
    UIView *addresslab = [self addBottomViewWithView:chulab title:@"现居地址" aIndex:4];
    
    UIView *headerView2 = [[UIView alloc] init];
    [baseView addSubview:headerView2];
    [headerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.equalTo(addresslab.mas_bottom).mas_offset(@50);
        make.height.mas_offset(@30);
    }];
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = [UIColor grayColor];
    [headerView2 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.bottom.mas_offset(@0);
        make.height.mas_offset(@1);
    }];
    UILabel *friend2Lab = [[UILabel alloc] init];
    friend2Lab.text = @"亲属 2";
    friend2Lab.textColor = [UIColor blackColor];
    friend2Lab.font = [UIFont systemFontOfSize:15];
    [headerView2 addSubview:friend2Lab];
    [friend2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@15);
        make.centerY.equalTo(headerView2);
    }];
    UIImageView *active2Lab = [[UIImageView alloc] init];
    active2Lab.image = [UIImage imageNamed:@"updown"];
    [headerView addSubview:active2Lab];
    [active2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@-15);
        make.width.mas_offset(@20);
        make.height.mas_offset(@20);
        make.centerY.equalTo(headerView2);
    }];
    UIView *namelab2 = [self addBottomViewWithView:headerView2 title:@"姓名" aIndex:5];
    UIView *sexlab2 = [self addBottomViewWithView:namelab2 title:@"性别" aIndex:6];
    UIView *minlab2 = [self addBottomViewWithView:sexlab2 title:@"手机号" aIndex:7];
    UIView *chulab2 = [self addBottomViewWithView:minlab2 title:@"关系" aIndex:8];
    UIView *addresslab2 = [self addBottomViewWithView:chulab2 title:@"现居地址" aIndex:9];
    if (_code != 10) {
        UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        requestBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
        requestBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [requestBtn setTitle:@"保存" forState:UIControlStateNormal];
        [scrollView addSubview:requestBtn];
        [requestBtn addTarget:self action:@selector(handleRequestBtn:) forControlEvents:UIControlEventTouchUpInside];
        [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@35);
            make.left.mas_offset(@40);
            make.width.mas_offset(KscreenWidth - 80);
            make.top.equalTo(addresslab2.mas_bottom).mas_offset(35);
        }];
    }
}

- (UIView *)addBottomViewWithView:(UIView *)aView title:(NSString *)aTitle aIndex:(NSInteger)index{
    UIView *nameView = [[UIView alloc] init];
    [baseView addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.mas_bottom);
        make.left.mas_offset(@0);
        make.width.mas_offset(KscreenWidth);
        make.height.mas_offset(@40);
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
        make.left.mas_offset(@15);
        make.centerY.equalTo(nameView);
    }];
    nameLab.tag = 3333 + index;
    UITextField *nameField = [[UITextField alloc] init];
    [nameView addSubview:nameField];
    nameField.text = fieldTestArr[index];
    nameField.textAlignment = NSTextAlignmentRight;
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLab);
        make.right.mas_offset(@-15);
        make.width.mas_offset(KscreenWidth - 100);
    }];
    nameField.tag = 6666 + index;
    return nameView;
}


- (void)handleRequestBtn:(UIButton *)btn{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *nameArr;
    NSArray *keyArr;
    nameArr = @[@"姓名",@"性别",@"手机号",@"关系",@"现居地址",@"姓名",@"性别",@"手机号",@"关系",@"现居地址"];
    keyArr = @[@"family_linkone_name",@"family_linkone_sex",@"family_linkone_phone",@"family_linkone_relation",@"family_linkone_address",@"family_linktwo_name",@"family_linktwo_sex",@"family_linktwo_phone",@"family_linktwo_relation",@"family_linktwo_address"];
    for (int i = 0; i < 10; i++) {
        UITextField *textField = [scrollView viewWithTag:6666 + i];
        if (textField.text.length > 0) {
            [dic setObject:textField.text forKey:keyArr[i]];
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(showAlertTitle:)]) {
                [self.delegate showAlertTitle:[NSString stringWithFormat:@"请填写 %@",nameArr[i]]];
            }
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleSaveFriendeInfoWithDic:)]) {
        [self.delegate handleSaveFriendeInfoWithDic:dic];
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
}

@end
