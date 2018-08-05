//
//  MessageViewCell.m
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "MessageViewCell.h"

@implementation MessageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureModle:(MessageModel *)model{
    if ([model.message_isread isEqualToString:@"1"]) {
        self.contentView.alpha = 0.7;
    }else{
        self.contentView.alpha = 1;
    }
    if ([model.message_state isEqualToString:@"3"] && [model.message_isLinkMsg isEqualToString:@"1"]) {
        _content.textColor = [UIColor blueColor];
    }else{
        _content.textColor = [UIColor darkGrayColor];
    }
    _content.text = model.message_content;
    _date.text = model.message_crtdate;
    _title.text = model.message_title;
}

- (IBAction)handleExted:(id)sender {
    [self.delegate handleExtedBtn:_setion];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
