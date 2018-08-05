//
//  HomeViewController.m
//  XiaoTest
//
//  Created by shen on 2018/7/9.
//  Copyright © 2018年 shen. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDetailViewController.h"
#import "HeaderViewCell.h"
#import "HomeModel.h"
#import "HomeFistrCell.h"
#import "HomeSecondCell.h"
#import "HomeThirdCell.h"
#import "HomeSearchCell.h"

typedef NS_ENUM(NSInteger, UICollectionViewState) {
    UICollectionViewStateFirst,
    UICollectionViewStateSecond
};

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,HomeSearchCellDelegate,AlertViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *header1Btn;
@property (weak, nonatomic) IBOutlet UIButton *header2Btn;
@property (weak, nonatomic) IBOutlet UIView *headerLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineX;

@end



@implementation HomeViewController{
    UICollectionViewState collectionState;
    AlertView *alert;
    UIView *baseView;
    UIView *control;
    NSMutableArray *leaseunitArr1;
    NSMutableArray *leaseunitArr2;
    NSInteger sesionItem;
    NSInteger sesionItem2;
}

#define viewheight KscreenHeight - 64 - 44

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, viewheight)];
        _scrollView.contentSize = CGSizeMake(KscreenWidth * 2, viewheight);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth * 2, viewheight)];
        [_scrollView addSubview:baseView];
    }
    return _scrollView;
}

- (void)handleSignSuccessBlock{
    [self showLoadingHUD];
    [self postWithURLString:[NSString stringWithFormat:@"%@/base/getProduct",KBaseUrl] parameters:nil success:^(id _Nullable success) {
        [self hiddenAlert];
        [self hiddenLoadingHUD];
        leaseunitArr1 = [NSMutableArray array];
        NSDictionary *dataArr = success[@"data"];
        for (NSDictionary *dic in dataArr) {
            HomeModel *model = [[HomeModel alloc] init];
            [model configureHomeModelWithDictionary:dic];
            [leaseunitArr1 addObject:model];
        }
        if ((leaseunitArr1.count - 1) % 2 == 0) {
            sesionItem = (leaseunitArr1.count - 1) / 2;
        }else{
            sesionItem = (leaseunitArr1.count - 1) / 2 + 1;
        }
        UICollectionView *collectionView = [_scrollView viewWithTag:6666];
        [collectionView reloadData];
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
        [self showAlert];
        [self hiddenLoadingHUD];
    }];
    [self postWithURLString:[NSString stringWithFormat:@"%@/base/getUsedProduct",KBaseUrl] parameters:nil success:^(id _Nullable success) {
        NSLog(@"%@",success);
        leaseunitArr2 = [NSMutableArray array];
        NSDictionary *dataArr = success[@"data"];
        for (NSDictionary *dic in dataArr) {
            HomeModel *model = [[HomeModel alloc] init];
            [model configureHomeModelWithDictionary:dic];
            [leaseunitArr2 addObject:model];
        }
        if (leaseunitArr2.count % 2 == 0) {
            sesionItem2 = leaseunitArr2.count / 2;
        }else{
            sesionItem2 = leaseunitArr2.count / 2 + 1;
        }
        UICollectionView *collectionView = [_scrollView viewWithTag:6667];
        [collectionView reloadData];
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}

- (void)handlePushServiceDelegate:(NSString *)linkStr{
    if (linkStr) {
        [self postWithURLString:[NSString stringWithFormat:@"%@/book/addLink",KBaseUrl] parameters:@{@"link":linkStr} success:^(id _Nullable data) {
            NSString *code = [NSString stringWithFormat:@"%@",data[@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self showTitleHUD:@"您已提交审核,请注意进度" wait:1 completion:^{

                }];
            }
            
        } failure:^(NSString * _Nullable error) {
            NSLog(@"%@",error);
            [self hiddenLoadingHUD];
        }];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    leaseunitArr1 = [NSMutableArray array];
    leaseunitArr2 = [NSMutableArray array];
    [self.view addSubview:self.scrollView];
    collectionState = UICollectionViewStateFirst;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    for (NSInteger i = 0; i < 2; i++) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.tag = 6666 + i;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [baseView addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(@0);
            make.left.mas_offset(KscreenWidth * i);
            make.width.mas_offset(KscreenWidth);
            make.bottom.mas_offset(@0);
        }];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeThirdCell" bundle:nil] forCellWithReuseIdentifier:@"HomeThirdCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeSecondCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSecondCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HeaderViewCell" bundle:nil] forCellWithReuseIdentifier:@"HeaderViewCell"];
        if (_collectionView.tag == 6666) {
            [_collectionView registerNib:[UINib nibWithNibName:@"HomeFistrCell" bundle:nil] forCellWithReuseIdentifier:@"HomeFistrCell"];
        }else{
            [_collectionView registerNib:[UINib nibWithNibName:@"HomeSearchCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSearchCell"];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignSuccessBlock) name:Sign_Success object:nil];
    [self handleSignSuccessBlock];
    if (!NSUserDefaultsGet(Session_token)) {
        [self getToken];
    }else{
        [self getCustomInfo];
        UserModel *model = [UserModel defaultModel];
        UserModel *oldModle = [self getObjectArchiverWithDB_Name:@"user_db"];
        model.cid = oldModle.cid;
        model.phone = oldModle.phone;
        model.name = oldModle.name;
        model.headimg = oldModle.headimg;
        NSLog(@"%@",model.phone);
    }
    
    // Do any additional setup after loading the view.
}

- (void)showAlert{
    if (!alert) {
        alert = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) AlertImg:[UIImage imageNamed:@"trade_netWork"] AlertTitle:@"网络连接失败"];
        alert.delegate = self;
        [self.view bringSubviewToFront:alert];
    }
    
}

