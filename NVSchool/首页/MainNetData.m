//
//  MainNetData.m
//  NVSchool
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MainNetData.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
@interface MainNetData()
{
    int index;
    int dataNum;
    NSString *strTitle;
    NSNumber *happenTime;
    NSString *currentProductID;
}
@end
@implementation MainNetData
-(instancetype)init
{
    if ( self = [super init]) {
        self.goodsArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)loadMainNetDataWith:(int)pageNum and:(getDataBlock)block
{
    //        初始化加载更多的参数
    dataNum = 0;
    index = pageNum;
    __weak typeof (*&self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict = [self chooseUrlWith:index];

    
    
    [manager POST:MAINURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
       weakSelf.jsonData = [[Json alloc]initWithString:operation.responseString error:nil];
//        NSLog(@"dict:%@",dict);
//        NSLog(@"%@",operation.responseString);
        NSDictionary *jsonDataDic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        happenTime = [jsonDataDic objectForKey:@"happenTime"];
        [weakSelf.goodsArray removeAllObjects];
//        商品列表
        [weakSelf.goodsArray addObjectsFromArray:weakSelf.jsonData.goodList];
        block(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO,error);
    }];
}
-(void)loadMoreData:(getDataBlock)block
{
    dataNum++;
    __weak typeof (*&self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *dict = [self chooseLoadMore];
    [manager POST:MAINURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Json * jsonData = [[Json alloc]initWithString:operation.responseString error:nil];
        [weakSelf.goodsArray addObjectsFromArray:jsonData.goodList];
//        NSLog(@"%@",dict);
//        NSLog(@"%@",operation.responseString);
        block(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"moreError:%@",error);
        block(NO,error);
    }];
}
-(NSDictionary *)chooseUrlWith:(int)page;
{
//    NSLog(@"--------------%d",index);
    NSDictionary *dict = [[NSDictionary alloc] init];
    NSString * count;
    count = [NSString stringWithFormat:@"20"];
    AppDelegate *deleagte = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSArray *array = [[NSArray alloc]initWithArray:deleagte.labArray];
    
    strTitle = @"";
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)@"电脑配件",
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
         
                                            NULL,
                                            kCFStringEncodingUTF8));
  
    switch (index) {
        case 0:
            count = [NSString stringWithFormat:@"30"];
            break;
        case 1:
            
//            strTitle = @"苹果二手";
//            strTitle = [strTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            break;
        case 2:
//            strTitle = @"数码产品";
      
            break;
        case 3:
//          strTitle = @"美容美体";
            break;
        case 4:
//            strTitle = @"居家生活";
            break;
        case 5:
//            strTitle = @"母婴";
            break;
        case 6:
//            strTitle = @"服饰";
            break;
        case 7:
//            strTitle = @"电脑配件";
                  strTitle = array[7];
            
            NSLog(@"%@",strTitle);
        dict=@{@"label_name":encodedString,@"count":count,@"command":@"get_idle_hot_goods_list",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"last_id":@"0",@"channel":@"5001.1007.1001"};
            return dict;
            break;
            
        default:
            break;
    }
dict=@{@"label_name":strTitle,@"count":count,@"command":@"get_idle_hot_goods_list",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"last_id":@"0",@"channel":@"5001.1007.1001"};
    return dict;
}
-(NSDictionary *)chooseLoadMore
{
    // {"brands":[],"categorys":[],"cityName":"北京","genderType":0,"happenTime":1444724641048,"distance":0.0,"locationType":0,"maxPrice":0,"minPrice":0,"usageType":0}

//    filter_options	{"brands":[],"categorys":[],"cityName":"北京","genderType":0,"happenTime":1444465314654,"distance":0.0,"locationType":0,"maxPrice":0,"minPrice":0,"usageType":0}
    NSDictionary *dict = [[NSDictionary alloc] init];
    if (index==0) {
        NSString *lastID = [NSString stringWithFormat:@"%d",dataNum*30];
        NSArray *categoryArr = [[NSArray alloc] init];
        NSArray *brandsArr = [[NSArray alloc] init];
        NSDictionary *opinDict = @ {@"brands":brandsArr,@"categorys":categoryArr,@"cityName":@"北京",@"genderType":@"0",@"happenTime":happenTime,@"distance":@"0.0",@"locationType":@"0",@"maxPrice":@"0",@"minPrice":@"0",@"usageType":@"0"};
        dict = @{@"count":@"30",@"filter_options":opinDict,@"command":@"get_idle_hot_goods_list",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"last_id":lastID,@"channel":@"5001.1007.1001"};
    }
    else
    {
        NSString *lastID = [NSString stringWithFormat:@"%d",dataNum*20];
        dict=@{@"label_name":strTitle,@"count":@"20",@"command":@"get_idle_hot_goods_list",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68%3Adf%3Add%3A99%3Af6%3A29_com.yunmall.ymctoc",@"version_code":@"332",@"last_id":lastID,@"channel":@"5001.1007.1001"};
    }
    return dict;
}
@end
