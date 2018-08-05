//
//  MessageViewCell.h
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@protocol MessageViewCellDelegate<NSObject>

- (void)handleExtedBtn:(NSInteger)setion;

@end


@interface MessageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *extedBtn;
@property (assign, nonatomic) NSInteger setion;

@property (assign, nonatomic) id<MessageViewCellDelegate>delegate;
- (void)configureModle:(MessageModel *)model;

@end