- (void)hiddenAlert{
    if (alert) {
        [alert removeFromSuperview];
        alert = nil;
    }
}

- (void)handleProtocolAlert:(NSString *)alertMessage{
    [self handleSignSuccessBlock];
}

- (void)getCustomInfo{
    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/getCustomInfo",KBaseUrl] parameters:nil success:^(id _Nullable data) {
        NSLog(@"%@",data);
        NSDictionary *dic = data[@"data"];
        UserModel *model = [UserModel defaultModel];
        model.isSign = YES;
        [model configureSignInModelWithDictionary:dic];
    } failure:^(NSString * _Nullable error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - UICollectionViewDelegate,Datasource -
//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView.tag == 6666) {
        return 3 + sesionItem;
    }
    return 2 + sesionItem2;
   
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 6666) {
        if (section == 0 || section == 1 || section == 2) {
            return 1;
        }
        if ((leaseunitArr1.count - 1) % 2 != 0) {
            if (section == sesionItem + 2) {
                return 1;
            }
            return 2;
        }
        return 2;
        
    }
    if (section == 0 || section == 1) {
        return 1;
    }
    if (leaseunitArr2.count % 2 != 0) {
        if (section == sesionItem2 + 1) {
            return 1;
        }
        return 2;
    }
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 6666) {
        if (indexPath.section == 0) {
            HeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderViewCell" forIndexPath:indexPath];
            [cell configureModel:[leaseunitArr1 firstObject]];
            return cell;
        }else if (indexPath.section == 1){
            HomeFistrCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFistrCell" forIndexPath:indexPath];
            return cell;
        }else if (indexPath.section == 2){
            HomeSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSecondCell" forIndexPath:indexPath];
            NSInteger index = indexPath.item + 2 * (indexPath.section - 3);
            if (leaseunitArr1.count > 0) {
               [cell configureModel:leaseunitArr1[0]];
            }
            return cell;
        }else{
            HomeThirdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeThirdCell" forIndexPath:indexPath];
            NSInteger index = indexPath.item + 2 * (indexPath.section - 3);
            if (index < leaseunitArr1.count) {
              [cell configureModel:leaseunitArr1[index + 1]];
            }
            
            return cell;
        }
    }
    if (indexPath.section == 0) {
        HeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        HomeSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSearchCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else{
        HomeThirdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeThirdCell" forIndexPath:indexPath];
        NSInteger index = indexPath.item + 2 * (indexPath.section - 2);
        if (index < leaseunitArr2.count) {
            [cell configureModel:leaseunitArr2[index]];
        }
        return cell;
    }
    
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView.tag == 6666) {
        if (section == 0) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }else if (section == 1){
            return UIEdgeInsetsMake(15, 0, 0, 0);
        }else if (section == 2){
            return UIEdgeInsetsMake(15, 0, 0, 0);
        }else{
            return UIEdgeInsetsMake(15, 20, 15, 20);
        }
    }
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (section == 1){
        return UIEdgeInsetsMake(15, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(15, 20, 15, 20);
    }
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 6666) {
        if (indexPath.section == 0) {
            return CGSizeMake(KscreenWidth, 215);
        }else if (indexPath.section == 1){
            return CGSizeMake(KscreenWidth, 175);
        }else if (indexPath.section == 2){
            return CGSizeMake(KscreenWidth, 120);
        }else{
            return CGSizeMake((KscreenWidth - 70) / 2, 177);
        }
    }
    if (indexPath.section == 0) {
        return CGSizeMake(KscreenWidth, 215);
    }else if (indexPath.section == 1){
        return CGSizeMake(KscreenWidth, 30);
    }else{
        return CGSizeMake((KscreenWidth - 70) / 2, 177);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model;
    
    if (collectionView.tag == 6666) {
        if (indexPath.section < 2) {
            return;
        }
        if (indexPath.section == 2) {
            if (leaseunitArr1.count > 0) {
              model = leaseunitArr1[0];
            }

        }else{
            NSInteger index = indexPath.item + 2 * (indexPath.section - 3);
            if (index < (leaseunitArr1.count - 1)) {
                model = leaseunitArr1[index + 1];
            }
        }
        
    }else{
        NSInteger index = indexPath.item + 2 * (indexPath.section - 2);
        if (indexPath.section < 2) {
            return;
        }
        if (index < leaseunitArr2.count) {
            model = leaseunitArr2[index];
        }
    }
    HomeDetailViewController *detailVc = [[HomeDetailViewController alloc] init];
    detailVc.hidesBottomBarWhenPushed = YES;
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (IBAction)handleTouchHeader1:(UIButton *)sender {
    [_header1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_header2Btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _lineX.constant = -30.0f;
    [self.view updateConstraintsIfNeeded];
    collectionState = UICollectionViewStateFirst;
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (IBAction)handleTouchHeader2:(UIButton *)sender {
    [_header2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_header1Btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _lineX.constant = 30.0f;
    [self.view updateConstraintsIfNeeded];
    collectionState = UICollectionViewStateSecond;
    [_scrollView setContentOffset:CGPointMake(KscreenWidth, 0) animated:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = _scrollView.contentOffset.x / KscreenWidth;
    if (page == 0) {
        [_header1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_header2Btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _lineX.constant = -30.0f;
        [self.view updateConstraintsIfNeeded];
        collectionState = UICollectionViewStateFirst;
    }else{
        [_header2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_header1Btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _lineX.constant = 30.0f;
        [self.view updateConstraintsIfNeeded];
         collectionState = UICollectionViewStateSecond;
    }
}

//获取sessiontoken
//- (void)getToken{
//    [self postWithURLString:[NSString stringWithFormat:@"%@/custom/getYzmToken",KBaseUrl] parameters:nil success:^(id _Nullable responseObject) {
//        NSString *token = [responseObject valueForKey:@"data"];
//        if (token) {
//            NSUserDefaultsSave(token, Session_token);
//            SignViewController *vc = [[SignViewController alloc] init];
//            if (![[NSUserDefaults standardUserDefaults] valueForKey:Old_User]) {
//                vc.isRegist = YES;
//            }
//            [self presentViewController:vc animated:YES completion:nil];
//        }
//    } failure:^(NSString * _Nullable error) {
//        NSLog(@"获取token失败:%@",error);
//    }];
//}

//  键盘弹出触发该方法
- (void)keyboardDidShow:(NSNotification *)noti
{
    //获取键盘的高度
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    if (!control) {
        control =  [[UIView alloc] initWithFrame:self.view.window.frame];
        UITapGestureRecognizer *tapCan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRemoveSelf)];
        UIPanGestureRecognizer *panCan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRemoveSelf)];
        [control addGestureRecognizer:tapCan];
        [control addGestureRecognizer:panCan];
        [self.view.window addSubview:control];
    }
    [self.view.window addSubview:control];
}
//  键盘隐藏触发该方法
- (void)keyboardDidHide:(NSNotification *)noti
{
    
}

- (void)cancelRemoveSelf{
    [self.view endEditing:YES];
    [control removeFromSuperview];
    control = nil;
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
