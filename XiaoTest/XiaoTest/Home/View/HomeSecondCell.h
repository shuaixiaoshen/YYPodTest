//
//  HomeSecondCell.h
//  XiaoTest
//
//  Created by shen on 2018/7/9.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "UIImageView+WebCache.h"

@interface HomeSecondCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *banner;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

- (void)configureModel:(HomeModel *)model;

@end
