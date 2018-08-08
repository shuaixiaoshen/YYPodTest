//
//  TradeViewController.m
//  XiaoTest
//
//  Created by shen on 2018/6/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "TradeViewController.h"
#import "PayViewController.h"
#import "ChatViewController.h"
#import "TradeHeaderView.h"
#import "TradeViewCell.h"
#import "TradeModel.h"
#import <AlipaySDK/AlipaySDK.h>

@interface TradeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TradeViewProtocol,TradeHeaderViewProtocol>
@property (strong, nonatomic) UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NaviBarView *naviBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineX;

@property (weak, nonatomic) IBOutlet UIButton *header_one;
@property (weak, nonatomic) IBOutlet UIButton *header_two;
@property (weak, nonatomic) IBOutlet UIButton *header_three;

@end

@implementation TradeViewController{
    UIView *baseView;
    AlertView *alert1;
    AlertView *alert2;
    AlertView *alert3;
    AlertView *error;
    UITableView *currentTableView;
    NSMutableArray *tradeMutArr1;
    NSMutableArray *tradeMutArr2;
    NSMutableArray *tradeMutArr3;
    NSMutableArray *tradeDetArr1;
    NSMutableArray *tradeDetArr2;
}

#define viewheight KscreenHeight - 64 - 44

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, viewheight)];
        _scrollView.contentSize = CGSizeMake(KscreenWidth * 3, viewheight);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth * 3, viewheight)];
        [_scrollView addSubview:baseView];
    }
    return _scrollView;
}
- (void)showAlertWithType:(NSInteger)type{
    if (type == 1) {
        if (!alert1) {
            alert1 = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth,CGRectGetHeight(baseView.frame)) AlertImg:[UIImage imageNamed:@"trade_null1"] AlertTitle:@"暂无已完成订单"];
            [baseView addSubview:alert1];
        }

    }else if (type == 2){
        if (!alert2) {
            alert2 = [[AlertView alloc] initWithFrame:CGRectMake(KscreenWidth, 0, KscreenWidth, CGRectGetHeight(baseView.frame)) AlertImg:[UIImage imageNamed:@"trade_null"] AlertTitle:@"暂无待还订单"];
            [baseView addSubview:alert2];
        }
    }else if(type == 3){
        if (!alert3) {
            alert3 = [[AlertView alloc] initWithFrame:CGRectMake(2 * KscreenWidth, 0, KscreenWidth, CGRectGetHeight(baseView.frame)) AlertImg:[UIImage imageNamed:@"trade_null"] AlertTitle:@"暂无审核订单"];
            [baseView addSubview:alert3];
        }
        
    }else{
        if (!error) {
            error = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) AlertImg:[UIImage imageNamed:@"trade_netWork"] AlertTitle:@"网络连接失败"];
            [self.view addSubview:alert3];
        }
    }
}

- (void)hiddenAlertWith:(NSInteger)type{
    if (type == 1) {
        [alert1 removeFromSuperview];
        alert1 = nil;
    }else if (type == 2){
        [alert2 removeFromSuperview];
        alert2 = nil;
    }else if(type == 3){
        [alert3 removeFromSuperview];
        alert3 = nil;
    }else{
        [error removeFromSuperview];
        error = nil;
    }
}

