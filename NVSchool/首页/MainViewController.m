//
//  MainViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MainViewController.h"

//自定义cell
#import "MainCellView.h"
//扫一扫
#import "ScanfQRVC.h"
//学校切换
#import "SearchViewController.h"

#import "MainNetData.h"

#import "MainDetailGoodVC.h"

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,MainCellPushDelegate>
{
  UICollectionView *collectionVi;
    MainNetData *mainData;
    UIScrollView *buttonView;
//    scroll和collection的联动
    int num;
}
@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//
    [self loadNetData];
//
    [self createNavigation];
//    整体布局
    [self setMainArrange];
    
}
//    整体布局
-(void)setMainArrange
{

    buttonView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    buttonView.delegate = self;
    buttonView.showsHorizontalScrollIndicator = NO;
    buttonView.bounces = NO;
    [self.view addSubview:buttonView];
    
    float h_height = self.view.frame.size.height-CGRectGetMaxY(buttonView.frame)-64-49;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    collectionVi  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonView.frame), self.view.frame.size.width,h_height) collectionViewLayout:layout];
    
    [self.view  addSubview:collectionVi];
    collectionVi.delegate = self;
    collectionVi.dataSource = self;
  
    collectionVi.backgroundColor = [UIColor redColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"MainCellView" bundle:nil];
    [collectionVi registerNib:cellNib forCellWithReuseIdentifier:@"MainCellView"];
    
    collectionVi.pagingEnabled = YES;
    collectionVi.bounces = NO;
    collectionVi.showsHorizontalScrollIndicator = NO;
}

//创建navigation 左侧扫一扫功能,和右侧选择
- (void)createNavigation{
//    左侧扫一扫
    UIButton *scanfBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [scanfBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [scanfBtn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    scanfBtn.frame=CGRectMake(0, 0, 30, 40);
    scanfBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [scanfBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:scanfBtn];
    
    scanfBtn.titleEdgeInsets=UIEdgeInsetsMake(25, -30, 0, 0);
    [scanfBtn addTarget:self action:@selector(scanQR) forControlEvents:UIControlEventTouchUpInside];
    
//    右侧加载更多
    UIButton *changeSCBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [changeSCBtn setImage:[[UIImage imageNamed:@"ym_search_icon_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

    changeSCBtn.frame=CGRectMake(0, 0, 40, 40);
    changeSCBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [changeSCBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:changeSCBtn];
    
    changeSCBtn.titleEdgeInsets=UIEdgeInsetsMake(25, -30, 0, 0);
    [changeSCBtn addTarget:self action:@selector(changeSchool) forControlEvents:UIControlEventTouchUpInside];
    
//    中间学校名
    self.navigationItem.title = @"闲货";
    
}

// 扫一扫功能实现
- (void)scanQR{
    ScanfQRVC *scVC = [[ScanfQRVC alloc] init];
    [self.navigationController pushViewController:scVC animated:NO];
}
//选择学校
-(void)changeSchool
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:NO];
}
//请求页面数据
-(void)loadNetData
{
    mainData = [[MainNetData alloc] init];
    [mainData loadMainNetDataWith:0 and:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            [collectionVi reloadData];
            [self creatButton];
        }
        else if (error)
        {
            NSLog(@"网络请求错误");
        }
    }];
}
-(void)creatButton
{
    CGFloat btn_w = self.view.frame.size.width/4;
    int count =(int)mainData.jsonData.labelList.count;
    buttonView.contentSize = CGSizeMake(btn_w*count, 40);
    for (int i= 0; i<count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        [button addTarget:self action:@selector(changeGoodsDataWith:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(btn_w*i, 0, btn_w, 40);
        JSData *data = mainData.jsonData.labelList[i];
        
        [button setTitle:data.labelName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [buttonView addSubview:button];
    }
}
//button 切换界面
-(void)changeGoodsDataWith:(UIButton *)btn
{
    num = (int)btn.tag-100;
    for (int i=0;i<8;i++) {
        UIButton *button = (UIButton*)[buttonView viewWithTag:100+i];
        button.backgroundColor = [UIColor whiteColor];
        if (i==num) {
            button.backgroundColor = [UIColor darkGrayColor];
        }
    }
    collectionVi.contentOffset = CGPointMake(num*collectionVi.frame.size.width, 0);
}

#pragma mark--UICOllectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (mainData.jsonData.labelList.count) {
        return mainData.jsonData.labelList.count;
    }
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCellView" forIndexPath:indexPath];
    cell.delegare = self;
    cell.index = (int)indexPath.row;
    return cell;
}
//设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionVi.frame.size.width, collectionVi.frame.size.height);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == collectionVi) {
        num = collectionVi.contentOffset.x/collectionVi.frame.size.width;
        if (num<5) {
        buttonView.contentOffset = CGPointMake(self.view.frame.size.width*num/4, 0);
        }
        for (int i=0;i<8;i++) {
            UIButton *button = (UIButton*)[buttonView viewWithTag:100+i];
            button.backgroundColor = [UIColor whiteColor];
            if (i==num) {
                button.backgroundColor = [UIColor darkGrayColor];
            }
        }
    }
}
//cell 的点击代理函数
-(void)pushToViewControll:(UIViewController *)ViewCont
{
    [self.navigationController pushViewController:ViewCont animated:YES];
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
