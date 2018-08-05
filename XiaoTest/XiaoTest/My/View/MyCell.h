//
//  MyCell.h
//  XiaoTest
//
//  Created by shen on 2018/6/13.
//  Copyright © 2018年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol MyCellProtocol <NSObject>

- (void)handleSeletedCell:(NSString *)seletedStr;

@end


@interface MyCell : UITableViewCell

- (void)configureModelWithimgArr:(NSArray *)imgArr
                        titleArr:(NSArray *)titleArr;

@property (assign, nonatomic)id<MyCellProtocol>delegate;

@end
