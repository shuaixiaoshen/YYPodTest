//
//  HomeDetailModel.h
//  XiaoTest
//
//  Created by shen on 2018/7/28.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDetailModel : NSObject

@property(strong, nonatomic) NSArray *memoryArr;
@property(strong, nonatomic) NSArray *colorArr;
@property(strong, nonatomic) NSArray *dateArr;
@property(strong, nonatomic) NSArray *networkArr;
@property(strong, nonatomic) NSArray *priceArr;
@property(strong, nonatomic) NSString *product_detimg;
@property(strong, nonatomic) NSString *product_id;
@property(strong, nonatomic) NSString *product_leaseterm;
@property(strong, nonatomic) NSString *product_name;
@property(strong, nonatomic) NSString *product_price;

@property(strong, nonatomic) NSArray *leasetermArray;

-(void)configureModleWithDic:(NSDictionary *)dic;

@end
