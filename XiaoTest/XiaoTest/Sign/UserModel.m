//
//  UserModel.m
//  XiaoTest
//
//  Created by shen on 2018/7/7.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (UserModel *)defaultModel{
    static UserModel *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserModel alloc] init];
    });
    return manager;
}

- (void)configureSignInModelWithDictionary:(NSDictionary *)dic{
    _cid = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    _headimg = [NSString stringWithFormat:@"%@",dic[@"headimg"]];
    _name = [NSString stringWithFormat:@"%@",dic[@"name"]];
    _phone = [NSString stringWithFormat:@"%@",dic[@"phone"]];
    _shipaddress = [NSString stringWithFormat:@"%@",dic[@"shipaddress"]];
    _identity = [NSString stringWithFormat:@"%@",dic[@"identity"]];
    
    
    
    
    _family_flg = [NSString stringWithFormat:@"%@",dic[@"family_flg"]];
    _zhifb_flg = [NSString stringWithFormat:@"%@",dic[@"zhifb_flg"]];
    _taobao_flg = [NSString stringWithFormat:@"%@",dic[@"taobao_flg"]];
    _student_flg = [NSString stringWithFormat:@"%@",dic[@"student_flg"]];
    _person_flg = [NSString stringWithFormat:@"%@",dic[@"person_flg"]];
    _link_flg = [NSString stringWithFormat:@"%@",dic[@"link_flg"]];
    _mobile_flg = [NSString stringWithFormat:@"%@",dic[@"mobile_flg"]];
    _identity_flg = [NSString stringWithFormat:@"%@",dic[@"identity_flg"]];
}

- (void)logOut{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:Session_token];
    [userDefaults removeObjectForKey:Alreadey_token];
    _isSign = NO;
    _cid = NULL;
    _phone = NULL;
    _name = NULL;
    _headimg = NULL;
    _shipaddress = NULL;
    _identity = NULL;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
   [aCoder encodeObject:self.cid forKey:@"cid"];
    [aCoder encodeObject:self.headimg forKey:@"headimg"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _cid = [aDecoder decodeObjectForKey:@"cid"];
        _headimg = [aDecoder decodeObjectForKey:@"headimg"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}



@end
