//
//  HomeModel.m
//  XiaoTest
//
//  Created by shen on 2018/7/22.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (void)configureHomeModelWithDictionary:(NSDictionary *)dic{
    _eachprice = [NSString stringWithFormat:@"%@",dic[@"eachprice"]];
    _leasetermArray = dic[@"leasetermArray"];
    _leaseunit = [NSString stringWithFormat:@"%@",dic[@"leaseunit"]];
    _leaseunitname = [NSString stringWithFormat:@"%@",dic[@"leaseunitname"]];
    _product_detimg = [NSString stringWithFormat:@"%@",dic[@"product_detimg"]];
    _product_id = [NSString stringWithFormat:@"%@",dic[@"product_id"]];
    _product_img = [NSString stringWithFormat:@"%@",dic[@"product_img"]];
    _product_leaseterm = [NSString stringWithFormat:@"%@",dic[@"product_leaseterm"]];
    _product_name = [NSString stringWithFormat:@"%@",dic[@"product_name"]];
    _product_price = [NSString stringWithFormat:@"%@",dic[@"product_price"]];
}

@end
