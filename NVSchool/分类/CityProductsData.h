//
//  CityProductsData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearResults.h"
#import "CityModel.h"
typedef void (^getDataBlock)(BOOL isSuccess,NSError *error);
@interface CityProductsData : NSObject
@property(nonatomic,strong)NearResults *nearResults;
@property(nonatomic,strong)NSMutableArray *goodsArray;
- (void)loadCityNetDataWithCity:(CityModel *)city and:(getDataBlock)block;
-(void)loadMoreData:(getDataBlock)block;
@end
