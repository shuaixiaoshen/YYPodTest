//
//  CertificateDetailViewController.m
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "CertificateDetailViewController.h"
#import "HomeDetailViewController.h"
#import "OrderViewController.h"
#import "AFHTTPSessionManager.h"
#import "CetificateHeaderView.h"
#import "CardView.h"
#import "PersonView.h"
#import "FriendeView.h"
#import "OtherView.h"
#import "BqsServiceId.h"
#import "BqsCrawlerCloudSDK.h"

#import<AVFoundation/AVCaptureDevice.h>

#import <AVFoundation/AVMediaFormat.h>

#import<AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#if !(TARGET_IPHONE_SIMULATOR)
// 在真机的情况下
#else
// 在模拟器情况下
#endif

@interface CertificateDetailViewController ()<BqsCrawlerCloudSDKDelegate,UIImagePickerControllerDelegate,CardViewDelegate,UINavigationControllerDelegate,PersonViewDelegate,FriendeViewDelegate,OtherViewDelegate>

@end

@implementation CertificateDetailViewController{
    NSArray *imgArr;
    NSArray *titleArr;
    NSData *imageData1;
    NSData *imageData2;
    NSData *imageData3;
    NSData *outputURL1;
    NSData *outputURL2;
    UIImageView *cardImg;
    UIView *control;
    
    CardView *cardView;
    PersonView *personView;
    FriendeView *friendView;
    OtherView *otherView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    titleArr = @[@"身份认证",@"信息认证",@"联系人信息",@"常用联系人",@"运营商认证",@"淘宝认证",@"支付宝认证",@"征信认证"];
    imgArr = @[@"moblie_img",@"moblie_img",@"moblie_img",@"moblie_img",@"moblie_img",@"taobao_img",@"aliPay_img",@"student_img"];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    NaviBarView *naviBar = [[NaviBarView alloc] init];
    [self.view addSubview:naviBar];
    naviBar.title = titleArr[_sourceType];
    CetificateHeaderView *headerView = [CetificateHeaderView cetiAddSubView:self.view];
    headerView.sourceType = _sourceType;
    [headerView startSetUp];
    if (_sourceType == 0) {
        cardView = [CardView cardAddSubView:self.view];
        cardView.delegate = self;
        cardView.frame = CGRectMake(0, 134, CGRectGetWidth(self.view.frame), KscreenHeight - CGRectGetMaxY(headerView.frame));
        cardView.code = _code;
        cardView.infodic = _infoDic;
        [cardView startSetUp];
    }else if (_sourceType == 1){
        personView = [PersonView personAddSubView:self.view];
        personView.delegate = self;
        personView.frame = CGRectMake(0, 134, CGRectGetWidth(self.view.frame), KscreenHeight - CGRectGetMaxY(headerView.frame));
        personView.infodic = _infoDic;
        personView.code = _code;
        [personView startSetUp];
    }else if (_sourceType == 2){
        friendView = [FriendeView friendeAddSubView:self.view];
        friendView.delegate = self;
        friendView.frame = CGRectMake(0, 134, CGRectGetWidth(self.view.frame), KscreenHeight - CGRectGetMaxY(headerView.frame));
        friendView.infodic = _infoDic;
        friendView.code = _code;
        [friendView startSetUp];
    }else if (_sourceType == 3){
        otherView = [OtherView otherAddSubView:self.view];
        otherView.delegate = self;
        otherView.frame = CGRectMake(0, 134, CGRectGetWidth(self.view.frame), KscreenHeight - CGRectGetMaxY(headerView.frame));
        otherView.infodic = _infoDic;
        otherView.code = _code;
        [otherView startSetUp];
    }else{
        //注册白骑士
        [self setUpWith:headerView];
        [self registBqsSdk];
    }
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
//    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
}
- (void)endEdit{
    [self endEdit];
}

- (void)registBqsSdk{
    [BqsCrawlerCloudSDK shared].fromController = self;
    [BqsCrawlerCloudSDK shared].delegate = self;
    
    //客户参数
    [BqsCrawlerCloudSDK shared].partnerId = @"xiaoxiang";
    [BqsCrawlerCloudSDK shared].certNo = [[NSUserDefaults standardUserDefaults] valueForKey:@"Card_No"];
    [BqsCrawlerCloudSDK shared].name = [[NSUserDefaults standardUserDefaults] valueForKey:@"Card_Name"];
    [BqsCrawlerCloudSDK shared].mobile = [UserModel defaultModel].phone;
    NSLog(@"%@ %@ %@ %@", @"xiaoxiang",[[NSUserDefaults standardUserDefaults] valueForKey:@"Card_No"],[[NSUserDefaults standardUserDefaults] valueForKey:@"Card_Name"],[UserModel defaultModel].phone);
    //主题
    [BqsCrawlerCloudSDK shared].foreColor = [UIColor blackColor];
    [BqsCrawlerCloudSDK shared].themeColor = [UIColor whiteColor];
    [BqsCrawlerCloudSDK shared].fontColor = [UIColor blackColor];
    [BqsCrawlerCloudSDK shared].progressBarColor = [UIColor blueColor];
}