- (void)getTradeListWithPage:(NSInteger)page Status:(NSInteger)status{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",status] forKey:@"state"];
    [self postWithURLString:[NSString stringWithFormat:@"%@/book/getBookList",KBaseUrl] parameters:dic success:^(id _Nullable data) {
        NSDictionary *dic = data;
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        NSDictionary *dataDic = dic[@"data"];
        [self hiddenAlertWith:4];
        if ([code isEqualToString:@"1"]) {
            if (status == 3) {
                tradeMutArr1 = [NSMutableArray array];
                tradeDetArr1 = [NSMutableArray array];
            }else if (status == 1){
                tradeMutArr2 = [NSMutableArray array];
                tradeDetArr2 = [NSMutableArray array];
            }else{
                tradeMutArr3 = [NSMutableArray array];
            }
            for (NSDictionary *tradeDic in dataDic[@"list"]) {
                TradeModel *model = [[TradeModel alloc] init];
                [model configureModelWithTradeDic:tradeDic];
                if (status == 3) {
                  [tradeMutArr1 addObject:model];
                    NSMutableArray *detArr = [NSMutableArray array];
                    for (NSDictionary *detDic in model.paymentList) {
                        TradeModel *modelDet = [[TradeModel alloc] init];
                        [modelDet configureModelWithHis_TradeDic:detDic];
                        modelDet.his_tottalCount = model.paymentList.count;
                        [detArr addObject:modelDet];
                    }
                    [tradeDetArr1 addObject:detArr];
                }else if (status == 1){
                    if ([dataDic[@"list"] count] == 1) {
                        model.isExted = YES;
                    }
                  [tradeMutArr2 addObject:model];
                    NSMutableArray *detArr = [NSMutableArray array];
                    for (NSDictionary *detDic in model.paymentList) {
                        TradeModel *modelDet = [[TradeModel alloc] init];
                        [modelDet configureModelWithHis_TradeDic:detDic];
                        modelDet.bid = [NSString stringWithFormat:@"%@",tradeDic[@"bid"]];
                        modelDet.his_tottalCount = model.paymentList.count;
                        [detArr addObject:modelDet];
                    }
                    [tradeDetArr2 addObject:detArr];
                    UITableView *tableView = [_scrollView viewWithTag:6666];
                    [tableView reloadData];
                }else{
                  [tradeMutArr3 addObject:model];
                }
            }
            NSInteger tag = 0;
            if (status == 3) {
                tag = 0;
                if (tradeMutArr1.count == 0) {
                    [self showAlertWithType:1];
                }else{
                    [self hiddenAlertWith:1];
                }
            }else if (status == 1){
                tag = 1;
                if (tradeMutArr2.count == 0) {
                    [self showAlertWithType:2];
                }else{
                    [self hiddenAlertWith:2];
                }
            }else{
                tag = 2;
                if (tradeMutArr3.count == 0) {
                    [self showAlertWithType:3];
                }else{
                    [self hiddenAlertWith:3];
                }
            }
            UITableView *tableView = [_scrollView viewWithTag:6666 + tag];
            [tableView reloadData];
        }
    } failure:^(NSString * _Nullable error) {
        NSLog(@"%@",error);
        [self showAlertWithType:4];
    }];
}

- (void)handleScrollCurrentTab:(NSNotification *)noti{
    NSString *indexStr = noti.object;
    NSInteger index = [indexStr integerValue];
    [self changeBtnWithPage:index];
    currentTableView = [baseView viewWithTag:6666 + index];
    [_scrollView setContentOffset:CGPointMake(KscreenWidth * index, 0) animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserModel defaultModel].isSign) {
        [self getTradeListWithPage:1 Status:1];
        [self getTradeListWithPage:1 Status:2];
        [self getTradeListWithPage:1 Status:3];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleScrollCurrentTab:) name:@"my_selectde" object:nil];
    _lineX.constant = -60.0f;
    [self.view updateConstraintsIfNeeded];
    [self.view addSubview:self.scrollView];
    for (NSInteger i = 0; i < 3; i++) {
    UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [baseView addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 10.0f;
        _tableView.rowHeight = 130.0f;
        [_tableView registerClass:[TradeViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[TradeHeaderView class] forHeaderFooterViewReuseIdentifier:@"TradeHeaderView"];
        _tableView.tag = 6666 + i;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(@0);
            make.left.mas_offset(KscreenWidth * i);
            make.width.mas_offset(KscreenWidth);
            make.bottom.mas_offset(@0);
        }];
    }
    currentTableView = [baseView viewWithTag:6666];
    if (![UserModel defaultModel].isSign) {
        alert1 = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth,CGRectGetHeight(baseView.frame)) AlertImg:[UIImage imageNamed:@"trade_null1"] AlertTitle:@"暂无已完成订单"];
        [baseView addSubview:alert1];
    
        alert2 = [[AlertView alloc] initWithFrame:CGRectMake(KscreenWidth, 0, KscreenWidth, CGRectGetHeight(baseView.frame)) AlertImg:[UIImage imageNamed:@"trade_null"] AlertTitle:@"暂无待还订单"];
        [baseView addSubview:alert2];
        alert3 = [[AlertView alloc] initWithFrame:CGRectMake(2 * KscreenWidth, 0, KscreenWidth, CGRectGetHeight(baseView.frame)) AlertImg:[UIImage imageNamed:@"trade_null"] AlertTitle:@"暂无审核订单"];
        [baseView addSubview:alert3];
    }
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TradeModel *model;
    if (tableView.tag == 6666) {
        model = tradeMutArr1[section];
    }else if (tableView.tag == 6667){
        model = tradeMutArr2[section];
    }else{
        model = tradeMutArr3[section];
    }
    if (model.isExted) {
        return model.paymentList.count;
    }else{
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 6666) {
       return tradeMutArr1.count;
    }else if (tableView.tag == 6667){
       return tradeMutArr2.count;
    }else{
       return tradeMutArr3.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TradeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TradeModel *model;
    if (tableView.tag == 6666) {
        NSArray *arr = tradeDetArr1[indexPath.section];
        model = arr[indexPath.row];
        cell.type = 1;
    }else if (tableView.tag == 6667){
        NSArray *arr = tradeDetArr2[indexPath.section];
        model = arr[indexPath.row];
        cell.type = 2;
    }else{
        model = tradeMutArr3[indexPath.section];
        cell.type = 3;
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureModel:model];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TradeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TradeHeaderView"];
    TradeModel *model;
    if (tableView.tag == 6666) {
        headerView.type = 1;
        model = tradeMutArr1[section];
    }else if (tableView.tag == 6667){
        headerView.type = 2;
        model = tradeMutArr2[section];
    }else{
        headerView.type = 3;
        model = tradeMutArr3[section];
    }
    headerView.delegate = self;
    headerView.setion = section;
    [headerView configureModel:model];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 6668) {
        return 200.0f;
    }
    return 245.0f;
}

