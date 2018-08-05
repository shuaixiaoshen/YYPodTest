//
//  AddressViewController.m
//  XiaoTest
//
//  Created by shen on 2018/7/26.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "AddressViewController.h"
#import "GFAddressPicker.h"

@interface AddressViewController ()<GFAddressPickerDelegate>

@property (strong, nonatomic) NaviBarView *naviBar;
@property (nonatomic, strong) GFAddressPicker *pickerView;

@end

@implementation AddressViewController{
    NSString *citeAddress;
    UITextField *detailField;
    UIButton *addressBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBar = [[NaviBarView alloc] init];
    [self.view addSubview:_naviBar];
    _naviBar.isLine = YES;
    _naviBar.title = @"添加收货地址";
    UILabel *nameLab = [[UILabel alloc] init];
    [self.view addSubview:nameLab];
    nameLab.text = @"收货人";
    nameLab.font = [UIFont systemFontOfSize:14];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@30);
        make.top.equalTo(_naviBar.mas_bottom).mas_offset(@15);
    }];
    UITextField *nameField = [[UITextField alloc] init];
    [self.view addSubview:nameField];
    nameField.text = [UserModel defaultModel].name;
    nameField.enabled = NO;
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLab);
        make.right.mas_offset(@-30);
        make.width.mas_offset(KscreenWidth - 150);
    }];
    UILabel *moblieLab = [[UILabel alloc] init];
    [self.view addSubview:moblieLab];
    moblieLab.text = @"联系电话";
    moblieLab.font = [UIFont systemFontOfSize:14];
    [moblieLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@30);
        make.top.equalTo(nameLab.mas_bottom).mas_offset(@35);
    }];
    UITextField *moblieField = [[UITextField alloc] init];
    [self.view addSubview:moblieField];
    moblieField.text = [UserModel defaultModel].phone;
    moblieField.enabled = NO;
    [moblieField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moblieLab);
        make.right.mas_offset(@-30);
        make.width.mas_offset(KscreenWidth - 150);
    }];
    UILabel *addressLab = [[UILabel alloc] init];
    [self.view addSubview:addressLab];
    addressLab.text = @"所在地区";
    addressLab.font = [UIFont systemFontOfSize:14];
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@30);
        make.top.equalTo(moblieLab.mas_bottom).mas_offset(@35);
    }];
    addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:addressBtn];
    [addressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addressBtn setTitle:@"请选择 >" forState:UIControlStateNormal];
    [addressBtn addTarget:self action:@selector(handleChangeCity) forControlEvents:UIControlEventTouchUpInside];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressLab);
        make.right.mas_offset(@-30);
    }];
    UILabel *detailLab = [[UILabel alloc] init];
    [self.view addSubview:detailLab];
    detailLab.text = @"详细地址";
    detailLab.font = [UIFont systemFontOfSize:14];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@30);
        make.top.equalTo(addressLab.mas_bottom).mas_offset(@35);
    }];
    detailField = [[UITextField alloc] init];
    [self.view addSubview:detailField];
    [detailField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(detailLab);
        make.right.mas_offset(@-30);
        make.width.mas_offset(KscreenWidth - 150);
    }];
    UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    requestBtn.backgroundColor = [UIColor colorWithRed:73 /255.0 green:146 / 255.0 blue:241 / 255.0 alpha:1];
    requestBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [requestBtn setTitle:@"确认申请" forState:UIControlStateNormal];
    [self.view addSubview:requestBtn];
    [requestBtn addTarget:self action:@selector(handleRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@35);
        make.left.mas_offset(@40);
        make.right.mas_offset(@-40);
        make.bottom.mas_offset(@-30);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapEndEdit)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)handleRequestBtn{
    if (detailField.text.length == 0) {
        [self showTitleHUD:@"请填写详细地址" wait:1 completion:nil];
        return;
    }
    if (!citeAddress) {
        [self showTitleHUD:@"请选择城市" wait:1 completion:nil];
        return;
    }
    NSString *address = [citeAddress stringByAppendingString:detailField.text];
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/saveAddress",KBaseUrl] parameters:@{@"shipaddress":address} success:^(id _Nullable data) {
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",data[@"message"]];
        if ([code isEqualToString:@"1"]) {
            [self showTitleHUD:@"保存成功" wait:1 completion:^{
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"update_address" object:address];
            }];
        }else{
            [self showTitleHUD:message wait:1 completion:nil];
        }
    } failure:^(NSString * _Nullable error) {
        
    }];
}

- (void)handleChangeCity{
    self.pickerView = [[GFAddressPicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.pickerView updateAddressAtProvince:@"河南省" city:@"郑州市" town:@"金水区"];
    self.pickerView.delegate = self;
    self.pickerView.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:self.pickerView];
}

- (void)GFAddressPickerCancleAction
{
    [self.pickerView removeFromSuperview];
}

- (void)GFAddressPickerWithProvince:(NSString *)province
                               city:(NSString *)city area:(NSString *)area
{
    [self.pickerView removeFromSuperview];
    
    citeAddress = [NSString stringWithFormat:@"%@  %@  %@",province,city,area];
    [addressBtn setTitle:citeAddress forState:UIControlStateNormal];
    
}

- (void)handleTapEndEdit{
    [self.view endEditing:YES];
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
