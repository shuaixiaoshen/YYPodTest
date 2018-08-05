//
//  ChatViewController.m
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NaviBarView *naviBar = [[NaviBarView alloc] init];
    naviBar.title = @"客服";
    naviBar.isLine = YES;
    [self.view addSubview:naviBar];
    [self common];
    // Do any additional setup after loading the view.
}

- (void)common{
    UIImageView *alertImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_chat"]];
    alertImage.contentMode = UIViewContentModeCenter;
    [self.view addSubview:alertImage];
    [alertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_offset(@75);
        make.width.mas_offset(@70);
        make.height.mas_offset(@70);
    }];
    UILabel *alertLab = [[UILabel alloc] init];
    alertLab.text = @"您有任何问题,请致电";
    alertLab.font = [UIFont boldSystemFontOfSize:15];
    alertLab.textColor = [UIColor grayColor];
    [self.view addSubview:alertLab];
    [alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertImage.mas_bottom).mas_offset(0);
        make.centerX.equalTo(self.view);
    }];
    UILabel *alertLab1 = [[UILabel alloc] init];
    alertLab1.text = @"0512-68888888";
    alertLab1.font = [UIFont boldSystemFontOfSize:15];
    alertLab1.textColor = [UIColor orangeColor];
    [self.view addSubview:alertLab1];
    [alertLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertLab.mas_bottom).mas_offset(0);
        make.centerX.equalTo(self.view);
    }];
    UILabel *alertLab2 = [[UILabel alloc] init];
    alertLab2.text = @"客服人员会为您耐心解答";
    alertLab2.font = [UIFont boldSystemFontOfSize:15];
    alertLab2.textColor = [UIColor grayColor];
    [self.view addSubview:alertLab2];
    [alertLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertLab1.mas_bottom).mas_offset(0);
        make.centerX.equalTo(self.view);
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
