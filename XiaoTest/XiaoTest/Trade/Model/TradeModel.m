//
//  TradeModel.m
//  XiaoTest
//
//  Created by shen on 2018/7/28.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "TradeModel.h"

@implementation TradeModel

- (void)configureModelWithTradeDic:(NSDictionary *)dic{
    _product_name = [NSString stringWithFormat:@"%@",dic[@"product_name"]];
    _bid = [NSString stringWithFormat:@"%@",dic[@"bid"]];
    _pid = [NSString stringWithFormat:@"%@",dic[@"pid"]];
    _product_rate = [NSString stringWithFormat:@"%@",dic[@"product_rate"]];
    _product_price = [NSString stringWithFormat:@"%@",dic[@"product_price"]];
    _leaseterm_price = [NSString stringWithFormat:@"%@",dic[@"leaseterm_price"]];
    _repaytotal = [NSString stringWithFormat:@"%@",dic[@"repaytotal"]];
    _repaydate = [NSString stringWithFormat:@"%@",dic[@"repaydate"]];
    _start_date = [NSString stringWithFormat:@"%@",dic[@"start_date"]];
    _crtdate = [NSString stringWithFormat:@"%@",dic[@"crtdate"]];
    _audit_date = [NSString stringWithFormat:@"%@",dic[@"audit_date"]];
    _expectday = [NSString stringWithFormat:@"%@",dic[@"expectday"]];
    if (!_expectday || [_expectday isEqualToString:@""]) {
        _expectday = @"0天";
    }
    _state = [NSString stringWithFormat:@"%@",dic[@"state"]];
    _paymentList = dic[@"paymentList"];
    
}

- (void)configureModelWithHis_TradeDic:(NSDictionary *)dic{
    _his_curphase = [NSString stringWithFormat:@"%@",dic[@"curphase"]];
    _his_date = [NSString stringWithFormat:@"%@",dic[@"date"]];
    _his_pid = [NSString stringWithFormat:@"%@",dic[@"pid"]];
    _his_realydate = [NSString stringWithFormat:@"%@",dic[@"realydate"]];
    if (!_his_realydate || [_his_realydate isEqualToString:@""]) {
        _his_realydate = @"0天";
    }
    _his_state = [NSString stringWithFormat:@"%@",dic[@"state"]];
    
    _his_state_name = [NSString stringWithFormat:@"%@",dic[@"state_name"]];
    _his_totalmoney = [NSString stringWithFormat:@"%@",dic[@"totalmoney"]];
}

- (void)configureModelWithMy_TradeDic:(NSDictionary *)dic{
    _curphase = [NSString stringWithFormat:@"%@",dic[@"curphase"]];
    _book_no = [NSString stringWithFormat:@"%@",dic[@"book_no"]];
    _pid = [NSString stringWithFormat:@"%@",dic[@"pid"]];
    _date = [NSString stringWithFormat:@"%@",dic[@"date"]];
    _realymoney = [NSString stringWithFormat:@"%@",dic[@"realymoney"]];
}

@end
