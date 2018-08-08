//
//  MyViewController.m
//  XiaoTest
//
//  Created by shen on 2018/6/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "MyViewController.h"
#import "HistoryViewController.h"
#import "CertificateViewController.h"
#import "ChatViewController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"
#import "AFHTTPSessionManager.h"
#import "MyCell.h"

#import<AVFoundation/AVCaptureDevice.h>

#import <AVFoundation/AVMediaFormat.h>

#import<AssetsLibrary/AssetsLibrary.h>

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,MyCellProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet NaviBarView *naviBar;

@end

@implementation MyViewController{
    UIImageView *icon;
    NSData *imageData;
    UIView *signView;
}

- (void)handleSignSuccess{
    [_tableView reloadData];
}

- (void)handleSignOutSuccess{
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignSuccess) name:Sign_Success object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignOutSuccess) name:Sign_Out object:nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MyCell class] forCellReuseIdentifier:@"cell"];
    _tableView.sectionFooterHeight = 0.0f;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_naviBar.mas_bottom);
        make.left.mas_offset(@0);
        make.right.mas_offset(@0);
        make.bottom.mas_offset(@-44);
    }];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45 * 5 + 15;
    }
    return 45 * 2 + 15;
}

- (void)handleSeletedCell:(NSString *)seletedStr{
    NSLog(@"%@",seletedStr);
    if ([seletedStr isEqualToString:@"身份信息"]) {
        CertificateViewController *vc = [SBMain instantiateViewControllerWithIdentifier:@"CertificateViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([seletedStr isEqualToString:@"设置"]){
        SettingViewController *vc = [[SettingViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([seletedStr isEqualToString:@"待审核租赁订单"]){
//        HistoryViewController *vc = [[HistoryViewController alloc] init];
//        vc.sourceType = 1;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"my_selectde" object:@"2"];
        self.tabBarController.selectedIndex = 1;
    }else if ([seletedStr isEqualToString:@"待结清租赁订单"]){
//        HistoryViewController *vc = [[HistoryViewController alloc] init];
//        vc.sourceType = 2;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"my_selectde" object:@"1"];
        self.tabBarController.selectedIndex = 1;
    }else if ([seletedStr isEqualToString:@"租赁结清记录"]){
        HistoryViewController *vc = [[HistoryViewController alloc] init];
        vc.sourceType = 3;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([seletedStr isEqualToString:@"客服帮助"]){
        ChatViewController *vc = [[ChatViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([seletedStr isEqualToString:@"消息中心"]){
        MessageViewController *vc = [[MessageViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *imgArr;
    NSArray *titleArr;
    if (indexPath.section == 0) {
        imgArr = @[@"my_18",@"my_14",@"my_16",@"my_18",@"my_20"];
        titleArr = @[@"待审核租赁订单",@"待结清租赁订单",@"租赁结清记录",@"身份信息",@"消息中心",];
    }else{
        imgArr = @[@"my_22",@"my_24"];
        titleArr = @[@"客服帮助",@"设置"];
    }
    [cell configureModelWithimgArr:imgArr titleArr:titleArr];
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        signView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
        [self removeAllView];
        [self addHeadViewWith:signView];
        return signView;
    }
    return [[UIView alloc] init];
}

-(void)removeAllView{
    for (UIView *aView in signView.subviews) {
        [aView removeFromSuperview];
    }
}

- (void)addNoUserView:(UIImageView *)headerImg{
    UIButton *conpetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    conpetBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    conpetBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    conpetBtn.layer.borderWidth = 1.0f;
    conpetBtn.layer.cornerRadius = 6.0f;
    conpetBtn.layer.masksToBounds = YES;
    [conpetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signView addSubview:conpetBtn];
    [conpetBtn setTitle:@"请先登录" forState:UIControlStateNormal];
    conpetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [conpetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImg);
        make.centerY.equalTo(headerImg).mas_offset(-15);
        make.width.mas_offset(@75);
        make.height.mas_offset(@45);
    }];
    [conpetBtn addTarget:self action:@selector(handleSignBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *moblieLab = [[UILabel alloc] initWithFrame:CGRectZero];
    moblieLab.textAlignment = NSTextAlignmentCenter;
    moblieLab.font = [UIFont systemFontOfSize:13];
    moblieLab.textColor = [UIColor whiteColor];
    [signView addSubview:moblieLab];
    moblieLab.text = @"笑享租,年轻人的信用租机";
    [moblieLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImg);
        make.top.equalTo(conpetBtn.mas_bottom).mas_offset(10);
    }];
}

- (void)addUserModelView:(UIImageView *)headerImg{
    icon = [[UIImageView alloc] initWithFrame:CGRectZero];
    [signView addSubview:icon];
    icon.layer.cornerRadius = 75 / 2;
    icon.layer.masksToBounds = YES;
    if ([UserModel defaultModel].isSign) {
        [icon sd_setImageWithURL:[NSURL URLWithString:[UserModel defaultModel].headimg]];
    }else{
        icon.image = [UIImage imageNamed:@"sign_03"];
    }
    icon.backgroundColor = [UIColor whiteColor];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(signView);
        make.top.mas_offset(@15);
        make.width.height.mas_offset(@75);
    }];
    icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapHeadIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePostHeaderIcon)];
    [icon addGestureRecognizer:tapHeadIcon];
    UILabel *moblieLab = [[UILabel alloc] initWithFrame:CGRectZero];
    moblieLab.textAlignment = NSTextAlignmentCenter;
    moblieLab.font = [UIFont systemFontOfSize:13];
    moblieLab.textColor = [UIColor whiteColor];
    [signView addSubview:moblieLab];
    moblieLab.text = [[UserModel defaultModel] phone];
    [moblieLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImg);
        make.top.equalTo(icon.mas_bottom).mas_offset(10);
    }];
    UIButton *conpetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    conpetBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [conpetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signView addSubview:conpetBtn];
    [conpetBtn setTitle:@"完善个人信息>>" forState:UIControlStateNormal];
    [conpetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImg);
        make.top.equalTo(moblieLab.mas_bottom).mas_offset(3);
    }];
    [conpetBtn addTarget:self action:@selector(handleConpetBtn:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)addHeadViewWith:(UIView *)headerView{
    UIImageView *headerImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [headerView addSubview:headerImg];
    headerImg.layer.cornerRadius = 5.0f;
    headerImg.layer.masksToBounds = YES;
    headerImg.image = [UIImage imageNamed:@"my_03"];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@10);
        make.right.mas_offset(@-10);
        make.top.mas_offset(@0);
        make.bottom.mas_offset(@0);
    }];
    if ([UserModel defaultModel].isSign) {
        [self addUserModelView:headerImg];
    }else{
        [self addNoUserView:headerImg];
    }

}

