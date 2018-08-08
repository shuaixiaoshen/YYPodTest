//
//  TradeHeaderView.m
//  XiaoTest
//
//  Created by shen on 2018/6/15.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "TradeHeaderView.h"

@implementation TradeHeaderView{
    TradeModel *currentModel;
}

- (void)configureModel:(TradeModel *)model{
    currentModel = model;
    [self removeAllView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImg = [[UIImageView alloc] init];
    headerImg.userInteractionEnabled = YES;
    [self.contentView addSubview:headerImg];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(@10);
        if (_type == 3) {
          make.bottom.mas_offset(@-5);
        }else{
          make.bottom.mas_offset(@-45);
        }
        make.right.mas_offset(@-10);
    }];
    UIImageView *stateImg = [[UIImageView alloc] init];
    [headerImg addSubview:stateImg];
    [stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_offset(@0);
        make.width.height.mas_offset(@70);
    }];
    UILabel *activeLab = [[UILabel alloc] initWithFrame:CGRectZero];
    activeLab.textAlignment = NSTextAlignmentLeft;
    activeLab.font = [UIFont systemFontOfSize:18];
    activeLab.textColor = [UIColor whiteColor];
    [headerImg addSubview:activeLab];
    if (![model.state isEqualToString:@"5"]) {
      activeLab.text = @"租";
    }
    [activeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@3);
        make.left.mas_offset(@3);
    }];
    UILabel *orderLab = [[UILabel alloc] initWithFrame:CGRectZero];
    orderLab.textAlignment = NSTextAlignmentLeft;
    orderLab.font = [UIFont systemFontOfSize:12];
    orderLab.textColor = [UIColor whiteColor];
    [headerImg addSubview:orderLab];
//    orderLab.text = @"订单号 123456789";
    [orderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@5);
        make.right.mas_offset(@-10);
    }];
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectZero];
    [headerImg addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@25);
        make.right.mas_offset(@-15);
        make.top.mas_offset(@50);
        make.height.mas_offset(@50);
    }];
    UILabel *moblieLab = [[UILabel alloc] initWithFrame:CGRectZero];
    moblieLab.textAlignment = NSTextAlignmentLeft;
    moblieLab.font = [UIFont boldSystemFontOfSize:16];
    moblieLab.textColor = [UIColor whiteColor];
    [detailView addSubview:moblieLab];
    moblieLab.text = currentModel.product_name;
    [moblieLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@0);
        make.left.mas_offset(@0);
    }];
    UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectZero];
    dateLab.textAlignment = NSTextAlignmentLeft;
    dateLab.font = [UIFont boldSystemFontOfSize:12];
    dateLab.textColor = [UIColor whiteColor];
    [detailView addSubview:dateLab];
    if (_type == 3) {
     dateLab.text = [NSString stringWithFormat:@"创建日期：%@",currentModel.crtdate];
    }else{
     dateLab.text = [NSString stringWithFormat:@"租赁日期：%@",currentModel.start_date];
    }
    
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moblieLab.mas_bottom).mas_offset(3);
        make.left.mas_offset(@0);
    }];
    UILabel *shenheLab = [[UILabel alloc] initWithFrame:CGRectZero];
    shenheLab.textAlignment = NSTextAlignmentLeft;
    shenheLab.font = [UIFont boldSystemFontOfSize:12];
    shenheLab.textColor = [UIColor whiteColor];
    [self addSubview:shenheLab];
    [shenheLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(@-45);
        make.left.mas_offset(@20);
    }];
    if (_type == 3) {
        if ([model.state isEqualToString:@"8"]) {
            UIButton *compulteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [compulteBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            [compulteBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [compulteBtn addTarget:self action:@selector(handlAliPay:) forControlEvents:UIControlEventTouchUpInside];
            compulteBtn.layer.cornerRadius = 5.0f;
            compulteBtn.layer.masksToBounds = YES;
            compulteBtn.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:compulteBtn];
            [compulteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(@-15);
                make.centerY.equalTo(shenheLab);
                make.width.mas_offset(@95);
            }];
        }
    }else{
        [self addDetailViewWith:headerImg andIndex:0];
        [self addDetailViewWith:headerImg andIndex:1];
        [self addDetailViewWith:headerImg andIndex:2];
    }
    if (_type == 1) {
         headerImg.image = [UIImage imageNamed:@"trade_normal"];
         stateImg.image = [UIImage imageNamed:@"trade_all"];
    }else if (_type == 2){
        if ([model.state isEqualToString:@"1"]) {
            headerImg.image = [UIImage imageNamed:@"trade_normal"];
        }else if ([model.state isEqualToString:@"2"]){
            headerImg.image = [UIImage imageNamed:@"trade_pass"];
        }else{
            headerImg.image = [UIImage imageNamed:@"trade_normal"];
        }
    }else{
        if ([model.state isEqualToString:@"4"]) {
            headerImg.image = [UIImage imageNamed:@"main_bg(2)"];
            stateImg.image = [UIImage imageNamed:@"trade_loading"];
            shenheLab.text = @"订单尚在审核中,请您耐心等待";
        }else if ([model.state isEqualToString:@"5"]){
            headerImg.image = [UIImage imageNamed:@"main_bg"];
            stateImg.image = [UIImage imageNamed:@"main_icon_auditrefusedto"];
            shenheLab.text = @"由于你的征信信用过低,我司拒绝您的此次申请";
        }else if ([model.state isEqualToString:@"8"]){
            headerImg.image = [UIImage imageNamed:@"main_bg(2)"];
            stateImg.image = [UIImage imageNamed:@"mian_icon_daizhifu"];
            shenheLab.text = @"待付意外保障服务费350元";
        }
    }
    if (_type == 3) {
        return;
    }
    UIView *footView = [[UIView alloc] init];
    [self.contentView addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.right.mas_offset(@0);
        make.top.equalTo(headerImg.mas_bottom);
        make.bottom.mas_offset(@0);
    }];
    UIImageView *activeImg = [[UIImageView alloc] init];
    [footView addSubview:activeImg];
    activeImg.image = [UIImage imageNamed:@"trade_edit"];
