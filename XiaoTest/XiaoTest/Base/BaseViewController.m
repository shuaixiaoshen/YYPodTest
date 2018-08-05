//
//  BaseViewController.m
//  XiaoTest
//
//  Created by shen on 2018/6/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "MBProgressHUD.h"
@interface BaseViewController ()

@end

@implementation BaseViewController{
    MBProgressHUD *HUD;
    MBProgressHUD *HUDMessage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)postWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSString * _Nullable))failure{

    NSString *token = NSUserDefaultsGet(Session_token);
    NSString *requestUrl = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //后台+随机 token
    if (token) {
    [request setValue:token forHTTPHeaderField:@"token"];
    }

    if (parameters !=nil)
    {
        
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]];

    }
        NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            //拿到响应头信息
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            NSString *errMsg = [NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]];
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            // use the nsdata... code removed for general purpose
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
                NSString *message = [NSString stringWithFormat:@"%@",dic[@"message"]];
                if ([code isEqualToString:@"2"] || [message isEqualToString:@"Access Token not allowed"]) {
                    [self getToken];
                }
                if (success) {
                    success(dic);
                }
            });
            
        }else if (error.code == -1009){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(@"网络连接错误");
                }
            });
        }
    }];
    [task resume];
}

- (void)showTitleHUD:(NSString *)message wait:(double)wait completion:(void (^)(void))completion{
    HUDMessage = [MBProgressHUD showHUDAddedTo:[self keyWindow] animated:YES];
    [[self keyWindow] bringSubviewToFront:HUD];
    HUDMessage.mode = MBProgressHUDModeText;
    HUDMessage.detailsLabel.text = message;
    HUDMessage.detailsLabel.font = [UIFont boldSystemFontOfSize:18];
    HUDMessage.minShowTime = wait;
    [HUDMessage hideAnimated:YES afterDelay:wait];
    HUDMessage.completionBlock = ^{
        if (completion) {
            completion();
        }
    };
}

- (UIWindow *)keyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    return keyWindow;
}

- (void)showLoadingHUD{
    if (HUD) {
        [self hiddenLoadingHUD];
    }
    HUD = [MBProgressHUD showHUDAddedTo:[self keyWindow] animated:YES];
    [[self keyWindow] bringSubviewToFront:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.label.text = @"加载中...";
    [self performSelector:@selector(hiddenLoadingHUDWithTime) withObject:nil afterDelay:15];
    [HUD hideAnimated:YES afterDelay:15];
}

- (void)hiddenLoadingHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenLoadingHUDWithTime) object:nil];
        [MBProgressHUD hideHUDForView:[self keyWindow] animated:YES];
        [HUD hideAnimated:YES];
        [HUD removeFromSuperview];
        HUD = nil;
    });
    
}

- (void)hiddenLoadingHUDWithTime{
    [self showTitleHUD:@"请求超时" wait:1 completion:nil];
}

//获取sessiontoken
- (void)getToken{
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/getYzmToken",KBaseUrl] parameters:nil success:^(id _Nullable responseObject) {
        NSString *token = [responseObject valueForKey:@"data"];
        if (token) {
            NSUserDefaultsSave(token, Session_token);
            SignViewController *vc = [[SignViewController alloc] init];
//            if (![[NSUserDefaults standardUserDefaults] valueForKey:Old_User]) {
//                vc.isRegist = YES;
//            }
            [self presentViewController:vc animated:YES completion:nil];
        }
    } failure:^(NSString * _Nullable error) {
        NSLog(@"获取token失败:%@",error);
    }];
}

-(void)checkNetworkingState{
    AFNetworkReachabilityManager *netState = [AFNetworkReachabilityManager sharedManager];
    [netState setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                NSLog(@"无法联网");
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                //                NSLog(@"当前在WIFI网络下");
            }
                
        }
    }];
    [netState startMonitoring];
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


/*
 *数据归档到本地
 */
- (void)complexObjectArchiverWithDB_Name:(NSString *)db_name Model:(id)model{
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *productPath = [paths stringByAppendingString:db_name];
    [NSKeyedArchiver archiveRootObject:model toFile:productPath];
}

/*
 *数据取出归档数据
 */
- (id)getObjectArchiverWithDB_Name:(NSString *)db_name{
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *productPath = [paths stringByAppendingString:db_name];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:productPath];
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
