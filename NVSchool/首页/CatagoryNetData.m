//
//  CatagoryNetData.m
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "CatagoryNetData.h"
#import "AFNetworking.h"
@interface CatagoryNetData ()
{
    int dataNum;
    NSString *currentCategoryID;
    NSString *currentSearchTypeID;
}
@end
@implementation CatagoryNetData
-(instancetype)init
{
    if ( self = [super init]) {
        self.goodsArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)loadCategoryNetDataWith:(NSString*)productId and:(NSString*)searchType and:(getDataBlock)block
{
    //        初始化加载更多的参数
    dataNum = 0;
    currentCategoryID = productId;
    currentSearchTypeID = searchType;
    __weak typeof (*&self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict =@{@"count":@"20",@"category_id":productId,@"command":@"get_product_by_filter_two",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"search_type":searchType,@"level":@"2",@"version_code":@"332",@"last_id":@"0",@"channel":@"5001.1007.1001",};
    
    [manager POST:FILTER parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.jsonCateData = [[JsonCateedData alloc]initWithString:operation.responseString error:nil];
//        NSLog(@"dict:%@",dict);
//        NSLog(@"%@",operation.responseString);
        
        [weakSelf.goodsArray removeAllObjects];
        //        商品列表
        [weakSelf.goodsArray addObjectsFromArray:weakSelf.jsonCateData.goodsList];
        block(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO,error);
    }];
    
}
-(void)loadCategoryMoreData:(getDataBlock)block
{
    dataNum ++;
    __weak typeof (*&self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *last_id = [NSString stringWithFormat:@"%d",dataNum*20];
    NSDictionary *dict =@{@"count":@"20",@"category_id":currentCategoryID,@"command":@"get_product_by_filter_two",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"search_type":@"0",@"level":@"2",@"version_code":@"332",@"last_id":last_id,@"channel":@"5001.1007.1001",};
    
    [manager POST:FILTER parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.jsonCateData = [[JsonCateedData alloc]initWithString:operation.responseString error:nil];
        //        NSLog(@"dict:%@",dict);
        //        NSLog(@"%@",operation.responseString);
        //        商品列表
        [weakSelf.goodsArray addObjectsFromArray:weakSelf.jsonCateData.goodsList];
        block(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO,error);
    }];
}

@end
