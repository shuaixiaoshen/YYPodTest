//
//  TradeModel.h
//  XiaoTest
//
//  Created by shen on 2018/7/28.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeModel : NSObject

@property(assign, nonatomic) BOOL isExted;

@property(strong, nonatomic) NSString *product_name;
@property(strong, nonatomic) NSString *product_price;
@property(strong, nonatomic) NSString *product_rate;
@property(strong, nonatomic) NSString *leaseterm_price;
@property(strong, nonatomic) NSString *repaytotal;
@property(strong, nonatomic) NSString *repaydate;
@property(strong, nonatomic) NSString *start_date;
@property(strong, nonatomic) NSString *crtdate;
@property(strong, nonatomic) NSString *audit_date;
@property(strong, nonatomic) NSString *expectday;
@property(strong, nonatomic) NSString *state;
@property(strong, nonatomic) NSString *bid;
@property(strong, nonatomic) NSString *pid;
@property(strong, nonatomic) NSArray *paymentList;


@property(strong, nonatomic) NSString *his_curphase;
@property(strong, nonatomic) NSString *his_date;
@property(strong, nonatomic) NSString *his_pid;
@property(strong, nonatomic) NSString *his_realydate;
@property(strong, nonatomic) NSString *his_state;
@property(strong, nonatomic) NSString *his_state_name;
@property(strong, nonatomic) NSString *his_totalmoney;
@property(assign, nonatomic) NSInteger his_tottalCount;


@property(strong, nonatomic) NSString *book_no;
@property(strong, nonatomic) NSString *curphase;
@property(strong, nonatomic) NSString *realymoney;
@property(strong, nonatomic) NSString *date;



- (void)configureModelWithTradeDic:(NSDictionary *)dic;

- (void)configureModelWithHis_TradeDic:(NSDictionary *)dic;

- (void)configureModelWithMy_TradeDic:(NSDictionary *)dic;

@end
