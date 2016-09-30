//
//  ChooseSchoolVC.m
//  NVSchool
//
//  Created by qianfeng on 15/9/30.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "ChooseSchoolVC.h"
#import "SchoolTableCell.h"
#import "AFNetworking.h"
@interface ChooseSchoolVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SchoolTableCellDelegate>
{
//数据源数组
    NSMutableArray *citysModelArr;
//右侧快捷键
    NSArray *suoYinArray;
//搜索结果数组
    NSMutableArray * resultArray;
//联系人tableView
    UITableView *table;
    
    UISearchBar *schoolSearch;
    BOOL  searchBarIsEdit;
    NSArray *citysArr ;
}
@end

@implementation ChooseSchoolVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    citysModelArr = [[NSMutableArray alloc] init];
    suoYinArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    resultArray = [NSMutableArray array] ;
    citysArr = [[NSArray alloc] init];
    [self setMainArrange];
    [self loadCityData];
}
-(void)loadCityData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = @{@"command":@"get_nearby_city",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"channel":@"5001.1007.1001"};
    [manager POST:GET_CITY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *cityDic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:
                                 NSJSONReadingAllowFragments error:nil];
        citysArr = [cityDic objectForKey:@"cityList"];
        
        for (int i = 0; i<suoYinArray.count; i++) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int j =0;j<citysArr.count; j++) {
                NSDictionary *city = citysArr[j];
                CityModel *cityData = [[CityModel alloc]init];
                cityData.my_id = city[@"id"];
                cityData.displayName = city[@"displayName"];
                cityData.searchName = city[@"searchName"];
                cityData.letter = city[@"letter"];
                cityData.longitude = city[@"longitude"];
                cityData.latitude = city[@"latitude"];
                
                if ([cityData.letter isEqualToString:suoYinArray[i]]) {
                    [array addObject:cityData];
                }
            }
            [citysModelArr addObject:array];
        }
        [table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)setMainArrange
{
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    //清空 空cell
    table.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    UINib *cellNib = [UINib nibWithNibName:@"SchoolTableCell" bundle:nil];
    [table registerNib:cellNib forCellReuseIdentifier:@"SchoolTableCell"];
    [self.view addSubview:table];
    //设置标题
    self.navigationItem.title=@"选择城市";
    
    //创建搜索视图*****************************
    //搜索框
    schoolSearch=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    schoolSearch.searchBarStyle=UISearchBarStyleDefault;
    //设置提醒文字
    schoolSearch.placeholder=@"请输入....";
    schoolSearch.showsCancelButton=NO;
    schoolSearch.delegate=self;
    schoolSearch.returnKeyType = UIReturnKeyDone;
    searchBarIsEdit = NO;
    
    table.tableHeaderView=schoolSearch;
}
#pragma mark--UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (searchBarIsEdit) {
        return 1;
    }
    else

        return citysModelArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchBarIsEdit) {
        return resultArray.count ;
    }
    else
    {
        return [citysModelArr[section] count];
    }
}
//制作cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolTableCell"];
    cell.delegate = self;
    if (searchBarIsEdit) {
        //给cell上的控件赋值
        CityModel *city = resultArray[indexPath.row];
        [cell setUIWith:city];
    }
    else{
        //给搜索结果的cell进行赋值
        CityModel *city = citysModelArr[indexPath.section][indexPath.row];

        [cell setUIWith:city];
    }
    return cell;
}
//设置头部标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (searchBarIsEdit) {
        return nil;
    }
    else
    {
        return suoYinArray[section];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//设置右侧快捷索引键
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (searchBarIsEdit) {
        return nil;
    }
    else
    {
        return suoYinArray;
    }
}
//cell 选择函数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityModel *city = [[CityModel alloc] init];
    if (searchBarIsEdit) {
        city = resultArray[indexPath.row];
    }
    else
    {
        city = citysModelArr[indexPath.section][indexPath.row];
    }
    [self.delegate changeCityWith:city];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--UISearchDelegate
//只要搜索框中的文字发生改变就会调用该方法
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchBarIsEdit = YES;
    if (resultArray.count!=0) {
        [resultArray removeAllObjects];
    }
    NSString *string=searchBar.text;
    //将空格用空替代
    string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    for (NSDictionary *city in citysArr) {
            if ([city[@"displayName"] rangeOfString:string].location !=NSNotFound) {
                CityModel *cityData = [[CityModel alloc]init];
                cityData.my_id = city[@"id"];
                cityData.displayName = city[@"displayName"];
                cityData.searchName = city[@"searchName"];
                cityData.letter = city[@"letter"];
                cityData.longitude = city[@"longitude"];
                cityData.latitude = city[@"latitude"];
                [resultArray addObject:cityData];
            }
        }
    [table reloadData];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [resultArray removeAllObjects];

    searchBarIsEdit =NO;
    [table reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}
//cell.image选择代理事件
-(void )showBigImage:(UIImage*)image
{
    UIImageView *bigImage = [[UIImageView alloc] initWithImage:image];
    bigImage.frame = self.view.bounds;
    [self.view addSubview:bigImage];
    
    bigImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    tapTwo.numberOfTouchesRequired = 1;
    tapTwo.numberOfTapsRequired = 2;
    [bigImage addGestureRecognizer:tapTwo];
}
-(void)imageTap:(UITapGestureRecognizer*)gesture
{
    UIImageView *imageVi = (UIImageView *)gesture.view;
    [imageVi removeFromSuperview];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    searchBarIsEdit = NO;
     self.tabBarController.tabBar.translucent = NO;
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
