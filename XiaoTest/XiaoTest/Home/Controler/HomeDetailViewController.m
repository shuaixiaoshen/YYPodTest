//
//  HomeDetailViewController.m
//  XiaoTest
//
//  Created by shen on 2018/7/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "CertificateDetailViewController.h"
#import "OrderViewController.h"
#import "HomeDetailModel.h"

#define blueColor [UIColor colorWithRed:98 /255.0 green:161 / 255.0 blue:242 / 255.0 alpha:1]
#define defaultColor [UIColor grayColor]
#define blueLayerColor [UIColor colorWithRed:188 /255.0 green:217 / 255.0 blue:246 / 255.0 alpha:1].CGColor
#define defaultLayerColor [UIColor lightGrayColor].CGColor
@interface HomeDetailViewController ()

@property(strong, nonatomic) UIScrollView *scrollView;

@end

@implementation HomeDetailViewController{
    UIView *baseView;
    NSArray *netArr;
    NSArray *colorArr;
    NSArray *memaryArr;
    NSArray *timeArr;
    HomeDetailModel *detailModel;
    
    UIView *headerView;
    UILabel *productLab;
    UILabel *moneyLab;
    UILabel *allMoneyLab;
    
    NSString *current_skuid;
    NSString *current_date;
    NSString *current_memry;
    NSString *current_network;
    NSString *current_color;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 340 + 250 + 64);
        baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 340 + 250 + 64)];
        [_scrollView addSubview:baseView];
    }
    return _scrollView;
}
-(void)getDetail{
    if (_model) {
        [self showLoadingHUD];
        [self postWithURLString:[NSString stringWithFormat:@"%@/base/getProductdet",KBaseUrl] parameters:@{@"id":_model.product_id} success:^(id _Nullable success) {
            [self hiddenLoadingHUD];
            NSDictionary *dicData = success[@"data"];
            detailModel = [[HomeDetailModel alloc] init];
            [detailModel configureModleWithDic:dicData];
            NaviBarView *naviBar = [[NaviBarView alloc] init];
            naviBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
            naviBar.title = @"商品详情";
            [self.view addSubview:self.scrollView];
            [self.view addSubview:naviBar];
            [self addHeaderWith:naviBar];
            [self addMidviewWith:headerView];
        } failure:^(NSString * _Nullable error) {
            [self hiddenLoadingHUD];
            [self showTitleHUD:error wait:1 completion:^{
               
            }];
            
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self getDetail];
    // Do any additional setup after loading the view.
}

- (void)addHeaderWith:(UIView *)aView{
    headerView = [[UIView alloc] init];
    headerView.layer.cornerRadius = 8.0f;
    headerView.layer.masksToBounds = YES;
    headerView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@0);
        make.left.mas_offset(@15);
        make.right.mas_offset(@-15);
        make.height.mas_offset(@340);
    }];
    UIImageView *addressImg = [[UIImageView alloc] init];
    [addressImg sd_setImageWithURL:[NSURL URLWithString:_model.product_detimg]];
//    addressImg.contentMode = UIViewContentModeCenter;
    [headerView addSubview:addressImg];
    [addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@20);
        make.centerX.equalTo(headerView);
        make.width.mas_offset(@145);
        make.height.mas_offset(@200);
    }];
    productLab = [[UILabel alloc] init];
    productLab.text = [NSString stringWithFormat:@"%@ 我有,你也有",_model.product_name];
    productLab.font = [UIFont boldSystemFontOfSize:14];
    [headerView addSubview:productLab];
    [productLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@20);
        make.bottom.mas_offset(@-50);
    }];
    moneyLab = [[UILabel alloc] init];
//    moneyLab.text = [NSString stringWithFormat:@"￥%@/月",_model.eachprice];
    moneyLab.font = [UIFont boldSystemFontOfSize:14];
    [headerView addSubview:moneyLab];
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@20);
        make.bottom.mas_offset(@-15);
    }];
    allMoneyLab = [[UILabel alloc] init];
//    allMoneyLab.text = [NSString stringWithFormat:@"商品价值%@",_model.product_price];
    allMoneyLab.font = [UIFont systemFontOfSize:9];
    [headerView addSubview:allMoneyLab];
    [allMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@-20);
        make.centerY.equalTo(moneyLab);
    }];
    NSDictionary *priceDic = detailModel.priceArr.firstObject;
    NSString *cycleprice = priceDic[@"cycleprice"];
    NSString *price = priceDic[@"price"];
    detailModel.product_price = price;
    moneyLab.text = [NSString stringWithFormat:@"￥%@/月",cycleprice];
    allMoneyLab.text = [NSString stringWithFormat:@"商品价值%@",price];
    current_skuid = [NSString stringWithFormat:@"%@",priceDic[@"sku_id"]];
}

- (void)addMidviewWith:(UIView *)aView{
    UIView *midView = [[UIView alloc] init];
    [baseView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.mas_bottom);
        make.height.mas_offset(@250);
        make.left.right.mas_offset(@0);
    }];
    netArr = detailModel.networkArr;
    [self addMidDetailViewWithTitle:@"网络" andTitleDetailArr:netArr aView:midView type:0];
    colorArr = detailModel.colorArr;
    [self addMidDetailViewWithTitle:@"颜色" andTitleDetailArr:colorArr aView:midView type:1];
    memaryArr = detailModel.memoryArr;
    [self addMidDetailViewWithTitle:@"内存" andTitleDetailArr:memaryArr aView:midView type:2];
    timeArr = detailModel.dateArr;
    [self addMidDetailViewWithTitle:@"租期" andTitleDetailArr:timeArr aView:midView type:3];
    UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    requestBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
    requestBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [requestBtn setTitle:@"确认申请" forState:UIControlStateNormal];
    [midView addSubview:requestBtn];
    [requestBtn addTarget:self action:@selector(handleRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@32);
        make.left.mas_offset(@40);
        make.right.mas_offset(@-40);
        make.bottom.mas_offset(@-20);
    }];
    current_date = timeArr.firstObject;
    current_color = colorArr.firstObject;
    current_memry = memaryArr.firstObject;
    current_network = netArr.firstObject;
}

