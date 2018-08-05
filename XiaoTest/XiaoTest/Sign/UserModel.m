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
}

- (void)logOut{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:Session_token];
    _isSign = NO;
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
