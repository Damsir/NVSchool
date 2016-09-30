//
//  MapViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AFNetworking.h"
#import "CityModel.h"
@interface MapViewController ()<CLLocationManagerDelegate,UIAlertViewDelegate,MKMapViewDelegate>
{
    CLLocationManager *Cmanager;
    //    地图上显示位置
    MKMapView *mpView;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self startPosition];
//    [self loadMapMark];
}
-(void)loadMapMark
{

    CityModel  *city = [[CityModel alloc] init];
    
//    NSString *latitude =[NSString stringWithFormat:@"%f",[city.latitude floatValue]];
//    NSString *longitude = [NSString stringWithFormat:@"%f",[city.longitude floatValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    command	get_markers_by_level
//    source	android
//    version	3.3.2
//    client_id	864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc
//    level	3
//    version_code	332
//    time	1444985978866
//    channel	5001.1007.1001
//    city	武汉
//    latitude	30.453871
//    longitude	114.428996
    NSDictionary *dic = @{@"command":@"get_markers_by_level",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"level":@"3",@"version_code":@"332",@"time":@"1444985978866",@"channel":@"5001.1007.1001",@"city":@"武汉",@"latitude":@"30.453871",@"longitude":@"114.428996"};
    [manager POST:MAPMARKS parameters:dic  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",MAPMARKS);
        NSLog(@"%@",dic);
//        NSLog(@"%@",operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)startPosition
{
    //    判断地图的定位功能是否能使用
    if ([CLLocationManager locationServicesEnabled]) {
        Cmanager = [[CLLocationManager alloc] init];
        //  在 iOS 7以后info需要配置 允许使用定位功能
        [Cmanager requestAlwaysAuthorization];
        
        Cmanager.delegate = self;
        [Cmanager startUpdatingLocation];
        [Cmanager requestWhenInUseAuthorization];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位功能不能使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        alert.delegate = self;
        [alert show];
    }
//    [self searchLocation];  查找
}
//-(void)searchLocation
//{
//    gecoder = [[CLGeocoder alloc] init];
//    NSString *placeName = @"湖北省武汉市洪山区街道口";
//    [gecoder geocodeAddressString:placeName completionHandler:^(NSArray *placemarks, NSError *error) {
//        if (placemarks.count>0 && error == nil) {
//            NSLog(@"找到了%lu个位置",(unsigned long)placemarks.count);
//        }
//        else if(placemarks.count == 0 &&error ==nil )
//        {
//            NSLog(@"没有找到对应位置");
//        }
//        else
//        {
//            NSLog(@"error");
//        }
//    }];
//}
#pragma MARK -- CLLocationManagerDelegate
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    [Cmanager stopUpdatingLocation];
    CLLocation *newLocatin = [locations lastObject];
    
    mpView  = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mpView.delegate = self;
    mpView.mapType = MKMapTypeStandard;
    
    mpView.showsUserLocation = YES;
    MKCoordinateSpan span= {0.01,0.01};
    MKCoordinateRegion region = {newLocatin.coordinate,span};
    
    [mpView setRegion:region];
    [self.view addSubview:mpView];
}
//拖拽的时候释放一定内存
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (mapView == mpView) {
        
    [mpView removeFromSuperview];
    [self.view addSubview:mpView];
    }
}

//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    alert.delegate = self;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