//    activeImg.contentMode = UIViewContentModeCenter;
    [activeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@13);
        make.centerY.equalTo(footView);
        make.height.mas_offset(@23);
        make.width.mas_offset(@23);
    }];
    UILabel *eidtLab = [[UILabel alloc] initWithFrame:CGRectZero];
    eidtLab.textAlignment = NSTextAlignmentLeft;
    eidtLab.font = [UIFont boldSystemFontOfSize:14];
    eidtLab.textColor = [UIColor darkTextColor];
    [footView addSubview:eidtLab];
    eidtLab.text = @"租赁缴纳记录";
    [eidtLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(activeImg);
        make.left.equalTo(activeImg.mas_right).mas_offset(3);
    }];
    UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [activeBtn setImage:[UIImage imageNamed:@"my_09"] forState:UIControlStateNormal];
    [footView addSubview:activeBtn];
    activeBtn.contentMode = UIViewContentModeCenter;
    [activeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@-13);
        make.centerY.equalTo(footView);
        make.width.mas_offset(50);
    }];
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = [UIColor grayColor];
    [footView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.height.mas_offset(@.5);
        make.left.mas_offset(@0);
        make.bottom.mas_offset(@0);
    }];
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:footBtn];
    [footBtn addTarget:self action:@selector(handleExtedCell:) forControlEvents:UIControlEventTouchUpInside];
    [footBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_offset(@0);
    }];
}

- (void)handleExtedCell:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleExtedCellWithCurrentSetion:)]) {
        [self.delegate handleExtedCellWithCurrentSetion:_setion];
    }
}

- (void)handlAliPay:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handlePayWithCurrentSetion:)]) {
        [self.delegate handlePayWithCurrentSetion:_setion];
    }
}


- (void)addDetailViewWith:(UIImageView *)headerImg andIndex:(NSInteger)index{
    NSArray *titleArr = @[@"本期租金(元)",@"逾期天数",@"逾期费率"];
    UIView *detailView = [[UIView alloc] init];
    [headerImg addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset((KscreenWidth - 20) / 3 * index);
        make.width.mas_offset((KscreenWidth - 20) / 3);
        make.height.mas_offset(@45);
        make.bottom.mas_offset(@-10);
    }];
    UILabel *moblieLab = [[UILabel alloc] initWithFrame:CGRectZero];
    moblieLab.textAlignment = NSTextAlignmentCenter;
    moblieLab.font = [UIFont boldSystemFontOfSize:12];
    moblieLab.textColor = [UIColor whiteColor];
    [detailView addSubview:moblieLab];
    moblieLab.text = titleArr[index];
    [moblieLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@0);
        make.centerX.equalTo(detailView);
    }];
    UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectZero];
    dateLab.textAlignment = NSTextAlignmentCenter;
    dateLab.font = [UIFont boldSystemFontOfSize:16];
    dateLab.textColor = [UIColor whiteColor];
    [detailView addSubview:dateLab];
    if (index == 0) {
      dateLab.text = currentModel.leaseterm_price;
    }else if (index == 1){
      dateLab.text = currentModel.expectday;
    }else{
        if (currentModel.product_rate.length < 1) {
            dateLab.text = @"0.03";
        }else{
            dateLab.text = currentModel.product_rate;
        }
      
    }
    
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(@0);
        make.centerX.equalTo(detailView);
    }];
    if (index != 2) {
        UILabel *lineLab = [[UILabel alloc] init];
        lineLab.backgroundColor = [UIColor whiteColor];
        [detailView addSubview:lineLab];
        [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(@0);
            make.width.mas_offset(@1);
            make.top.mas_offset(@5);
            make.bottom.mas_offset(@-5);
        }];
    }
}

- (void)removeAllView{
    for (UIView *aView in self.contentView.subviews) {
        [aView removeFromSuperview];
    }
}

@end
