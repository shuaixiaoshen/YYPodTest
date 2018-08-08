//
//  SettingViewController.m
//  XiaoTest
//
//  Created by shen on 2018/6/24.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "SettingViewController.h"
#import "WebViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;

@end

@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NaviBarView *naviBar = [[NaviBarView alloc] init];
    naviBar.title = @"设置";
    [self.view addSubview:naviBar];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(@0);
        make.top.mas_offset(@64);
    }];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 20)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    NSArray *titleArr;
    if (indexPath.section == 0) {
        titleArr =@[@"还款管理协议",@"用户注册协议"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1){
        titleArr =@[@"征信查询授权书",@"笑享租租赁协议"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        titleArr = @[@"版本号"];
        UILabel *versionLab = [[UILabel alloc] init];
        [cell.contentView addSubview:versionLab];
        versionLab.font = [UIFont systemFontOfSize:13];
        versionLab.textColor = [UIColor grayColor];
        versionLab.text = @"1.0.0";
        [versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(@-15);
            make.centerY.equalTo(cell.contentView);
        }];
    }
    cell.textLabel.text = titleArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 2) {
        return 0;
    }
    return 170;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return [[UIView alloc] init];
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 170)];
        UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        requestBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
        requestBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [requestBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [view addSubview:requestBtn];
        [requestBtn addTarget:self action:@selector(handleRequestBtn) forControlEvents:UIControlEventTouchUpInside];
        [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@35);
            make.left.mas_offset(@40);
            make.right.mas_offset(@-40);
            make.bottom.mas_offset(@-20);
        }];
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *webVc = [[WebViewController alloc] init];
    webVc.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            webVc.webUrl = [NSString stringWithFormat:@"%@/paymanage.html",KBaseUrl];
            [self.navigationController pushViewController:webVc animated:YES];
        }else{
            webVc.webUrl = [NSString stringWithFormat:@"%@/login.html",KBaseUrl];
            [self.navigationController pushViewController:webVc animated:YES];
        }
       
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            webVc.webUrl = [NSString stringWithFormat:@"%@/proxy.html?cid=%@",KBaseUrl,[UserModel defaultModel].cid];
            [self.navigationController pushViewController:webVc animated:YES];
        }else{
            webVc.webUrl = [NSString stringWithFormat:@"%@/contract.html",KBaseUrl];
            [self.navigationController pushViewController:webVc animated:YES];
        }
    }
}


- (void)handleRequestBtn{
    UserModel *model = [UserModel defaultModel];
    [model logOut];
    [self showTitleHUD:@"注销成功" wait:1 completion:^{
      [[NSNotificationCenter defaultCenter] postNotificationName:Sign_Out object:nil];
      [self.navigationController popViewControllerAnimated:YES];
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
