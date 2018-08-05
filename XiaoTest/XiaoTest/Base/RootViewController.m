//
//  RootViewController.m
//  XiaoTest
//
//  Created by shen on 2018/6/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "RootViewController.h"


#import "TabViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

+ (RootViewController *)defaultManager{
    static RootViewController *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RootViewController alloc] init];
    });
    return manager;
}

- (UIViewController *)rootViewController{
    TabViewController *tabbarVc = [[TabViewController alloc] init];
    return tabbarVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
