//
//  HomeModel.h
//  XiaoTest
//
//  Created by shen on 2018/7/22.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

/**
 每期价格
 */
@property(strong, nonatomic) NSString *eachprice;

/**
 租期数组
 */
@property(strong, nonatomic) NSArray *leasetermArray;

/**
 租期单位
 */
@property(strong, nonatomic) NSString *leaseunit;

/**
 租期名称
 */
@property(strong, nonatomic) NSString *leaseunitname;


/**
 详情页图
 */
@property(strong, nonatomic) NSString *product_detimg;

/**
 产品id
 */
@property(strong, nonatomic) NSString *product_id;

/**
 产品图片地址
 */
@property(strong, nonatomic) NSString *product_img;

/**
 租期
 */
@property(strong, nonatomic) NSString *product_leaseterm;

/**
 产品名字
 */
@property(strong, nonatomic) NSString *product_name;
/**
 产品价格
 */
@property(strong, nonatomic) NSString *product_price;


- (void)configureHomeModelWithDictionary:(NSDictionary *)dic;

@end
