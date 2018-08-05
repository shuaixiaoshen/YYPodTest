//
//  HomeSearchCell.m
//  XiaoTest
//
//  Created by shen on 2018/7/9.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "HomeSearchCell.h"

@implementation HomeSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)handlePushService {
    if (self.delegate && [self.delegate respondsToSelector:@selector(handlePushServiceDelegate:)]) {
        [self.delegate handlePushServiceDelegate:_textField.text];
    }
}


@end
