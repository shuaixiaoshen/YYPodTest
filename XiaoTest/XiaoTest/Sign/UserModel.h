//
//  UserModel.h
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>


+ (UserModel *)defaultModel;

@property(strong, nonatomic) NSString *seesionToken;
@property(strong, nonatomic) NSString *cid;
@property(strong, nonatomic) NSString *headimg;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *phone;
@property(strong, nonatomic) NSString *shipaddress;
@property(strong, nonatomic) NSString *family_flg;
@property(assign, nonatomic) BOOL isSign;

- (void)configureSignInModelWithDictionary:(NSDictionary *)dic;

- (void)logOut;

@end
