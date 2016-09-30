//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "CatagoryJsonData.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *fatherTable;
    UITableView *sonTable;
    NSMutableArray *fatherList;
    NSArray *sonList;
}

@end

@implementation LeftSortsViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNetData];


    fatherTable= [[UITableView alloc] init];
    fatherTable.frame = CGRectMake(0, 0, self.view.frame.size.width/2-5,self.view.frame.size.height-49);
    fatherTable.dataSource = self;
    fatherTable.delegate  = self;

    sonTable= [[UITableView alloc] init];
    sonTable.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2-5,self.view.frame.size.height-49);
    sonTable.dataSource = self;
    sonTable.delegate  = self;

    [self.view addSubview:fatherTable];
    [self.view addSubview:sonTable];
}
-(void)loadNetData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *dict = @{@"command":@"all_category",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"type":@"0",@"channel":@"5001.1007.1001"};
    [manager POST:CATEGORY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CatagoryJsonData *cateData = [[CatagoryJsonData alloc]initWithString:operation.responseString error:nil];
        
        fatherList  = [[NSMutableArray alloc]initWithArray:cateData.categoryList];
        
        categoryData *categoryData =fatherList[0];
        sonList = categoryData.subCategory;
        
        [fatherTable reloadData];
        [sonTable reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (fatherList.count) {
        if (tableView==fatherTable) {
            return fatherList.count;
        }
        if (tableView ==sonTable) {
            return sonList.count;
        }
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    if (fatherList.count) {
        categoryData *cateData =fatherList[indexPath.row];
        if (tableView==fatherTable) {
            [cell.imageView setImageWithURL:[NSURL URLWithString:cateData.normalIcon.url]];
            cell.textLabel.text = cateData.name;
            return cell;
        }
        subCataGoryData *subCateData = sonList[indexPath.row];
        cell.textLabel.text = subCateData.name;
        return cell;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==fatherTable) {
        categoryData *categoryData =fatherList[indexPath.row];
        sonList = categoryData.subCategory;
    
//        [sonTable selectRowAtIndexPath: indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];

        [sonTable  reloadData];
    }
    else
    {
        subCataGoryData *subCateData = sonList[indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate changeDataWith:subCateData.my_id];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}
@end
