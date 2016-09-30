//
//  MainCellView.m
//  NVSchool
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MainCellView.h"
#import "MainCollectionViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MainNetData.h"
#import "MainDetailGoodVC.h"

#import "MainCollectionReusableView.h"
@interface MainCellView  ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MainCellPushDelegate,headDetailPushDelegate>
{
   __weak IBOutlet UICollectionView *collectionVi;
    MainNetData *mainData;
}
@end
@implementation MainCellView
- (void)awakeFromNib {
    // Initialization code
    // Do any additional setup after loading the view from its nib.
    
    //    整体布局
    [self setMainArrange];
}

- (void)setIndex:(int)index
{
    _index=index;
     [self loadNetData];
}

//    整体布局
-(void)setMainArrange
{
    collectionVi.backgroundColor =  [UIColor whiteColor];
    
    collectionVi.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UINib *cellNib = [UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil];
    [collectionVi registerNib:cellNib forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    UINib *headNib = [UINib nibWithNibName:@"MainCollectionReusableView" bundle:nil];
    [collectionVi registerNib:headNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainCollectionReusableView"];
    
    [MBProgressHUD showHUDAddedTo:self animated:YES ];
    [collectionVi addHeaderWithTarget:self action:@selector(headerRefresh)];
    [collectionVi addFooterWithTarget:self action:@selector(footerLoadMore)];
}
-(void)loadNetData
{
    mainData = [[MainNetData alloc] init];
    [self headerRefresh];
}
//下拉刷新
-(void)headerRefresh
{
    [mainData loadMainNetDataWith:self.index and:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            [collectionVi reloadData];
            [collectionVi headerEndRefreshing];
            [MBProgressHUD hideHUDForView:self animated:YES];
        }
        else if (error)
        {
            NSLog(@"网络请求错误");
        }
    }];
}
//上拉加载更多  代理函数
-(void)footerLoadMore
{
    [mainData loadMoreData:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            [collectionVi reloadData];
            [collectionVi footerEndRefreshing];
        }
        else if (error)
        {
            NSLog(@"网络请求错误");
        }
    }];
}
#pragma mark--UICOllectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (mainData.goodsArray.count) {
    return mainData.goodsArray.count;
    }
    return 40;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"MainCollectionViewCell" forIndexPath:indexPath];
//    cell.layer.borderWidth = 0.5;
//    cell.layer.borderColor = [UIColor redColor].CGColor;
    JSData *goodData = [[JSData alloc] init];
    if (mainData.goodsArray.count) {
        goodData = [mainData.goodsArray objectAtIndex:indexPath.row];
    }
    [cell SetUIWith:goodData];
    
    return cell;
}
//设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width/2-20, 180);
}
//
//返回collectionView的边缘间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //UIEdgeInsets 通常用来设置一个控件的上、左、下、右、边距
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置collectionView的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
//设置头部
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    MainCollectionReusableView *headView = [collectionVi dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainCollectionReusableView" forIndexPath:indexPath];
    
        headView.delegate=self;
        
        return headView;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.index==0) {
         return CGSizeMake(self.frame.size.width, 200);
    }
    return CGSizeZero;
}
//cell 的点击函数
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSData *goodData = [mainData.goodsArray objectAtIndex:indexPath.row];
    MainDetailGoodVC *vc = [[MainDetailGoodVC alloc]init];
   vc.product_id =goodData.my_id;
    [self.delegare pushToViewControll:vc];
}
// head的点击函数
-(void)pushToViewControll :(UIViewController*)ViewCont
{
    [self.delegare pushToViewControll:ViewCont];
}
@end