- (void)handleExtedCellWithCurrentSetion:(NSInteger)setion{
    if (currentTableView.tag == 6666) {
        TradeModel *model = tradeMutArr1[setion];
        if (model.isExted) {
            model.isExted = NO;
        }else{
            model.isExted = YES;
        }
        [tradeMutArr1 replaceObjectAtIndex:setion withObject:model];
        [currentTableView reloadSections:[NSIndexSet indexSetWithIndex:setion] withRowAnimation:UITableViewRowAnimationNone];
    }else if (currentTableView.tag == 6667){
        TradeModel *model = tradeMutArr2[setion];
        if (model.isExted) {
            model.isExted = NO;
        }else{
            model.isExted = YES;
        }
        [tradeMutArr2 replaceObjectAtIndex:setion withObject:model];
        [currentTableView reloadSections:[NSIndexSet indexSetWithIndex:setion] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (void)handlePayWithCurrentSetion:(NSInteger)setion{
    TradeModel *_model = tradeMutArr3[setion];
    [self handleRequestBtn:_model];
}

- (void)handleRequestBtn:(TradeModel *)_model{
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 6668) {
        TradeModel *_model = tradeMutArr3[indexPath.section];
        if ([_model.state isEqualToString:@"8"]) {
           [self handleRequestBtn:_model];
        }
        
    }
}
#pragma mark - 按钮切换 -

- (void)changeBtnWithPage:(NSInteger)page{
    if (page == 0) {
        _lineX.constant = -60.0f;
        [_header_one setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_header_two setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_header_three setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else if (page == 1){
        _lineX.constant = 0.0f;
        [_header_one setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_header_two setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_header_three setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else{
        _lineX.constant = 60.0f;
        [_header_one setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_header_two setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_header_three setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    currentTableView = [baseView viewWithTag:6666 + page];
    [self.view updateConstraintsIfNeeded];
}

- (IBAction)handleTouchHeaderBtn:(UIButton *)sender {
    NSString *btnStr = sender.titleLabel.text;
    NSInteger page = 0;
    if ([btnStr isEqualToString:@"已完成"]) {
        page = 0;
    }else if ([btnStr isEqualToString:@"待还"]){
        page = 1;
    }else{
        page = 2;
    }
    [self changeBtnWithPage:page];
    currentTableView = [baseView viewWithTag:6666 + page];
    [_scrollView setContentOffset:CGPointMake(KscreenWidth * page, 0) animated:YES];
}

- (void)handlePayOutMoneyBtnWithModel:(TradeModel *)model{
    PayViewController *vc = [[PayViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = _scrollView.contentOffset.x / KscreenWidth;
    [self changeBtnWithPage:page];
}

- (IBAction)traerChat:(UIButton *)sender {
    ChatViewController *vc = [[ChatViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"my_selectde" object:nil];
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
