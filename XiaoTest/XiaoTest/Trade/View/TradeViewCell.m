//
//  TradeViewCell.m
//  XiaoTest
//
//  Created by shen on 2018/6/18.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "TradeViewCell.h"

@implementation TradeViewCell{
    TradeModel *currentModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureModel:(TradeModel *)model{
    [self removeAllView];
    currentModel = model;
    UIView *headerView = [[UIView alloc] init];
    [self.contentView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(@0);
        make.height.mas_offset(@30);
    }];
    UIImageView *activeImg = [[UIImageView alloc] init];
    [headerView addSubview:activeImg];
    activeImg.image = [UIImage imageNamed:@"trade_jisuan"];
    activeImg.contentMode = UIViewContentModeCenter;
    [activeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@13);
        make.bottom.mas_offset(@0);
        make.top.mas_offset(@3);
        make.width.mas_offset(@30);
    }];
    UILabel *eidtLab = [[UILabel alloc] initWithFrame:CGRectZero];
    eidtLab.textAlignment = NSTextAlignmentLeft;
    eidtLab.font = [UIFont boldSystemFontOfSize:14];
    eidtLab.textColor = [UIColor darkTextColor];
    [headerView addSubview:eidtLab];
    eidtLab.text = [NSString stringWithFormat:@"%@/%ld期 >",model.his_curphase,(long)model.his_tottalCount];
    [eidtLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(activeImg);
        make.left.equalTo(activeImg.mas_right);
    }];
    UILabel *stateLab = [[UILabel alloc] init];
    stateLab.font = [UIFont systemFontOfSize:13];
    stateLab.textColor = [UIColor redColor];
    stateLab.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:stateLab];
    [stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@-30);
        make.centerY.equalTo(headerView);
    }];
    UIView *midView = [[UIView alloc] init];
    midView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.equalTo(headerView.mas_bottom);
        make.height.mas_offset(@60);
    }];
    UIImageView *productImg = [[UIImageView alloc] init];
    [midView addSubview:productImg];
    productImg.contentMode = UIViewContentModeCenter;
    productImg.image = [UIImage imageNamed:@"trade_banner"];
    [productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@10);
        make.top.mas_offset(@5);
        make.bottom.mas_offset(@5);
        make.width.mas_offset(@80);
    }];
    UILabel *moneryLab = [[UILabel alloc] init];
    [midView addSubview:moneryLab];
    moneryLab.text = @"本期应还";
    moneryLab.font = [UIFont systemFontOfSize:12];
    moneryLab.textColor = [UIColor grayColor];
    [moneryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(stateLab);
        make.top.mas_offset(@5);
        make.right.mas_offset(@-30);
    }];
    UILabel *moneryDetailLab = [[UILabel alloc] init];
    [midView addSubview:moneryDetailLab];
    moneryDetailLab.text = model.his_totalmoney;
    moneryDetailLab.font = [UIFont systemFontOfSize:16];
    [moneryDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(moneryLab);
        make.top.equalTo(moneryLab.mas_bottom).mas_offset(@5);
    }];
    UILabel *midLab = [[UILabel alloc] init];
    [midView addSubview:midLab];
    midLab.textColor = [UIColor darkTextColor];
    midLab.numberOfLines = 2;
    midLab.font = [UIFont systemFontOfSize:11];
    [midLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productImg.mas_right).mas_offset(3);
        make.centerY.equalTo(productImg);
    }];
    UIView *footView = [[UIView alloc] init];
    [self.contentView addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.right.mas_offset(@0);
        make.bottom.mas_offset(@0);
        make.top.equalTo(midView.mas_bottom);
    }];
    UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectZero];
    dateLab.textAlignment = NSTextAlignmentLeft;
    dateLab.font = [UIFont boldSystemFontOfSize:12];
    dateLab.textColor = [UIColor darkTextColor];
    [footView addSubview:dateLab];
    dateLab.text = [NSString stringWithFormat:@"应结算日：%@",model.his_date];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.left.mas_offset(@10);
    }];
    if (_type == 2) {
        if ([model.his_state isEqualToString:@"2"]) {
            stateLab.text = @"待还";
            midLab.text = @"本期账单待还";
        }else if([model.his_state isEqualToString:@"4"]){
            stateLab.text = @"尚未开始";
            midLab.text = @"当前账单尚未开始";
        }else{
            stateLab.text = @"尚未开始";
            midLab.text = @"当前账单尚未开始";
        }
    }else{
        stateLab.text = @"已完成";
        midLab.text = @"本期账单已结清";
    }
    
    if (_type == 2 && [model.his_state isEqualToString:@"2"]) {
        UIImageView *btnImg = [[UIImageView alloc] init];
        [footView addSubview:btnImg];
        btnImg.userInteractionEnabled = YES;
        btnImg.image = [UIImage imageNamed:@"trade_board"];
        btnImg.contentMode = UIViewContentModeCenter;
        [btnImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(moneryLab);
            make.centerY.equalTo(footView);
            make.height.mas_offset(@25);
            make.width.mas_offset(@58);
        }];
        UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [activeBtn setTitle:@"结清" forState:UIControlStateNormal];
        [activeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btnImg addSubview:activeBtn];
        activeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [activeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_offset(@0);
        }];
        [activeBtn addTarget:self action:@selector(handlePayoutBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)handlePayoutBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handlePayOutMoneyBtnWithModel:)]) {
        [self.delegate handlePayOutMoneyBtnWithModel:currentModel];
    }
}


- (void)removeAllView{
    for (UIView *aView in self.contentView.subviews) {
        [aView removeFromSuperview];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
