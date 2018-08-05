//
//  SignViewController.m
//  XiaoTest
//
//  Created by shen on 2018/6/18.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "SignViewController.h"
#import "RootViewController.h"
#import "WebViewController.h"

@interface SignViewController ()

@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIView *baseView;
@property(strong, nonatomic) UITextField *moblieField;
@property(strong, nonatomic) UITextField *passwordField;
@end

@implementation SignViewController{
    NSString *yzmToken;
    UIButton *_getSmsBtn;
    UIButton *fastBtn;
    UILabel *signLab;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, CGRectGetHeight(self.view.frame))];
        _scrollView.contentSize = CGSizeMake(KscreenWidth, CGRectGetHeight(_scrollView.frame));
        _scrollView.bounces = YES;
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, _scrollView.contentSize.height)];
        [_scrollView addSubview:_baseView];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *cancleField = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:cancleField];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self addHeaderLogo];
    // Do any additional setup after loading the view.
}

- (void)addHeaderLogo{
    UIView *headerLogo = [[UIView alloc] init];
    [_baseView addSubview:headerLogo];
    [headerLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.mas_offset(@34);
        make.height.mas_offset(@100);
    }];
    UIImageView *logoImg = [[UIImageView alloc] init];
    [headerLogo addSubview:logoImg];
    logoImg.contentMode = UIViewContentModeCenter;
    logoImg.image = [UIImage imageNamed:@"sign_03"];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@10);
        make.centerY.equalTo(headerLogo);
        make.height.mas_offset(@90);
        make.width.mas_offset(@65);
    }];
    UILabel *logoLab = [[UILabel alloc] init];
    [headerLogo addSubview:logoLab];
    logoLab.text = @"笑享租";
    logoLab.font = [UIFont boldSystemFontOfSize:16];
    [logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImg.mas_right).mas_offset(3);
        make.centerY.equalTo(headerLogo).mas_offset(-10);
    }];
    UILabel *logoDetailLab = [[UILabel alloc] init];
    [headerLogo addSubview:logoDetailLab];
    logoDetailLab.textColor = [UIColor grayColor];
    logoDetailLab.text = @"信用租机 我有你也有";
    logoDetailLab.font = [UIFont boldSystemFontOfSize:13];
    [logoDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImg.mas_right).mas_offset(3);
        make.top.equalTo(logoLab.mas_bottom).mas_offset(5);
    }];
    UIButton *tranBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [tranBtn setTitle:@"切换" forState:UIControlStateNormal];
    [headerLogo addSubview:tranBtn];
    [tranBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_offset(@0);
        make.width.mas_offset(@45);
        make.height.mas_offset(@20);
    }];
    [tranBtn addTarget:self action:@selector(handleTranBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addMidViewWithHeaderView:headerLogo];
}

- (void)handleTranBtn{
    if (_isRegist) {
        _isRegist = NO;
        [fastBtn setTitle:@"快速登录" forState:UIControlStateNormal];
        signLab.text = @"登录即同意";
    }else{
        _isRegist = YES;
        [fastBtn setTitle:@"快速注册" forState:UIControlStateNormal];
        signLab.text = @"注册即同意";
    }
}


- (void)addMidViewWithHeaderView:(UIView *)headerView{
    UIView *midView = [[UIView alloc] init];
    [_baseView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.equalTo(headerView.mas_bottom).mas_offset(50);
        make.bottom.mas_offset(@50);
    }];
    UILabel *logoLab = [[UILabel alloc] init];
    [midView addSubview:logoLab];
    logoLab.text = @"欢迎您！";
    logoLab.font = [UIFont boldSystemFontOfSize:18];
    [logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.top.mas_offset(@0);
    }];
    UIView *moblieView = [[UIView alloc] init];
    [midView addSubview:moblieView];
    [moblieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoLab.mas_bottom);
        make.height.mas_offset(@70);
        make.left.mas_offset(@25);
        make.right.mas_offset(@-25);
    }];
    _moblieField = [[UITextField alloc] init];
    [moblieView addSubview:_moblieField];
    _moblieField.keyboardType = UIKeyboardTypePhonePad;
    _moblieField.clearsOnBeginEditing = YES;
    _moblieField.placeholder = @"请输入手机号";
    [_moblieField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.bottom.mas_offset(@0);
        make.height.mas_offset(@45);
    }];
    UILabel *line = [[UILabel alloc] init];
    [moblieView addSubview:line];
    line.backgroundColor = [UIColor grayColor];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.height.mas_offset(@.5);
        make.bottom.mas_offset(@0);
    }];
    UIView *passwordView = [[UIView alloc] init];
    [midView addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moblieView.mas_bottom);
        make.height.mas_offset(@70);
        make.left.mas_offset(@25);
        make.right.mas_offset(@-25);
    }];
    _passwordField = [[UITextField alloc] init];
    [passwordView addSubview:_passwordField];
    _passwordField.keyboardType = UIKeyboardTypePhonePad;
    _passwordField.placeholder = @"请输入手机验证码";
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@0);
        make.right.mas_offset(@-115);
        make.bottom.mas_offset(@0);
        make.height.mas_offset(@45);
    }];
    _getSmsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getSmsBtn.backgroundColor = [UIColor colorWithRed:95 / 255.0 green:156 / 255.0 blue:249 / 255.0 alpha:1];
    [_getSmsBtn setTitle:@"获取" forState:UIControlStateNormal];
    _getSmsBtn.layer.cornerRadius = 15.0f;
    _getSmsBtn.layer.masksToBounds = YES;
    _getSmsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_getSmsBtn addTarget:self action:@selector(handleSendCode) forControlEvents:UIControlEventTouchUpInside];
    [passwordView addSubview:_getSmsBtn];
    [_getSmsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@0);
        make.centerY.equalTo(_passwordField);
        make.height.mas_offset(@30);
        make.width.mas_offset(@115);
    }];
    UILabel *line1 = [[UILabel alloc] init];
    [passwordView addSubview:line1];
    line1.backgroundColor = [UIColor grayColor];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.height.mas_offset(@.5);
        make.bottom.mas_offset(@0);
    }];
    fastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fastBtn.backgroundColor = [UIColor colorWithRed:95 / 255.0 green:156 / 255.0 blue:249 / 255.0 alpha:1];
    if (_isRegist) {
        [fastBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    }else{
        [fastBtn setTitle:@"快速登录" forState:UIControlStateNormal];
    }
    
    fastBtn.layer.cornerRadius = 18.0f;
    fastBtn.layer.masksToBounds = YES;
    fastBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [fastBtn addTarget:self action:@selector(handleSignBtn) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:fastBtn];
    [fastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(@-20);
        make.left.mas_offset(@20);
        make.top.equalTo(passwordView.mas_bottom).mas_offset(50);
        make.height.mas_offset(@36);
    }];
    [self addBottomViewWithMidView:midView];
}

