//
//  MessageViewCell.h
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "TYAttributedLabel.h"

@protocol MessageViewCellDelegate<NSObject>

- (void)handleExtedBtn:(NSInteger)setion;

- (void)handlePushOrder:(NSInteger)setion;

@end


@interface MessageViewCell : UITableViewCell<TYAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (weak, nonatomic) IBOutlet UIButton *extedBtn;
@property (assign, nonatomic) NSInteger setion;

@property (assign, nonatomic) id<MessageViewCellDelegate>delegate;
- (void)configureModle:(MessageModel *)model;

@end