- (void)setUpWith:(UIView *)subView{
    UIView *backView = [[UIView alloc] init];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor colorWithRed:134 / 255.0 green:177 / 255.0 blue:230 / 255.0 alpha:1];
    backView.layer.cornerRadius = 10.0f;
    backView.layer.masksToBounds = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@25);
        make.right.mas_offset(@-25);
        make.top.equalTo(subView.mas_bottom).mas_offset(15);
        make.height.mas_offset(@205);
    }];
    UIImageView *logoImg = [[UIImageView alloc] init];
    logoImg.image = [UIImage imageNamed:imgArr[_sourceType]];
    [backView addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.centerY.equalTo(backView).mas_offset(-15);
        make.width.height.mas_offset(@95);
    }];
    UILabel *logoLab = [[UILabel alloc] init];
    logoLab.text = titleArr[_sourceType];
    logoLab.textColor = [UIColor whiteColor];
    logoLab.font = [UIFont boldSystemFontOfSize:16];
    [backView addSubview:logoLab];
    [logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImg.mas_bottom).mas_offset(5);
        make.centerX.equalTo(logoImg);
    }];
    UILabel *loginLab = [[UILabel alloc] init];
    loginLab.text = @"登陆后将获取以下权限";
    loginLab.textColor = [UIColor blackColor];
    loginLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:loginLab];
    [loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).mas_offset(35);
        make.left.mas_offset(@30);
    }];
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.text = [NSString stringWithFormat:@"%@需要提供本人账号和密码等信息",titleArr[_sourceType]];
    detailLab.textColor = [UIColor grayColor];
    detailLab.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginLab.mas_bottom).mas_offset(5);
        make.left.mas_offset(@35);
    }];
    UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    requestBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:requestBtn];
    [requestBtn setTitle:@"授权认证" forState:UIControlStateNormal];
    [requestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    requestBtn.backgroundColor = [UIColor colorWithRed:134 / 255.0 green:177 / 255.0 blue:230 / 255.0 alpha:1];
    requestBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@-45);
        make.left.mas_equalTo(@70);
        make.right.mas_equalTo(@-70);
        make.height.mas_equalTo(@45);
    }];
    [requestBtn addTarget:self action:@selector(handleRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    if (_sourceType == 7) {
        UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        skipBtn.backgroundColor = [UIColor blueColor];
        [self.view addSubview:skipBtn];
        [skipBtn setTitle:@"跳过认证" forState:UIControlStateNormal];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        skipBtn.backgroundColor = [UIColor colorWithRed:134 / 255.0 green:177 / 255.0 blue:230 / 255.0 alpha:1];
        skipBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(@-5);
            make.left.mas_equalTo(@70);
            make.right.mas_equalTo(@-70);
            make.height.mas_equalTo(@25);
        }];
        [skipBtn addTarget:self action:@selector(handleSkipBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)handleSkipBtnBtn{
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/skipStudentAuth",KBaseUrl] parameters:nil success:^(id _Nullable data) {
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [self pushNewCheck];
        }else{
            [self showTitleHUD:data[@"message"] wait:1 completion:nil];
        }
    } failure:^(NSString * _Nullable error) {
        [self showTitleHUD:error wait:1 completion:nil];
    }];
}

- (void)handleRequestBtn{
    switch (_sourceType) {
        case 4:
            [[BqsCrawlerCloudSDK shared] loginMno];
            break;
        case 5:
            [[BqsCrawlerCloudSDK shared] loginTaobao];
            break;
        case 6:
            [[BqsCrawlerCloudSDK shared] loginAlipay];
            break;
        default:
            [[BqsCrawlerCloudSDK shared] loginChsi];
            break;
    }
}