- (void)addBottomViewWithMidView:(UIView *)midView{
    UIView *bottomView = [[UIView alloc] init];
    [_baseView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.bottom.mas_offset(@-15);
        make.height.mas_offset(@20);
    }];
    signLab = [[UILabel alloc] init];
    [bottomView addSubview:signLab];
    signLab.textColor = [UIColor grayColor];
    if (_isRegist) {
       signLab.text = @"注册即同意";
    }else{
        signLab.text = @"登录即同意";
    }
    
    signLab.font = [UIFont boldSystemFontOfSize:13];
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView).mas_offset(-30);
        make.centerY.equalTo(bottomView);
    }];
    UIButton *fuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [fuBtn setTitle:@"用户服务协议" forState:UIControlStateNormal];
    fuBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bottomView addSubview:fuBtn];
    [fuBtn addTarget:self action:@selector(handleAgree:) forControlEvents:UIControlEventTouchUpInside];
    [fuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(signLab.mas_right);
        make.centerY.equalTo(bottomView);
    }];
}

- (void)handleAgree:(UIButton *)btn{
    WebViewController *webVc = [[WebViewController alloc] init];
    webVc.hidesBottomBarWhenPushed = YES;
    webVc.webUrl = [NSString stringWithFormat:@"%@/login.html",KBaseUrl];
    [self presentViewController:webVc animated:YES completion:nil];
}

#pragma mark - 按钮事件 -

- (void)handleSendCode{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_moblieField.text forKey:@"phone"];
    [dic setValue:[NSString stringWithFormat:@"%@%@%@",[self getRandomStringWithNum:6],NSUserDefaultsGet(Session_token),[self getRandomStringWithNum:6]] forKey:@"token"];
    NSString *requestUrl;
    if (_isRegist) {
        requestUrl = [NSString stringWithFormat:@"%@/custom/sendRegistCode",KBaseUrl];
    }else{
        requestUrl = [NSString stringWithFormat:@"%@/custom/sendLoginCode",KBaseUrl];
    }
    [self postWithURLString:requestUrl parameters:dic success:^(id _Nullable data) {
        NSLog(@"%@",data);
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",data[@"message"]];
        if (![code isEqualToString:@"1"]) {
            [self showTitleHUD:message wait:1 completion:nil];
        }else{
            [self gcdStartTimer];
        }
        
        yzmToken = [data valueForKey:@"data"];
    } failure:^(NSString * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

- (void)handleSignBtn{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_moblieField.text forKey:@"phone"];
    [dic setValue:yzmToken forKey:@"yzmToken"];
    [dic setValue:_passwordField.text forKey:@"yzmCode"];
    NSString *requestUrl;
    if (_isRegist) {
        requestUrl = [NSString stringWithFormat:@"%@/custom/regist",KBaseUrl];
    }else{
        requestUrl = [NSString stringWithFormat:@"%@/custom/login",KBaseUrl];
    }
    [self postWithURLString:requestUrl parameters:dic success:^(id _Nullable data) {
        NSLog(@"%@",data);
        NSDictionary *dataDic = data[@"data"];
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([code isEqualToString:@"1"]) {
            UserModel *model = [UserModel defaultModel];
            model.seesionToken = dataDic[@"token"];
            model.isSign = YES;
            [model configureSignInModelWithDictionary:dataDic[@"custom"]];
            NSUserDefaultsSave(dataDic[@"token"], Session_token);
            NSUserDefaultsSave(@"Old_User", Old_User);
            [self complexObjectArchiverWithDB_Name:@"user_db" Model:model];
            [[NSNotificationCenter defaultCenter] postNotificationName:Sign_Success object:nil];
            if (_isRegist) {
                [self showTitleHUD:@"注册成功" wait:1 completion:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }else{
                [self showTitleHUD:@"登陆成功" wait:1 completion:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }
        }else{
            [self showTitleHUD:data[@"message"] wait:1 completion:nil];
        }
    } failure:^(NSString * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

/*
 * 利用GCD计时
 */
- (void)gcdStartTimer{
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getSmsBtn setTitle:@"获取" forState:UIControlStateNormal];
                _getSmsBtn.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getSmsBtn  setTitle:[NSString stringWithFormat:@"%d s",timeout] forState:UIControlStateNormal];
                _getSmsBtn.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/**
 随机数生成
 
 @param num 位数
 @return 随机数
 */
- (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}




- (void)endEdit{
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
