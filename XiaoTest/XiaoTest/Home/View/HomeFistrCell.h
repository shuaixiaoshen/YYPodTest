//
//  HomeFistrCell.h
//  XiaoTest
//
//  Created by shen on 2018/7/9.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "UIImageView+WebCache.h"

@interface HomeFistrCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@property (weak, nonatomic) IBOutlet UIImageView *banner;

- (void)configureModel:(HomeModel *)model;

@end
