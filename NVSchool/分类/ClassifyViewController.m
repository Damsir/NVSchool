//
//  ClassifyViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "ClassifyViewController.h"
//使用首页的cell
#import "MainCollectionViewCell.h"
//
#import "ChooseSchoolVC.h"
#import "CityProductsData.h"
#import "MapViewController.h"
#import "map.h"
#import "LeftSortsViewController.h"

#import "CatagoryNetData.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MainDetailGoodVC.h"
@interface ClassifyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SchoolVCChangeDelegate,ViewMapChangeDelegate,leftSortchangDataDelegate>
{
    __weak IBOutlet UICollectionView * collectionVi;
    CityProductsData *cityProductsData;
    CityModel *currentCity;
    map *mapView;
    CatagoryNetData *cateNetData;
}
@end

@implementation ClassifyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setMainArrange];
    
    [self chooseCityAndLoadNetData];
    
    [self loadNetData];
}
-(void)chooseCityAndLoadNetData
{

    if (currentCity) {
        [self loadNetData];
    }
    else
    {
        mapView = [[map alloc] init];
        mapView.backgroundColor = [UIColor lightGrayColor];
        mapView.alpha = 0.5;
        mapView.delegate = self;
        mapView.frame = self.view.bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(tapmapView:)];
        [mapView addGestureRecognizer:tap];
        [self.view addSubview:mapView];
        [mapView startPosition];
    }
}
-(void)tapmapView :(UIGestureRecognizer*)tap;
{
    UIView *view= tap.view;
    [view removeFromSuperview];
}
-(void)loadNetData
{
    cateNetData = [[CatagoryNetData alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES ];
    [collectionVi addHeaderWithTarget:self action:@selector(headerRefresh)];
    [collectionVi addFooterWithTarget:self action:@selector(footerLoadMore)];
    
    self.searchType = @"0";
    self.categoryId = @"21";
    [self headerRefresh];
}
//下拉刷新
-(void)headerRefresh
{
    
    [cateNetData loadCategoryNetDataWith:self.categoryId  and:self.searchType and:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            [collectionVi reloadData];
            [collectionVi headerEndRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
    [cateNetData loadCategoryMoreData:^(BOOL isSuccess, NSError *error) {
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
-(void)setMainArrange
{
    collectionVi.backgroundColor = [UIColor whiteColor];
    UINib *cellNib = [UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil];
    
    [collectionVi registerNib:cellNib forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStylePlain target:self action:@selector(addMap)];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(chooseMessage)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 40);
    [button setTitle:@"武汉➕" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(chooseCity) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.navigationItem.titleView =button;
}
-(void)addMap
{
    MapViewController *mapVc = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapVc animated:NO];
}
-(void)chooseMessage
{
    LeftSortsViewController *leftVc = [[LeftSortsViewController alloc]init];
    leftVc.delegate = self;
    [self.navigationController pushViewController:leftVc animated:YES];
}
-(void)chooseCity
{
    ChooseSchoolVC *chooseCityVc = [[ChooseSchoolVC alloc] init];
    chooseCityVc.delegate = self;
    [self.navigationController pushViewController:chooseCityVc animated:NO];
    
}
#pragma mark--CollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    if (cateNetData.goodsArray.count) {
//        return cateNetData.goodsArray.count;
//    }
//    return 40;
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (cateNetData.goodsArray.count) {
        return cateNetData.goodsArray.count;
    }
    return 40;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"MainCollectionViewCell" forIndexPath:indexPath];
    
    JSData *goodData = [[JSData alloc] init];
    if (cateNetData.goodsArray.count) {
        goodData = [cateNetData.goodsArray objectAtIndex:indexPath.row];
    }
    [cell SetUIWith:goodData];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSData *goodData = [cateNetData.goodsArray objectAtIndex:indexPath.row];
    MainDetailGoodVC *vc = [[MainDetailGoodVC alloc]init];
    vc.product_id =goodData.my_id;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2-20, 180);
}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    return [[UICollectionReusableView alloc]init];
//}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 	50);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
//返回改变城市
-(void)changeCityWith:(CityModel *)city
{
    mapView = nil;
    [self loadNetData];
}
-(void)changeDataWith:(NSString *)categoryId
{
    self.categoryId = categoryId;
    [self headerRefresh];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
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
