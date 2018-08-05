//
//  WebViewController.m
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property(strong, nonatomic) UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NaviBarView *naviBar = [[NaviBarView alloc] init];
    naviBar.title = @"协议";
    naviBar.isLine = YES;
    [self.view addSubview:naviBar];
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_webView];
    NSURL *url = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30];
    [_webView loadRequest:request];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_offset(@0);
        make.top.equalTo(naviBar.mas_bottom);
    }];
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
