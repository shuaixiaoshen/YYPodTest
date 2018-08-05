//
//  PayViewController.m
//  XiaoTest
//
//  Created by shen on 2018/7/26.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "PayViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NaviBarView *naviBar = [[NaviBarView alloc] init];
    naviBar.title = @"费用详情";
    naviBar.isLine = YES;
    [self.view addSubview:naviBar];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(naviBar.mas_bottom).mas_offset(@20);
        make.height.mas_offset(@70);
        make.left.right.mas_offset(@0);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"本期应还";
    titleLab.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@0);
        make.centerX.equalTo(headerView);
    }];
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.text = _model.his_totalmoney;
    priceLab.font = [UIFont systemFontOfSize:18];
    [headerView addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(@0);
        make.centerX.equalTo(headerView);
    }];
    [self addMidviewWith:headerView];
    // Do any additional setup after loading the view.
}

- (void)addMidviewWith:(UIView *)aView{
    UIView *baseView = self.view;
    UIView *midView = [[UIView alloc] init];
    [baseView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.mas_bottom).mas_offset(35);
        make.bottom.mas_offset(@0);
        make.left.mas_offset(@20);
        make.right.mas_offset(@-20);
    }];
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"当前租期";
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = [UIColor grayColor];
    [midView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.mas_offset(@0);
    }];
    UILabel *nameDetailLab = [[UILabel alloc] init];
    nameDetailLab.text = [NSString stringWithFormat:@"第%@期",_model.his_curphase];
    nameDetailLab.font = [UIFont systemFontOfSize:14];
    nameDetailLab.textColor = [UIColor grayColor];
    [midView addSubview:nameDetailLab];
    [nameDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(nameLab);
    }];
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.text = @"基本租金";
    timeLab.textColor = [UIColor grayColor];
    timeLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(nameLab.mas_bottom).mas_offset(14);
    }];
    UILabel *timeDetailLab = [[UILabel alloc] init];
    timeDetailLab.text = _model.his_totalmoney;
    timeDetailLab.textColor = [UIColor grayColor];
    timeDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:timeDetailLab];
    [timeDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(timeLab);
    }];
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.text = @"本期逾期金";
    priceLab.textColor = [UIColor grayColor];
    priceLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(timeLab.mas_bottom).mas_offset(14);
    }];
    UILabel *priceDetailLab = [[UILabel alloc] init];
    priceDetailLab.text = [NSString stringWithFormat:@"%.f",[_model.his_realydate doubleValue] * 0.03 * [_model.his_totalmoney doubleValue]];
    priceDetailLab.textColor = [UIColor grayColor];
    priceDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:priceDetailLab];
    [priceDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(priceLab);
    }];
    
    UILabel *imeuLab = [[UILabel alloc] init];
    imeuLab.text = @"本期逾期天数";
    imeuLab.textColor = [UIColor grayColor];
    imeuLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:imeuLab];
    [imeuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(priceLab.mas_bottom).mas_offset(45);
    }];
    UILabel *imeuDetailLab = [[UILabel alloc] init];
    imeuDetailLab.text = _model.his_realydate;
    imeuDetailLab.textColor = [UIColor grayColor];
    imeuDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:imeuDetailLab];
    [imeuDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(imeuLab);
    }];
    UILabel *meryLab = [[UILabel alloc] init];
    meryLab.text = @"最后结算日期";
    meryLab.textColor = [UIColor grayColor];
    meryLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:meryLab];
    [meryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(imeuLab.mas_bottom).mas_offset(14);
    }];
    UILabel *meryDetailLab = [[UILabel alloc] init];
    meryDetailLab.text = _model.his_date;
    meryDetailLab.textColor = [UIColor grayColor];
    meryDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:meryDetailLab];
    [meryDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(meryLab);
    }];
    UILabel *peiLab = [[UILabel alloc] init];
    peiLab.text = @"实际结清日期";
    peiLab.textColor = [UIColor grayColor];
    peiLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:peiLab];
    [peiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(meryLab.mas_bottom).mas_offset(14);
    }];
    UILabel *peiDetailLab = [[UILabel alloc] init];
    peiDetailLab.text = @"---";
    peiDetailLab.textColor = [UIColor grayColor];
    peiDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:peiDetailLab];
    [peiDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(peiLab);
    }];
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [payBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [baseView addSubview:payBtn];
    [payBtn addTarget:self action:@selector(handleRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@45);
        make.width.mas_offset(@125);
        make.right.mas_offset(@0);
        make.bottom.mas_offset(@0);
    }];
    UILabel *paylLab = [[UILabel alloc] init];
    paylLab.text = [NSString stringWithFormat:@"支付: %@",_model.his_totalmoney];
    paylLab.textColor = [UIColor grayColor];
    paylLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:paylLab];
    [paylLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.centerY.equalTo(payBtn);
    }];
}

- (void)handleRequestBtn{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_model.bid forKey:@"bid"];
    if (!_model.pid) {
      [dic setObject:@"" forKey:@"pid"];
    }else{
        [dic setObject:_model.bid forKey:@"pid"];
    }
    
    [self postWithURLString:[NSString stringWithFormat:@"%@/book/getAliPaySign",KBaseUrl] parameters:dic success:^(id _Nullable data) {
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [[AlipaySDK defaultService] payOrder:data[@"data"] fromScheme:@"xiaoxiangzu" callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];
        }
    } failure:^(NSString * _Nullable error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