#pragma mark - BqsCrawlerCloudSDKDelegate
-(void)onBqsCrawlerCloudResult:(NSString *)resultCode withDesc:(NSString *)resultDesc withServiceId:(int)serviceId{
    NSLog(@"========resultCode=%@,resultDesc=%@", resultCode, resultDesc);
    NSString *type;
    NSString *requestUrl;
    if(MNO_SERVICE_ID == serviceId){//运营商授权成功
        type = @"运营商";
        requestUrl = [NSString stringWithFormat:@"%@/custom/mobileAuth",KBaseUrl];
    } else if(TB_SERVICE_ID == serviceId){//淘宝授权成功
        type = @"淘宝";
        requestUrl = [NSString stringWithFormat:@"%@/custom/taobaoAuth",KBaseUrl];
    } else if(ALIPAY_SERVICE_ID == serviceId){//支付宝授权成功
        type = @"支付宝";
        requestUrl = [NSString stringWithFormat:@"%@/custom/zhifbAuth",KBaseUrl];
    } else if(CHSI_SERVICE_ID == serviceId){//学信网授权成功
        type = @"学信网征信";
        requestUrl = [NSString stringWithFormat:@"%@/custom/learnLetAuth",KBaseUrl];
    } else {
        //...
    }
    if([@"CCOM1000" isEqualToString:resultCode]){
        NSLog(@"%@授权成功", type);
        [self postWithURLString:requestUrl parameters:@{@"result":resultDesc} success:^(id _Nullable data) {
            NSLog(@"%@",data);
            NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self showTitleHUD:@"认证成功" wait:1 completion:^{
                    if ([code isEqualToString:@"1"]) {
                        [self pushNewCheck];
                    }
                }];
            }
        } failure:^(NSString * _Nullable error) {
            NSLog(@"%@",error);
        }];
    } else {
        NSLog(@"%@授权失败", type);
    }
}

//身份信息图片
- (void)handlePushCardPhotoWithImg:(UIImageView *)img{
    cardImg = img;
    [self pushLoginImgWithType:1];
}
//个人信息图片
- (void)handlePushUserPhotoWithImg:(UIImageView *)img{
    cardImg = img;
    [self pushLoginImgWithType:2];

}

- (void)showAlertTitle:(NSString *)alert{
    [self showTitleHUD:alert wait:1 completion:nil];
}

//保存亲属联系人
- (void)handleSaveFriendeInfoWithDic:(NSDictionary *)dic{
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/complementCusClan",KBaseUrl] parameters:dic success:^(id _Nullable data) {
        NSLog(@"%@",data);
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",data[@"message"]];
        if ([code isEqualToString:@"1"]) {
            [self pushNewCheck];
        }
    } failure:^(NSString * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

//保存常用联系人
- (void)handleSaveOtherInfoWithDic:(NSDictionary *)dic{
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/complementLinks",KBaseUrl] parameters:dic success:^(id _Nullable data) {
        NSLog(@"%@",data);
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",data[@"message"]];
        if ([code isEqualToString:@"1"]) {
            [self showTitleHUD:message wait:1 completion:^{
                [self pushNewCheck];
            }];
        }
    } failure:^(NSString * _Nullable error) {
        NSLog(@"%@",error);
    }];
}
//保存个人信息
- (void)handleSaveUserInfoWithDic:(NSDictionary *)dic{
    [self showLoadingHUD];
    if (personView.isStu && cardImg.tag == 5556) {
        if (!outputURL1) {
            [self showTitleHUD:@"请上传芝麻分" wait:1 completion:nil];
            return;
        }
    }else if (!personView.isStu && cardImg.tag == 5557){
        if (!outputURL1) {
            [self showTitleHUD:@"请上传工作证" wait:1 completion:nil];
            return;
        }
    }else if (!personView.isStu && cardImg.tag == 5556){
        if (!outputURL1) {
            [self showTitleHUD:@"请上传芝麻分" wait:1 completion:nil];
            return;
        }
    }else{
        if (!outputURL1 || !outputURL2) {
            [self showTitleHUD:@"请上传文件" wait:1 completion:nil];
            return;
        }
    }
    if (!outputURL1) {
        [self showTitleHUD:@"请上传芝麻分" wait:1 completion:nil];
    }
    if (!personView.isStu) {
        if (!outputURL1 || !outputURL2) {
            [self showTitleHUD:@"请上传文件" wait:1 completion:nil];
            return;
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/custom/complementCusInfo",KBaseUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:NSUserDefaultsGet(Session_token) forHTTPHeaderField:@"token"];
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        
        if (outputURL1) {
         [formData appendPartWithFileData:outputURL1 name:@"zhimfvideoFile" fileName:fileName mimeType:@"mp4"];
        }
        if (!personView.isStu) {
            [formData appendPartWithFileData:outputURL2 name:@"workcardFile" fileName:fileName mimeType:@"jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hiddenLoadingHUD];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",dic[@"message"]];
        NSLog(@"%@ %@",dic,message);
        if ([code isEqualToString:@"1"]) {
            [self showTitleHUD:message wait:1 completion:^{
              [self pushNewCheck];
            }];
            
        }else{
            [self showTitleHUD:message wait:1 completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hiddenLoadingHUD];
        NSLog(@"%@",error);
    }];
}

//保存身份信息
- (void)handlePostCardRequestWithDic:(NSDictionary *)dic{
    [self showLoadingHUD];
    NSString *urlStr = [NSString stringWithFormat:@"%@/custom/idenAuth",KBaseUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:NSUserDefaultsGet(Session_token) forHTTPHeaderField:@"token"];
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        [formData appendPartWithFileData:imageData1 name:@"identity_frontfile" fileName:fileName mimeType:@"jpeg"];
        [formData appendPartWithFileData:imageData2 name:@"identity_reversefile" fileName:fileName mimeType:@"jpeg"];
        [formData appendPartWithFileData:imageData3 name:@"cus_photofile" fileName:fileName mimeType:@"jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hiddenLoadingHUD];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",dic[@"message"]];
        NSLog(@"%@ %@",dic,message);
        if ([code isEqualToString:@"1"]) {
            [self pushNewCheck];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hiddenLoadingHUD];
        NSLog(@"%@",error);
    }];
}

