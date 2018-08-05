//
//  TradeViewCell.h
//  XiaoTest
//
//  Created by shen on 2018/6/18.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeModel.h"
@protocol TradeViewProtocol<NSObject>

- (void)handlePayOutMoneyBtnWithModel:(TradeModel *)model;

@end

@interface TradeViewCell : UITableViewCell

- (void)configureModel:(TradeModel *)model;

@property(assign, nonatomic) id<TradeViewProtocol>delegate;
@property(assign, nonatomic) NSInteger type;

@end
