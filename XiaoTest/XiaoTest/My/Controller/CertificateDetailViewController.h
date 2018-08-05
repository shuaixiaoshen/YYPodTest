//
//  CertificateDetailViewController.h
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "BaseViewController.h"

@interface CertificateDetailViewController : BaseViewController

@property(assign, nonatomic) NSInteger sourceType;

@property(strong, nonatomic) NSDictionary *infoDic;

@property(assign, nonatomic) NSInteger code;

@end
