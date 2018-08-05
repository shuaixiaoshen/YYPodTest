//
//  TabViewController.m
//  XiaoTest
//
//  Created by shen on 2018/6/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "TabViewController.h"
#import "HomeViewController.h"
#import "TradeViewController.h"
#import "MyViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (UINavigationController *)setUpWith:(NSString *)class{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:class];
    viewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    return naviVC;
}
- (void)setup{
    NSArray *classNames = @[@"HomeViewController",@"TradeViewController",@"MyViewController"];
    NSArray *titleNames = @[@"首页",@"订单",@"我的"];
    NSArray *imageName = @[@"index-ico_27",@"index-ico_29",@"index-ico_31"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < classNames.count; i++) {
        UINavigationController *naviVC = [self setUpWith:classNames[i]];
        naviVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleNames[i] image:[[UIImage imageNamed:imageName[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:[imageName[i] stringByAppendingString:@"2"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]] ;
        [naviVC setNavigationBarHidden:YES];
        [array addObject:naviVC];
    }
    self.viewControllers = array;
    self.tabBar.barTintColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
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
