//
//  TradeHeaderView.h
//  XiaoTest
//
//  Created by shen on 2018/6/15.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeModel.h"

@protocol TradeHeaderViewProtocol <NSObject>

- (void)handleExtedCellWithCurrentSetion:(NSInteger)setion;

- (void)handlePayWithCurrentSetion:(NSInteger)setion;


@end


@interface TradeHeaderView : UITableViewHeaderFooterView

- (void)configureModel:(TradeModel *)model;

@property(assign, nonatomic) NSInteger setion;


@property(assign, nonatomic) NSInteger type;

@property(assign, nonatomic) id<TradeHeaderViewProtocol>delegate;
@end
