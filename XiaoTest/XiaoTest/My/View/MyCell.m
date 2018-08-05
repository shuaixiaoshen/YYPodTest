//
//  MyCell.m
//  XiaoTest
//
//  Created by shen on 2018/6/13.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell{
    NSArray *titleArrs;
    NSArray *imgArrs;
    UIView *cellView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)configureModelWithimgArr:(NSArray *)imgArr titleArr:(NSArray *)titleArr{
    self.backgroundColor = [UIColor clearColor];
    titleArrs = titleArr;
    imgArrs = imgArr;
    if (cellView) {
        [cellView removeFromSuperview];
        cellView =  nil;
    }
    cellView = [[UIView alloc] initWithFrame:CGRectZero];
    cellView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:cellView];
    cellView.layer.shadowColor = [UIColor grayColor].CGColor;
    cellView.layer.shadowOffset = CGSizeMake(0, 0);
    cellView.layer.cornerRadius = 5.0f;
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@10);
        make.right.mas_offset(@-10);
        make.top.mas_offset(@10);
        make.bottom.mas_offset(@0);
    }];
    for (NSInteger i = 0; i < titleArr.count; i++) {
        [self addTitleViewWithIndex:i];
    }
}

- (void)addTitleViewWithIndex:(NSInteger)index{
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectZero];
    [cellView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.mas_offset(index * 45);
        make.height.mas_offset(@45);
    }];
    UIImageView *headerImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [detailView addSubview:headerImg];
    headerImg.image = [UIImage imageNamed:imgArrs[index]];
    headerImg.contentMode = UIViewContentModeCenter;
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@15);
        make.width.height.mas_offset(@30);
        make.centerY.equalTo(detailView);
    }];
    UILabel *moblieLab = [[UILabel alloc] initWithFrame:CGRectZero];
    moblieLab.textAlignment = NSTextAlignmentLeft;
    moblieLab.font = [UIFont systemFontOfSize:13];
    moblieLab.textColor = [UIColor blackColor];
    [detailView addSubview:moblieLab];
    moblieLab.text = titleArrs[index];
    [moblieLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerImg);
        make.left.equalTo(headerImg.mas_right).mas_offset(10);
    }];
    UIImageView *activeImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [detailView addSubview:activeImg];
    activeImg.contentMode = UIViewContentModeCenter;
    activeImg.image = [UIImage imageNamed:@"my_09"];
    [activeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@-10);
        make.width.height.mas_offset(@30);
        make.centerY.equalTo(detailView);
    }];
//    UILabel *redLab = [[UILabel alloc] initWithFrame:CGRectZero];
//    redLab.textAlignment = NSTextAlignmentCenter;
//    redLab.backgroundColor = [UIColor redColor];
//    redLab.font = [UIFont systemFontOfSize:13];
//    redLab.textColor = [UIColor whiteColor];
//    [detailView addSubview:redLab];
//    [redLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(headerImg);
//        make.right.equalTo(activeImg.mas_left).mas_offset(10);
//        make.width.height.mas_offset(@15);
//    }];
//    redLab.layer.cornerRadius = 15 / 2;
//    redLab.layer.masksToBounds = YES;
    
    UIButton *seletedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seletedBtn.tag = 3333 + index;
    [detailView addSubview:seletedBtn];
    [seletedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(@0);
    }];
    [seletedBtn addTarget:self action:@selector(handleSeletedBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleSeletedBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleSeletedCell:)]) {
        [self.delegate handleSeletedCell:titleArrs[btn.tag - 3333]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
