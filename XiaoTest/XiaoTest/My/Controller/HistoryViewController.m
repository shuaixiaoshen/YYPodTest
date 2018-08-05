//
//  HistoryViewController.m
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "HistoryViewController.h"
#import "TradeViewCell.h"
#import "TradeModel.h"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;

@end

@implementation HistoryViewController{
    NSMutableArray *dataSource1;
    NSMutableArray *dataSource2;
    NSMutableArray *dataSource3;
    AlertView *alert;
}


- (void)loadHistoryInfo{
    [self postWithURLString:[NSString stringWithFormat:@"%@/book/getBills",KBaseUrl] parameters:nil success:^(id _Nullable data) {
        NSLog(@"%@",data);
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([code isEqualToString:@"1"]) {
            dataSource3 = [NSMutableArray array];
            for (NSDictionary *dic in data[@"data"]) {
                TradeModel *model = [[TradeModel alloc] init];
                [model configureModelWithMy_TradeDic:dic];
                [dataSource3 addObject:model];
            }
            if (dataSource3.count > 0) {
                [_tableView reloadData];
                if (alert) {
                    [alert removeFromSuperview];
                    alert = nil;
                }
            }else{
                alert = [[AlertView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight - 64) AlertImg:[UIImage imageNamed:@"trade_null"] AlertTitle:@"暂无记录"];
                [self.view addSubview:alert];
            }
        }
    } failure:^(NSString * _Nullable error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHistoryInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    NaviBarView *navviBar = [[NaviBarView alloc] init];
    navviBar.isLine = YES;
    if (_sourceType == 1) {
      navviBar.title = @"待审核订单";
    }else if (_sourceType == 2){
      navviBar.title = @"待结清订单";
    }else{
     navviBar.title = @"租赁结清记录";
    }
    [self.view addSubview:navviBar];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.equalTo(navviBar.mas_bottom).mas_offset(@0);
        make.bottom.mas_offset(@0);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TradeViewCell class] forCellReuseIdentifier:@"cell3"];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_sourceType == 1) {
        return dataSource1.count;
    }else if (_sourceType == 2){
        return dataSource2.count;
    }else{
        return dataSource3.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_sourceType == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        return cell;
    }else if (_sourceType == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        return cell;
    }else{
        TradeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        [cell configureModel:dataSource3[indexPath.row]];
        return cell;
    }
    
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
