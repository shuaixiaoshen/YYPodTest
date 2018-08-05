//
//  OrderViewController.m
//  XiaoTest
//
//  Created by shen on 2018/7/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "OrderViewController.h"
#import "AddressViewController.h"

@interface OrderViewController ()

@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) NaviBarView *naviBar;

@end

@implementation OrderViewController{
    UIView *baseView;
    UIView *headerView;
    BOOL isAddress;
    UILabel *nameLab;
    UILabel *moblieLab;
    UILabel *adressLab;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
        _scrollView.bounces = YES;
         baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, CGRectGetHeight(self.view.frame) - 64)];
        [_scrollView addSubview:baseView];
    }
    return _scrollView;
}

- (void)loadMsgInfo{
    [self postWithURLString:[NSString stringWithFormat:@"%@/book/getApplyInfoByMsgId",KBaseUrl] parameters:@{@"msgid":_msg_id} success:^(id _Nullable data) {
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSDictionary *dataDic = data[@"data"];
        if ([code isEqualToString:@"1"]) {
            _detailModel.product_price = [NSString stringWithFormat:@"%@",dataDic[@"product_price"]];
            _detailModel.product_name = [NSString stringWithFormat:@"%@",dataDic[@"product_name"]];
            _detailModel.product_leaseterm = [NSString stringWithFormat:@"%@",dataDic[@"product_lease"]];
            [self addHeaderView];
        }
    } failure:^(NSString * _Nullable error) {
        [self showTitleHUD:error wait:1 completion:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UserModel defaultModel].shipaddress.length > 1) {
        isAddress = YES;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateAddress:) name:@"update_address" object:nil];
    _naviBar = [[NaviBarView alloc] init];
    _naviBar.title = @"确认申请";
    _naviBar.isLine = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:_naviBar];
    if (_msg_id) {
        [self loadMsgInfo];
    }else{
        [self addHeaderView];
    }
    // Do any additional setup after loading the view.
}

- (void)handleUpdateAddress:(NSNotification *)noti{
    NSString *updateAddress = noti.object;
    [headerView removeFromSuperview];
    headerView = nil;
    isAddress = YES;
    [self addHeaderView];
    adressLab.text = updateAddress;
}

- (void)addHeaderView{
    headerView = [[UIView alloc] init];
    [baseView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.mas_offset(@0);
        make.height.mas_offset(@100);
    }];
    UIImageView *addressImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_18"]];
    addressImg.contentMode = UIViewContentModeCenter;
    [headerView addSubview:addressImg];
    [addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(@-15);
        make.left.mas_offset(@20);
        make.width.mas_offset(@40);
        make.height.mas_offset(@50);
    }];
    if (!isAddress) {
        UILabel *noAddressLab = [[UILabel alloc] init];
        noAddressLab.text = @"请填写收件人信息";
        noAddressLab.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:noAddressLab];
        [noAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(addressImg.mas_right).mas_offset(@10);
            make.centerY.equalTo(addressImg);
        }];
    }else{
        nameLab = [[UILabel alloc] init];
        nameLab.text = [NSString stringWithFormat:@"收货人: %@",[UserModel defaultModel].name];
        
        nameLab.font = [UIFont boldSystemFontOfSize:15];
        [headerView addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(addressImg.mas_right).mas_offset(@10);
            make.top.mas_offset(@16);
        }];
        moblieLab = [[UILabel alloc] init];
        moblieLab.text = [NSString stringWithFormat:@"%@",[UserModel defaultModel].phone];
        moblieLab.textColor = [UIColor grayColor];
        moblieLab.font = [UIFont systemFontOfSize:14];
        [headerView addSubview:moblieLab];
        [moblieLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(@-40);
            make.centerY.equalTo(nameLab);
        }];
        adressLab = [[UILabel alloc] init];
        adressLab.text = [UserModel defaultModel].shipaddress;
        adressLab.font = [UIFont systemFontOfSize:13];
        adressLab.textColor = [UIColor grayColor];
        adressLab.numberOfLines = 2;
        [headerView addSubview:adressLab];
        [adressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(addressImg.mas_right).mas_offset(@10);
            make.right.mas_offset(@-50);
            make.centerY.equalTo(addressImg);
        }];
    }
    UIImageView *activeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_09"]];
//    activeImg.contentMode = UIViewContentModeCenter;
    [headerView addSubview:activeImg];
    [activeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressImg);
        make.right.mas_offset(@-15);
        make.width.mas_offset(@25);
        make.height.mas_offset(@30);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.height.mas_offset(@1);
        make.bottom.mas_offset(@0);
    }];
    UIButton *addAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:addAddress];
    [addAddress addTarget:self action:@selector(handleAddAddress) forControlEvents:UIControlEventTouchUpInside];
    [addAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(@0);
    }];
    [self addMidviewWith:headerView];
}