- (void)addMidDetailViewWithTitle:(NSString *)title andTitleDetailArr:(NSArray *)titleArr aView:(UIView *)aView type:(NSInteger)type{
    UIView *midView = [[UIView alloc] init];
    [aView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@15);
        make.right.mas_offset(@-15);
        make.height.mas_offset(@45);
        make.top.mas_offset(type * 45);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = title;
    titleLab.font = [UIFont systemFontOfSize:13];
    [midView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@10);
        make.centerY.equalTo(midView);
    }];
    for (NSInteger i = 0;i < titleArr.count; i++) {
        UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
          aBtn.layer.borderColor = blueLayerColor;
          [aBtn setTitleColor:blueColor forState:UIControlStateNormal];
        }else{
          aBtn.layer.borderColor = defaultLayerColor;
          [aBtn setTitleColor:defaultColor forState:UIControlStateNormal];
        }
        aBtn.layer.cornerRadius = 3.0f;
        aBtn.layer.masksToBounds = YES;
        aBtn.layer.borderWidth = 1.5f;
        aBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [aBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [midView addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@26);
            make.width.mas_offset(@57);
            make.centerY.equalTo(midView);
            if (titleArr.count > 3) {
                make.left.equalTo(titleLab.mas_right).mas_offset(i * (57 + 3) + 27);
            }else{
                make.left.equalTo(titleLab.mas_right).mas_offset(i * (57 + 5) + 27);
            }
            
        }];
        aBtn.tag = 3333 + i + type * 1000;
        [aBtn addTarget:self action:@selector(handleChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)handleChangeBtn:(UIButton *)btn{
    NSInteger type = (btn.tag - 3333) / 1000;
    NSInteger count = 0;
    switch (type) {
        case 0:
            count = netArr.count;
            break;
        case 1:
            count = colorArr.count;
            break;
        case 2:
            count = memaryArr.count;
            break;
        case 3:
            count = timeArr.count;
            break;
        default:
            break;
    }
    for (NSInteger i = 0; i < count; i++) {
        NSInteger currentTag = 3333 + i + type * 1000;
        if (btn.tag == currentTag) {
            btn.layer.borderColor = blueLayerColor;
            [btn setTitleColor:blueColor forState:UIControlStateNormal];
             if (type == 3){
                NSDictionary *priceDic = detailModel.priceArr[i];
                NSString *cycleprice = priceDic[@"cycleprice"];
                NSString *price = priceDic[@"price"];
                detailModel.product_price = price;
                moneyLab.text = [NSString stringWithFormat:@"￥%@/月",cycleprice];
                allMoneyLab.text = [NSString stringWithFormat:@"商品价值%@",price];
                 current_skuid = [NSString stringWithFormat:@"%@",priceDic[@"sku_id"]];
                 current_date = timeArr[i];
             }else if (type == 0){
                 current_network = netArr[i];
             }else if (type == 1){
                 current_color = colorArr[i];
             }else if (type == 2){
                 current_memry = memaryArr[i];
             }
        }else{
            UIButton *otherBtn = [baseView viewWithTag:currentTag];
            otherBtn.layer.borderColor = defaultLayerColor;
            [otherBtn setTitleColor:defaultColor forState:UIControlStateNormal];
        }
    }
}


- (void)handleRequestBtn{
    OrderViewController *orderVc = [[OrderViewController alloc] init];
    orderVc.hidesBottomBarWhenPushed = YES;
//    orderVc.detailModel = detailModel;
//    orderVc.current_skuid = current_skuid;
//    orderVc.current_color = current_color;
//    orderVc.current_network = current_network;
//    orderVc.current_time = current_date;
//    orderVc.current_memary = current_memry;
//    [self.navigationController pushViewController:orderVc animated:YES];
    return;
    
    [self showLoadingHUD];
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/getApplyStep",KBaseUrl] parameters:nil success:^(id _Nullable data) {
        [self hiddenLoadingHUD];
        NSDictionary *dataDic = data[@"data"];
        NSInteger step = [[NSString stringWithFormat:@"%@",dataDic[@"step"]] integerValue];
        CertificateDetailViewController *vc = [[CertificateDetailViewController alloc] init];
        OrderViewController *orderVc = [[OrderViewController alloc] init];
        orderVc.hidesBottomBarWhenPushed = YES;
        orderVc.detailModel = detailModel;
        orderVc.current_skuid = current_skuid;
        orderVc.current_color = current_color;
        orderVc.current_network = current_network;
        orderVc.current_time = current_date;
        orderVc.current_memary = current_memry;
        switch (step - 1) {
            case 0:
                vc.sourceType = 0;
                break;
            case 1:
                vc.sourceType = 1;
                break;
            case 2:
                vc.sourceType = 2;
                break;
            case 3:
                vc.sourceType = 3;
                break;
            case 4:
                vc.sourceType = 4;
                break;
            case 5:
                vc.sourceType = 5;
                break;
            case 6:
                vc.sourceType = 6;
                break;
            case 7:
                vc.sourceType = 7;
                break;
            default:
                [self.navigationController pushViewController:orderVc animated:YES];
                return ;
                break;
        }
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSString * _Nullable error) {
        [self hiddenLoadingHUD];
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
