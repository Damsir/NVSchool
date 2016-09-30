//
//  SearchViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "CatagoryJsonData.h"
#import "CategoryProductViewController.h"
#import "CustomPickerView.h"
@interface SearchViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
//    UIPickerView *pickView;
    CustomPickerView *pickView;
    NSMutableArray *categoryList;
    NSArray *subCategoryList;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self laodData];
    [self setMainArrange];
}
-(void)laodData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSDictionary *dict = @{@"command":@"all_category",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"type":@"0",@"channel":@"5001.1007.1001"};
    [manager POST:CATEGORY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CatagoryJsonData *cateData = [[CatagoryJsonData alloc]initWithString:operation.responseString error:nil];
        
        categoryList  = [[NSMutableArray alloc]initWithArray:cateData.categoryList];
        
        categoryData *categoryData =categoryList[0];
        subCategoryList = categoryData.subCategory;
        
        [pickView reloadAllComponents];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)setMainArrange
{
    pickView=[[CustomPickerView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.width)];
//    pickView.backgroundColor=[UIColor yellowColor];
    
    pickView.delegate=self;
    pickView.dataSource=self;

    pickView.showsSelectionIndicator=YES;
    [self.view addSubview:pickView];
    
}
//返回选择器的个数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
//返回当前行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    if (categoryList.count) {
    if (component==0) {
        return categoryList.count;
        }
    if (component ==1) {
        return subCategoryList.count;
        }
    }
    return 10;
}
//返回当前行内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (categoryList.count) {
    categoryData *cateData =categoryList[row];
    if (component==0) {
        return cateData.name;
    }
    subCataGoryData *subCateData = subCategoryList[row];
    return subCateData.name;
    }
    return @"加载ing";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        categoryData *categoryData =categoryList[row];
        subCategoryList = categoryData.subCategory;
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
    }
    else
    {
        subCataGoryData *subCateData = subCategoryList[row];
        CategoryProductViewController *categoryVC = [[CategoryProductViewController alloc] init];
        categoryVC.categoryId = subCateData.my_id;
        [self.navigationController pushViewController:categoryVC animated:YES];
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component ==0)
    {
    return self.view.frame.size.width/5*2;
    }
    return self.view.frame.size.width/5*3;
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *myView = nil;
//    if (categoryList.count) {
//        categoryData *cateData =categoryList[row];
//        if (component==0) {
//            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)] ;
//            myView.textAlignment = NSTextAlignmentCenter;
//            myView.text = cateData.name;
//            myView.font = [UIFont systemFontOfSize:14];
//            myView.backgroundColor = [UIColor clearColor];
//             return myView;
//        }
//        subCataGoryData *subCateData = subCategoryList[row];
//        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
//        myView.text =subCateData.name;
//        myView.textAlignment = NSTextAlignmentCenter;
//        myView.font = [UIFont systemFontOfSize:14];
//        myView.backgroundColor = [UIColor clearColor];
//         return myView;
//    }
//    return myView;
//}
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
