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
@property(strong, nonatomic) NSString *identity;
//认证
@property(strong, nonatomic) NSString *zhifb_flg;
@property(strong, nonatomic) NSString *taobao_flg;
@property(strong, nonatomic) NSString *student_flg;
//个人
@property(strong, nonatomic) NSString *person_flg;
//联系人
@property(strong, nonatomic) NSString *link_flg;
//亲属
@property(strong, nonatomic) NSString *mobile_flg;
//身份信息
@property(strong, nonatomic) NSString *identity_flg;

@property(assign, nonatomic) BOOL isSign;

- (void)configureSignInModelWithDictionary:(NSDictionary *)dic;

- (void)logOut;

@end
