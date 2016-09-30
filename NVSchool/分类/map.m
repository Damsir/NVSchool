//
//  map.m
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "map.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface map () <CLLocationManagerDelegate>
{
    CLLocationManager *Cmanager;
    //    经纬度解析器
    //    编码/反编码
    CLGeocoder *gecoder;
    CityModel *city;
    UIAlertView *alert;
}
@end
@implementation map
-(void)startPosition
{
    
    city = [[CityModel alloc] init];
    
    //    判断地图的定位功能是否能使用
    if ([CLLocationManager locationServicesEnabled]) {
        Cmanager = [[CLLocationManager alloc] init];
        
        //  在 iOS 7以后info需要配置 允许使用定位功能
        [Cmanager requestAlwaysAuthorization];
        
        Cmanager.delegate = self;
        [Cmanager startUpdatingLocation];
        [Cmanager requestWhenInUseAuthorization];
        alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"正在定位..." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        
//    [NSThread sleepForTimeInterval:2];
//    [alert removeFromSuperview];
    }
    else
    {
      alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位功能不能使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        Cmanager  = nil ;
    }
}
#pragma MARK -- CLLocationManagerDelegate
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocatin = [locations lastObject];
    [Cmanager stopUpdatingLocation];
    //    初始化一个解析器
    gecoder = [[CLGeocoder alloc] init];
    [gecoder reverseGeocodeLocation:newLocatin completionHandler:^(NSArray *placemarks, NSError *error) {
    CLPlacemark *placeMark = [placemarks objectAtIndex:0];

        city.searchName = placeMark.locality;
        city.longitude = [NSNumber numberWithDouble:newLocatin.coordinate.longitude];
        city.latitude = [NSNumber numberWithDouble:newLocatin.coordinate.latitude];
        
        NSString *message = [NSString stringWithFormat:@"城市:%@",placeMark.locality];
        alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        [self.delegate changeCityWith:city];
        
        
        
//    NSArray *array = [placeMark.addressDictionary valueForKey:@"FormattedAddressLines"];
//        NSLog(@"%@",newLocatin);
//        for (NSString *locationAt in array) {
//            NSLog(@"%@",locationAt);
//            NSLog(@"国家%@",placeMark.country);
//            NSLog(@"城市%@",placeMark.locality);
//        }
        
    }];

}
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    alert.message = @"定位失败";
    Cmanager  = nil ;
    [self.delegate changeCityWith:city];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
