//
//  MessageModel.h
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property(assign, nonatomic) BOOL isExeted;

@property(strong, nonatomic) NSString *message_id;
@property(strong, nonatomic) NSString *message_title;
@property(strong, nonatomic) NSString *message_content;
@property(strong, nonatomic) NSString *message_crtdate;
@property(strong, nonatomic) NSString *message_isread;
@property(strong, nonatomic) NSString *message_state;
@property(strong, nonatomic) NSString *message_isLinkMsg;
@property(assign, nonatomic) CGFloat message_height;
@end
