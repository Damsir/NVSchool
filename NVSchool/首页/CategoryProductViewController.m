//
//  CategoryProductViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "CategoryProductViewController.h"
#import "MainCollectionViewCell.h"
#import "CatagoryNetData.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MainDetailGoodVC.h"
@interface CategoryProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *collectionVi;
    CatagoryNetData *cateNetData;
}
@end

@implementation CategoryProductViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMainArrange];
    [self loadNetData];
}
-(void)setMainArrange
{
    UIView* buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    buttonView.tag = 201;
    buttonView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:buttonView];
    NSArray *titleArray = @[@"综合",@"价格",@"时间"];
    for (int i =0; i<3;i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3*i, 0, self.view.frame.size.width/3, 40)];
        button.tag = 100+i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
    }
    
    float h_height = self.view.frame.size.height-64-20;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    collectionVi  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonView.frame), self.view.frame.size.width,h_height) collectionViewLayout:layout];
    
    [self.view  addSubview:collectionVi];
    collectionVi.delegate = self;
    collectionVi.dataSource = self;
    
    collectionVi.backgroundColor = [UIColor whiteColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil];
    [collectionVi registerNib:cellNib forCellWithReuseIdentifier:@"MainCollectionViewCell"];
}
-(void)loadNetData
{
    cateNetData = [[CatagoryNetData alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES ];
    [collectionVi addHeaderWithTarget:self action:@selector(headerRefresh)];
    [collectionVi addFooterWithTarget:self action:@selector(footerLoadMore)];

     self.searchType = @"0";
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
-(void)changeData :(UIButton*)btn
{
    UIView *buttonView =[self.view viewWithTag:201];
    for (int i=0; i<3; i++) {
        UIButton *butt = (UIButton *)[buttonView viewWithTag:100+i];
        if (i==btn.tag-100) {
            [butt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else
        {
        [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    NSString *searchType = [NSString stringWithFormat:@"%ld",btn.tag-100];
    self.searchType = searchType;
    [self headerRefresh];
}
#pragma mark--UICOllectionViewDelegate
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
//设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2-20, 180);
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
///cell 的点击函数
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSData *goodData = [cateNetData.goodsArray objectAtIndex:indexPath.row];
    MainDetailGoodVC *vc = [[MainDetailGoodVC alloc]init];
    vc.product_id =goodData.my_id;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
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
