//
//  OrderViewController.h
//  XiaoTest
//
//  Created by shen on 2018/7/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeDetailModel.h"

@interface OrderViewController : BaseViewController

@property(strong, nonatomic) HomeDetailModel *detailModel;

@property(strong, nonatomic) NSString *msg_id;

@property(strong, nonatomic) NSString *current_skuid;


@property(strong, nonatomic) NSString *current_color;
@property(strong, nonatomic) NSString *current_network;
@property(strong, nonatomic) NSString *current_memary;
@property(strong, nonatomic) NSString *current_time;

@end
