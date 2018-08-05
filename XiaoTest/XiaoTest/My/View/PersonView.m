//
//  PersonView.m
//  XiaoTest
//
//  Created by shen on 2018/7/14.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "PersonView.h"

@implementation PersonView{
    UIScrollView *scrollView;
    UIView *baseView;
    UIButton *falseBtn;
    UIButton *requestBtn;
    UIButton *okBtn;
    UIView *workView;
    UIView *aliPayView;
    BOOL isStudent;
    NSArray *fieldTestArr;
}

+ (PersonView *)personAddSubView:(UIView *)subView{
    PersonView *person = [[PersonView alloc] init];
    [subView addSubview:person];
    return person;
}

- (NSString *)tranfromWithKey:(NSString *)key{
    return [NSString stringWithFormat:@"%@",_infodic[key]];
}

- (void)startSetUp{
    if (_infodic) {
        NSString *type = [NSString stringWithFormat:@"%@",_infodic[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _isStu = NO;
            isStudent = NO;
            fieldTestArr = @[[self tranfromWithKey:@"sex"],[self tranfromWithKey:@"ethnic"],[self tranfromWithKey:@"birthday"],[self tranfromWithKey:@"nativeplace"],[self tranfromWithKey:@"koseki"],[self tranfromWithKey:@"nowaddress"],[self tranfromWithKey:@"company"],[self tranfromWithKey:@"income"],[self tranfromWithKey:@"consume"],[self tranfromWithKey:@"bankcard"],[self tranfromWithKey:@"bankaddress"],@""];
        }else{
            _isStu = YES;
            isStudent = YES;
            fieldTestArr = @[[self tranfromWithKey:@"sex"],[self tranfromWithKey:@"ethnic"],[self tranfromWithKey:@"birthday"],[self tranfromWithKey:@"nativeplace"],[self tranfromWithKey:@"koseki"],[self tranfromWithKey:@"nowaddress"],[self tranfromWithKey:@"indatestring"],[self tranfromWithKey:@"school"],[self tranfromWithKey:@"studentcard"],[self tranfromWithKey:@"bankcard"],[self tranfromWithKey:@"bankaddress"],@""];
        }
    }else{
        _isStu = YES;
        isStudent = YES;
        fieldTestArr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    scrollView.contentSize = CGSizeMake(KscreenWidth, 800 + 90);
    scrollView.delegate = self;
    [self addSubview:scrollView];
    baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 800 + 90)];
    [scrollView addSubview:baseView];
    UIView *studentView = [[UIView alloc] init];
    [baseView addSubview:studentView];
    [studentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.width.mas_offset(KscreenWidth);
        make.top.mas_offset(@0);
        make.height.mas_offset(@40);
    }];
    UILabel *stulab = [[UILabel alloc] init];
    stulab.text = @"学生";
    stulab.font = [UIFont systemFontOfSize:14];
    [studentView addSubview:stulab];
    [stulab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@20);
        make.centerY.equalTo(studentView);
    }];
    okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [studentView addSubview:okBtn];
    [okBtn setTitle:@"是" forState:UIControlStateNormal];
    if (isStudent) {
      [okBtn setImage:[UIImage imageNamed:@"person_Stu"] forState:UIControlStateNormal];
    }else{
         [okBtn setImage:[UIImage imageNamed:@"person_noStu"] forState:UIControlStateNormal];
    }
   
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(handleTouchOkOrFalst:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stulab.mas_right).mas_offset(@50);
        make.width.mas_offset(@70);
        make.centerY.equalTo(stulab);
    }];
    falseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [studentView addSubview:falseBtn];
    [falseBtn setTitle:@"否" forState:UIControlStateNormal];
    [falseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (isStudent) {
      [falseBtn setImage:[UIImage imageNamed:@"person_noStu"] forState:UIControlStateNormal];
    }else{
      [falseBtn setImage:[UIImage imageNamed:@"person_Stu"] forState:UIControlStateNormal];
    }
    
    [falseBtn addTarget:self action:@selector(handleTouchOkOrFalst:) forControlEvents:UIControlEventTouchUpInside];
    [falseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(okBtn.mas_right).mas_offset(@50);
        make.width.mas_offset(@70);
        make.centerY.equalTo(stulab);
        
    }];
    UIView *sexlab = [self addBottomViewWithView:studentView title:@"性别" aIndex:1];
    UIView *minlab = [self addBottomViewWithView:sexlab title:@"民族" aIndex:2];
    UIView *chulab = [self addBottomViewWithView:minlab title:@"出生年月" aIndex:3];
    UIView *rulab = [self addBottomViewWithView:chulab title:@"籍贯" aIndex:4];
    UIView *suolab = [self addBottomViewWithView:rulab title:@"户籍地" aIndex:5];
    UIView *xuelab = [self addBottomViewWithView:suolab title:@"居住地址" aIndex:6];
    UIView *yinlab = [self addBottomViewWithView:xuelab title:@"入校时间" aIndex:7];
    UIView *ziLab = [self addBottomViewWithView:yinlab title:@"所在院校" aIndex:8];
    UIView *stuDetView = [self addBottomViewWithView:ziLab title:@"学生证编号" aIndex:9];
    UIView *stuNumView = [self addBottomViewWithView:stuDetView title:@"银行卡号" aIndex:10];
    UIView *cardView = [self addBottomViewWithView:stuNumView title:@"银行卡开户行" aIndex:11];
    UIView *cardDetaiView = [self addBottomViewWithView:cardView title:@"联系邮箱" aIndex:12];
    workView = [self addImgBtnWithType:1 andView:cardDetaiView];
    if (_code != 10) {
        requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        requestBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
        requestBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [requestBtn setTitle:@"保存" forState:UIControlStateNormal];
        [scrollView addSubview:requestBtn];
        [requestBtn addTarget:self action:@selector(handleRequestBtn:) forControlEvents:UIControlEventTouchUpInside];
        [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@35);
            make.left.mas_offset(@40);
            make.width.mas_offset(KscreenWidth - 80);
            make.top.equalTo(workView.mas_bottom).mas_offset(100);
        }];
    }
}

