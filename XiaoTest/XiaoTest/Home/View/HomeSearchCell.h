//
//  HomeSearchCell.h
//  XiaoTest
//
//  Created by shen on 2018/7/9.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeSearchCellDelegate <NSObject>

- (void)handlePushServiceDelegate:(NSString *)linkStr;

@end

@interface HomeSearchCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (assign, nonatomic) id <HomeSearchCellDelegate>delegate;

@end