- (void)addMidviewWith:(UIView *)aView{
    UIView *midView = [[UIView alloc] init];
    [baseView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.mas_bottom).mas_offset(35);
        make.bottom.mas_offset(@0);
        make.left.mas_offset(@20);
        make.right.mas_offset(@-20);
    }];
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"商品名称";
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = [UIColor grayColor];
    [midView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.mas_offset(@0);
    }];
    UILabel *nameDetailLab = [[UILabel alloc] init];
    nameDetailLab.text = _detailModel.product_name;
    nameDetailLab.font = [UIFont systemFontOfSize:14];
    nameDetailLab.textColor = [UIColor grayColor];
    [midView addSubview:nameDetailLab];
    [nameDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(nameLab);
    }];
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.text = @"租期";
    timeLab.textColor = [UIColor grayColor];
    timeLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(nameLab.mas_bottom).mas_offset(14);
    }];
    UILabel *timeDetailLab = [[UILabel alloc] init];
    if (_msg_id) {
        timeDetailLab.text = _detailModel.product_leaseterm;
    }else{
       timeDetailLab.text = _current_time;
    }
    
    timeDetailLab.textColor = [UIColor grayColor];
    timeDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:timeDetailLab];
    [timeDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(timeLab);
    }];
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.text = @"商品价格";
    priceLab.textColor = [UIColor grayColor];
    priceLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(timeLab.mas_bottom).mas_offset(14);
    }];
    UILabel *priceDetailLab = [[UILabel alloc] init];
    priceDetailLab.text = _detailModel.product_price;
    priceDetailLab.textColor = [UIColor grayColor];
    priceDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:priceDetailLab];
    [priceDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(priceLab);
    }];
    
    UILabel *imeuLab = [[UILabel alloc] init];
    imeuLab.text = @"网络";
    imeuLab.textColor = [UIColor grayColor];
    imeuLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:imeuLab];
    [imeuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(priceLab.mas_bottom).mas_offset(45);
    }];
    UILabel *imeuDetailLab = [[UILabel alloc] init];
    if (_msg_id) {
       imeuDetailLab.text = @"全网通";
    }else{
      imeuDetailLab.text = _current_network;
    }
    
    imeuDetailLab.textColor = [UIColor grayColor];
    imeuDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:imeuDetailLab];
    [imeuDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(imeuLab);
    }];
    UILabel *meryLab = [[UILabel alloc] init];
    meryLab.text = @"内存";
    meryLab.textColor = [UIColor grayColor];
    meryLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:meryLab];
    [meryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(imeuLab.mas_bottom).mas_offset(14);
    }];
    UILabel *meryDetailLab = [[UILabel alloc] init];
    if (_msg_id) {
     meryDetailLab.text = [NSString stringWithFormat:@"4G/%@",@"64"];
    }else{
     meryDetailLab.text = _current_memary;
    }
    
    meryDetailLab.textColor = [UIColor grayColor];
    meryDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:meryDetailLab];
    [meryDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(meryLab);
    }];
    UILabel *peiLab = [[UILabel alloc] init];
    peiLab.text = @"颜色";
    peiLab.textColor = [UIColor grayColor];
    peiLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:peiLab];
    [peiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.top.equalTo(meryLab.mas_bottom).mas_offset(14);
    }];
    UILabel *peiDetailLab = [[UILabel alloc] init];
    if (_msg_id) {
      peiDetailLab.text = @"黑色";
    }else{
      peiDetailLab.text = _current_color;
    }
    
    peiDetailLab.textColor = [UIColor grayColor];
    peiDetailLab.font = [UIFont systemFontOfSize:14];
    [midView addSubview:peiDetailLab];
    [peiDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(peiLab);
    }];
    
    UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    requestBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
    requestBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [requestBtn setTitle:@"确认申请" forState:UIControlStateNormal];
    [midView addSubview:requestBtn];
    [requestBtn addTarget:self action:@selector(handleRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@35);
        make.left.mas_offset(@40);
        make.right.mas_offset(@-40);
        make.bottom.mas_offset(@-20);
    }];
}

- (void)handleRequestBtn{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_detailModel.product_leaseterm forKey:@"product_leaseterm"];
    
    if (_msg_id) {
        [dic setObject:@"2" forKey:@"type"];
        [dic setObject:_msg_id forKey:@"msgid"];
    }else{
        [dic setObject:@"1" forKey:@"type"];
        [dic setObject:_current_skuid forKey:@"sku_id"];
        [dic setObject:_detailModel.product_id forKey:@"product_id"];
    }
    
    [dic setObject:adressLab.text forKey:@"address"];
    [self postWithURLString:[NSString stringWithFormat:@"%@/book/applyBook",KBaseUrl] parameters:dic success:^(id _Nullable data) {
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [self showTitleHUD:@"申请成功" wait:1 completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }else{
            [self showTitleHUD:data[@"message"] wait:1 completion:^{
            }];
        }
    } failure:^(NSString * _Nullable error) {
        [self showTitleHUD:error wait:1 completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }];
}

- (void)handleAddAddress{
    AddressViewController *vc = [[AddressViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"update_address" object:nil];
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
