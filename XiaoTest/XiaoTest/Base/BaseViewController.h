//
//  BaseViewController.h
//  XiaoTest
//
//  Created by shen on 2018/6/11.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)postWithURLString:(NSString *_Nullable)URLString parameters:(id _Nullable )parameters success:(void (^_Nullable)(id _Nullable))success failure:(void (^_Nullable)(NSString * _Nullable))failure;

- (void)getToken;

/**
 提示文字
 
 @param message 提示
 */
- (void)showTitleHUD:(NSString *)message
                wait:(double)wait
          completion:(void (^)(void))completion;


/**
 显示Loading动画
 */
- (void)showLoadingHUD;

/**
 隐藏Loading动画
 */
- (void)hiddenLoadingHUD;


/**
 网络状态

 */
-(void)checkNetworkingState;

/**
 数据归档到本地
 
 @param db_name 表名字
 @param model 数据源
 */
- (void)complexObjectArchiverWithDB_Name:(NSString *)db_name
                                Model:(id)model;

/**
 数据取出
 
 @param db_name 表名字
 @return 数据源
 */
- (id)getObjectArchiverWithDB_Name:(NSString *)db_name;


@end
