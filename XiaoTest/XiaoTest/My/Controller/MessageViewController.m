//
//  MessageViewController.m
//  XiaoTest
//
//  Created by shen on 2018/8/4.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "MessageViewController.h"
#import "OrderViewController.h"
#import "MessageViewCell.h"
#import "MessageModel.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,MessageViewCellDelegate>
@property(strong, nonatomic) UITableView *tableView;
@end

@implementation MessageViewController{
    NSMutableArray *dataSource;
    AlertView *alert;
}

- (void)loadMessageInfo{
    [self postWithURLString:[NSString stringWithFormat:@"%@/base/getNotify",KBaseUrl] parameters:nil success:^(id _Nullable data) {
        NSLog(@"%@",data);
        NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([code isEqualToString:@"1"]) {
            for (NSDictionary *dic in data[@"data"]) {
                MessageModel *model = [[MessageModel alloc] init];
                model.isExeted = NO;
                model.message_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
                model.message_title = [NSString stringWithFormat:@"%@",dic[@"title"]];
                model.message_content = [NSString stringWithFormat:@"%@",dic[@"content"]];
                model.message_state = [NSString stringWithFormat:@"%@",dic[@"state"]];
                model.message_isLinkMsg = [NSString stringWithFormat:@"%@",dic[@"islinkmsg"]];
                model.message_isread = [NSString stringWithFormat:@"%@",dic[@"isread"]];
                model.message_crtdate = [NSString stringWithFormat:@"%@",dic[@"crtdate"]];
                CGSize strSize = [dic[@"content"] boundingRectWithSize:CGSizeMake(KscreenWidth - 60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                model.message_height = 60.0 + strSize.height;
                [dataSource addObject:model];
            }
            if (dataSource.count > 0) {
                [_tableView reloadData];
                if (alert) {
                    [alert removeFromSuperview];
                    alert = nil;
                }
            }else{
                alert = [[AlertView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight - 64) AlertImg:[UIImage imageNamed:@"trade_message"] AlertTitle:@"暂无消息"];
                [self.view addSubview:alert];
            }
        }
    } failure:^(NSString * _Nullable error) {
        [self showTitleHUD:error wait:1 completion:nil];
    }];
}


        
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadMessageInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    NaviBarView *navviBar = [[NaviBarView alloc] init];
    navviBar.isLine = YES;
    navviBar.title = @"消息中心";
    [self.view addSubview:navviBar];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(@0);
        make.top.equalTo(navviBar.mas_bottom).mas_offset(@0);
        make.bottom.mas_offset(@0);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MessageViewCell" bundle:nil] forCellReuseIdentifier:@"MessageViewCell"];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = dataSource[indexPath.section];
    return model.message_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.setion = indexPath.section;
    [cell configureModle:dataSource[indexPath.section]];
    return cell;
}

- (void)handlePushOrder:(NSInteger)setion{
    MessageModel *model = dataSource[setion];
    if ([model.message_isLinkMsg isEqualToString:@"1"]) {
        OrderViewController *vc = [[OrderViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.msg_id = model.message_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)handleExtedBtn:(NSInteger)setion{
    MessageModel *model = dataSource[setion];
    if (model.isExeted) {
        model.isExeted = NO;
    }else{
        model.isExeted = YES;
    }
    [dataSource replaceObjectAtIndex:setion withObject:model];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:setion] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