- (void)handlePostHeaderIcon{
    [self pushLoginImg];
}

- (void)handleSignBtn:(UIButton *)btn{
    [self getToken];
}

- (void)handleConpetBtn:(UIButton *)btn{
    CertificateViewController *vc = [SBMain instantiateViewControllerWithIdentifier:@"CertificateViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 150;
    }
    return 5;
}
- (IBAction)pushSettingController {
    SettingViewController *vc = [[SettingViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 用户头像上传
 */
- (void)pushLoginImg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更改用户头像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *CameraAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断摄像头是否可用
        //    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        //相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
            authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            [self showTitleHUD:@"请允许设备访问相机" wait:1 completion:nil];
            return;
        }
        //初始化图片选择控制器
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置通过照相来选取照片
        imagePicker.allowsEditing = YES; //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *PhotoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化图片选择控制器
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        //    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置通过照相来选取照片
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES; //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
        imagePicker.delegate = self;
        imagePicker.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        imagePicker.navigationBar.barTintColor = [UIColor colorWithRed:20.f/255.0 green:24.0/255.0 blue:38.0/255.0 alpha:1];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:PhotoAction];
    [alertController addAction:CameraAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//得到图片或者视频后, 调用该代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageData = UIImageJPEGRepresentation(image,0.1);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    NSString *urlStr = [NSString stringWithFormat:@"%@/custom/saveCusHeadImg",KBaseUrl];
    
//    [self postWithURLString:urlStr parameters:@{@"headimg":@""} success:^(id _Nullable data) {
//        NSLog(@"%@",data);
//    } failure:^(NSString * _Nullable error) {
//        NSLog(@"%@",error);
//    }];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:NSUserDefaultsGet(Session_token) forHTTPHeaderField:@"token"];
    NSLog(@"-----%@",NSUserDefaultsGet(Session_token));
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        [formData appendPartWithFileData:imageData name:@"headimg" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",dic[@"message"]];
        if ([code isEqualToString:@"1"]) {
            [self showTitleHUD:message wait:1 completion:^{
                [icon sd_setImageWithURL:[NSURL URLWithString:dic[@"data"]] placeholderImage:[UIImage imageNamed:@"sign_03"]];
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//当用户取消相册时, 调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//在这里创建一个路径，用来在照相的代理方法里作为照片存储的路径
-(NSString *)getImageSavePath{
    //获取存放的照片
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath  = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"PhotoFile"];
    return imageDocPath;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Sign_Out object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Sign_Success object:nil];
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