- (UIView *)addImgBtnWithType:(NSInteger)type andView:(UIView *)aView{
    UIView *imgView = [[UIView alloc] init];
    [baseView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.mas_bottom).mas_offset(5);
        make.left.mas_offset(@0);
        make.width.mas_offset(KscreenWidth);
        make.height.mas_offset(@75);
    }];
    UILabel *nameLab = [[UILabel alloc] init];
    if (type == 1) {
       nameLab.text = @"芝麻分视频";
    }else{
       nameLab.text = @"工作证";
    }
    nameLab.font = [UIFont systemFontOfSize:14];
    [imgView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@20);
        make.top.mas_offset(@0);
    }];
    UIView *pciView = [[UIView alloc] init];
    [imgView addSubview:pciView];
    [pciView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@0);
        make.centerX.equalTo(imgView).mas_offset(@20);
        make.width.mas_offset(@140);
        make.height.mas_offset(@75);
    }];
    pciView.layer.borderColor = [UIColor grayColor].CGColor;
    pciView.layer.borderWidth = 1.0f;
    UIImageView *picImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card_carmer"]];
    picImg.tag = 5555 + type;
    [pciView addSubview:picImg];
    [picImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(pciView);
        make.width.mas_offset(@140);
        make.height.mas_offset(@75);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [pciView addSubview:btn];
    btn.tag = 6666 + type;
    [btn addTarget:self action:@selector(handlePushImg:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(@0);
    }];
    return imgView;
}

- (void)handlePushImg:(UIButton *)btn{
    UIImageView *img = [baseView viewWithTag:btn.tag - 1111];
    if (img.tag == 5556) {
        _img1 = img;
    }else{
        _img2 = img;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(handlePushUserPhotoWithImg:)]) {
        [self.delegate handlePushUserPhotoWithImg:img];
    }
}

- (void)handleRequestBtn:(UIButton *)btn{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *nameArr;
    NSArray *keyArr;
    if (isStudent) {
        [dic setObject:@"2" forKey:@"type"];
        nameArr = @[@"性别",@"民族",@"出生年月",@"籍贯",@"户籍地",@"居住地址",@"入校时间",@"所在院校",@"学生证编号",@"银行卡号",@"银行卡开户行",@"联系邮箱"];
        keyArr = @[@"sex",@"ethnic",@"birthday",@"nativeplace",@"koseki",@"nowaddress",@"indatestring",@"school",@"studentcard",@"bankcard",@"bankaddress"];
    }else{
        [dic setObject:@"1" forKey:@"type"];
        nameArr = @[@"性别",@"民族",@"出生年月",@"籍贯",@"户籍地",@"居住地址",@"公司地址",@"月收入",@"月消费",@"银行卡号",@"银行卡开户行",@"联系邮箱"];
        keyArr = @[@"sex",@"ethnic",@"birthday",@"nativeplace",@"koseki",@"nowaddress",@"company",@"income",@"consume",@"bankcard",@"bankaddress"];
    }
    
    for (int i = 0; i < keyArr.count; i++) {
        UITextField *textField = [baseView viewWithTag:6667 + i];
        if (textField.text.length > 0) {
            [dic setObject:textField.text forKey:keyArr[i]];
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(showAlertTitle:)]) {
                [self.delegate showAlertTitle:[NSString stringWithFormat:@"请填写 %@",nameArr[i]]];
                return;
            }
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleSaveUserInfoWithDic:)]) {
        [self.delegate handleSaveUserInfoWithDic:dic];
    }
}

-(void)handleTouchOkOrFalst:(UIButton *)btn{
    NSArray *titleArr;
    if ([btn.titleLabel.text isEqualToString:@"是"]) {
        titleArr = @[@"入校时间",@"所在院校",@"学生证编号"];
        [okBtn setImage:[UIImage imageNamed:@"person_Stu"] forState:UIControlStateNormal];
        [falseBtn setImage:[UIImage imageNamed:@"person_noStu"] forState:UIControlStateNormal];
        isStudent = YES;
        _isStu = YES;
        if (aliPayView) {
            [aliPayView removeFromSuperview];
            aliPayView = nil;
        }
    }else{
        titleArr = @[@"公司地址",@"月收入",@"月消费"];
        [okBtn setImage:[UIImage imageNamed:@"person_noStu"] forState:UIControlStateNormal];
        [falseBtn setImage:[UIImage imageNamed:@"person_Stu"] forState:UIControlStateNormal];
        isStudent = NO;
        _isStu = NO;
        aliPayView = [self addImgBtnWithType:2 andView:workView];
    }
    for (int i= 0; i < 3; i++) {
        UILabel *lab = [scrollView viewWithTag:3340 + i];
        lab.text = titleArr[i];
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
        make.left.mas_offset(@20);
        make.centerY.equalTo(nameView);
    }];
    nameLab.tag = 3333 + index;
    UITextField *nameField = [[UITextField alloc] init];
    [nameView addSubview:nameField];
    nameField.text = fieldTestArr[index - 1];
    nameField.textAlignment = NSTextAlignmentRight;
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLab);
        make.right.mas_offset(@-15);
        make.width.mas_offset(KscreenWidth - 100);
    }];
    nameField.tag = 6666 + index;
    return nameView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
}


@end
