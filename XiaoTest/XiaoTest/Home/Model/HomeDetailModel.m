//
//  HomeDetailModel.m
//  XiaoTest
//
//  Created by shen on 2018/7/28.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "HomeDetailModel.h"

@implementation HomeDetailModel


- (void)configureModleWithDic:(NSDictionary *)dic{
    _product_detimg = [NSString stringWithFormat:@"%@",dic[@"product_detimg"]];
    _product_id = [NSString stringWithFormat:@"%@",dic[@"product_id"]];
    _product_leaseterm = [NSString stringWithFormat:@"%@",dic[@"product_leaseterm"]];
    _product_name = [NSString stringWithFormat:@"%@",dic[@"product_name"]];
    _priceArr = dic[@"prodPrices"];
    _leasetermArray = dic[@"leasetermArray"];
    NSArray *listArr = dic[@"propList"];

    for (int i = 0; i < listArr.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *listDic = listArr[i];
        NSArray *listArr = listDic[@"prodPropValList"];
        NSString *prop_name = listDic[@"prop_name"];
        for (NSDictionary *detailDic in listArr) {
            [arr addObject:detailDic[@"prop_val"]];
        }
        if ([prop_name containsString:@"颜色"]) {
            _colorArr = [NSArray arrayWithArray:arr];
        }else if ([prop_name containsString:@"内存"]){
            _memoryArr = [NSArray arrayWithArray:arr];
        }else if ([prop_name containsString:@"租期"]){
            _dateArr = [NSArray arrayWithArray:arr];
        }else{
            _networkArr = [NSArray arrayWithArray:arr];
        }
    }
}

@end
