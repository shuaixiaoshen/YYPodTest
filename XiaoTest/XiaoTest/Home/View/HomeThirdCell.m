//
//  HomeThirdCell.m
//  XiaoTest
//
//  Created by shen on 2018/7/9.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "HomeThirdCell.h"

@implementation HomeThirdCell

- (void)configureModel:(HomeModel *)model{
    [_banner sd_setImageWithURL:[NSURL URLWithString:model.product_img] placeholderImage:[UIImage imageNamed:@"iphone 8"]];
    _namelab.text = model.product_name;
    _priceLab.text = [NSString stringWithFormat:@"￥%@/月起",model.eachprice];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
