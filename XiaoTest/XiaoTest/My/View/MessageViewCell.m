//
//  MessageViewCell.m
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "MessageViewCell.h"


@implementation MessageViewCell{
    TYAttributedLabel *lable;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureModle:(MessageModel *)model{
    if (lable) {
        [lable removeFromSuperview];
        lable = nil;
    }
    lable = [[TYAttributedLabel alloc] initWithFrame:CGRectZero];
    lable.delegate = self;
    lable.font = [UIFont systemFontOfSize:13];
    lable.numberOfLines = 0;
    lable.text = model.message_content;
    [_baseView addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(@0);
    }];
    if ([model.message_isread isEqualToString:@"1"]) {
        self.contentView.alpha = 0.7;
    }else{
        self.contentView.alpha = 1;
    }
    
    if ([model.message_isLinkMsg isEqualToString:@"1"]) {
        lable.text = model.message_content;
        [lable appendLinkWithText:@"立即申请" linkFont:[UIFont systemFontOfSize:12] linkColor:[UIColor blueColor] linkData:@"link"];
    }
    _date.text = model.message_crtdate;
    _title.text = model.message_title;
}

- (IBAction)handleExted:(id)sender {
    [self.delegate handleExtedBtn:_setion];
    
}

#pragma mark - Delegate
//TYAttributedLabelDelegate
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point {
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(handlePushOrder:)]) {
            [self.delegate handlePushOrder:_setion];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
