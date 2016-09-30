//
//  CityProductsData.m
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "CityProductsData.h"
#import "AFNetworking.h"
@interface CityProductsData ()
{
    NSString *chengShi;
    int count;
    NSNumber *time;
    CityModel *currentCity;
}
@end
@implementation CityProductsData
-(instancetype)init
{
    if (self = [super init]) {
        self.goodsArray = [[NSMutableArray alloc] init];
    
    }
    return self;
}
- (void)loadCityNetDataWithCity:(CityModel *)city and:(getDataBlock)block
{
    currentCity = city;
    count = 0;
    __weak typeof (*&self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    count	10
//    isLocation	0
//    command	get_nearby_result_without_seller
//    source	android
//    version	3.3.2
//    client_id	864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc
//    version_code	332
//    last_id	0
//    channel	5001.1007.1001
//    city	武汉
//    latitude	30.453885
//    longitude	114.429021
//    time	0

//    NSString *ss = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"count":@"10",@"isLocation":@"0",@"command":@"get_nearby_result_without_seller",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"last_id":@"0",@"channel":@"5001.1007.1001",@"city":city.displayName,@"latitude":city.latitude,@"longitude":city.longitude,@"time":@"0"};
    [manager POST:NEAR_GOOD parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.nearResults = [[NearResults alloc]initWithString:operation.responseString error:nil];
//                NSLog(@"dict:%@",dict);
//                NSLog(@"%@",operation.responseString);
//        初始化刷新更多的time
        time = weakSelf.nearResults.time;
        [weakSelf.goodsArray removeAllObjects];
        //        商品列表
        [weakSelf.goodsArray addObjectsFromArray:weakSelf.nearResults.nearbyFilterResults];
        block(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO,error);
    }];
}
-(void)loadMoreData:(getDataBlock)block
{
    count ++;
    
    int num =(count-1)*10;
    NSString *last_id = [NSString stringWithFormat:@"%d",num];
    __weak typeof (*&self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //count	10
    //isLocation	0
    //command	get_nearby_result_without_seller
    //source	android
    //version	3.3.2
    //client_id	864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc
    //version_code	332
    //last_id	18
    //channel	5001.1007.1001
    //city	武汉
    //latitude	30.453885
    //longitude	114.429021
    //time	1444808934031
//    time	1444826684492
//    time	1444826765927
//    time	1444826859762
    
    NSDictionary *dict = @{@"count":@"10",@"isLocation":@"0",@"command":@"get_nearby_result_without_seller",@"source":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"last_id":last_id,@"channel":@"5001.1007.1001",@"city":@"武汉",@"latitude":currentCity.latitude,@"longitude":currentCity.longitude,@"time":time};
    
    [manager POST:NEAR_GOOD parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.nearResults = [[NearResults alloc]initWithString:operation.responseString error:nil];
        //        NSLog(@"dict:%@",dict);
        //        NSLog(@"%@",operation.responseString);
        //        商品列表
        [weakSelf.goodsArray addObjectsFromArray:weakSelf.nearResults.nearbyFilterResults];
        block(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO,error);
    }];
}
@end