/**
 用户头像上传
 */
- (void)pushLoginImgWithType:(NSInteger)type{
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
   
    
    if (type == 1) {
         imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置通过照相来选取照片
    }else if (cardImg.tag == 5556){
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//设置通过照相来选取照片
        imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置通过照相来选取照片
    }
    imagePicker.allowsEditing = YES; //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//得到图片或者视频后, 调用该代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (_sourceType == 0 || cardImg.tag == 5557) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (cardImg.tag == 3333) {
            imageData1 = UIImageJPEGRepresentation(image,0.1);
        }else if (cardImg.tag == 3334){
            imageData2 = UIImageJPEGRepresentation(image,0.1);
        }else if(cardImg.tag == 3335){
            imageData3 = UIImageJPEGRepresentation(image,0.1);
        }else if (cardImg.tag == 5556){
            outputURL2 = UIImageJPEGRepresentation(image,0.1);
        }
        [cardImg setImage:image];
    }else{
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSURL *newVideoUrl ; //一般.mp4
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
    }
   
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 NSLog(@"%@",outputURL);
                 NSLog(@"%@",[self getVideoPreViewImageWithPath:outputURL]);
                 if (cardImg.tag == 5556) {
                     outputURL1 = [NSData dataWithContentsOfURL:outputURL];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         personView.img1.image = [self getVideoPreViewImageWithPath:outputURL];
                     });
                 }
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}  
//获取视频的第一帧截图, 返回UIImage
//需要导入AVFoundation.h
- (UIImage*) getVideoPreViewImageWithPath:(NSURL *)videoPath
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    
    AVAssetImageGenerator *gen         = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time      = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error   = nil;
    
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img     = [[UIImage alloc] initWithCGImage:image];
    
    return img;
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


//  键盘弹出触发该方法
- (void)keyboardDidShow:(NSNotification *)noti
{
    //获取键盘的高度
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    if (!control) {
        control =  [[UIView alloc] initWithFrame:self.view.window.frame];
        UITapGestureRecognizer *tapCan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRemoveSelf)];
        UIPanGestureRecognizer *panCan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRemoveSelf)];
        [control addGestureRecognizer:tapCan];
        [control addGestureRecognizer:panCan];
        [self.view.window addSubview:control];
    }
    [self.view.window addSubview:control];
}

- (void)pushNewCheck{
    [self showLoadingHUD];
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/getApplyStep",KBaseUrl] parameters:nil success:^(id _Nullable data) {
        NSLog(@"%@",data);
        [self hiddenLoadingHUD];
        NSDictionary *dataDic = data[@"data"];
        NSInteger step = [[NSString stringWithFormat:@"%@",dataDic[@"step"]] integerValue];
        CertificateDetailViewController *vc = [[CertificateDetailViewController alloc] init];
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
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[HomeDetailViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }else{
                        [self showTitleHUD:@"您已全部认证完毕" wait:1 completion:nil];
                    }
                }
                return ;
                break;
        }
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSString * _Nullable error) {
        [self hiddenLoadingHUD];
    }];
}


- (void)cancelRemoveSelf{
    [self.view endEditing:YES];
    [control removeFromSuperview];
    control = nil;
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
