//
//  CatagoryNetData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonCateedData.h"
@interface CatagoryNetData : NSObject

typedef void (^getDataBlock)(BOOL isSuccess,NSError *error);

@property(nonatomic,strong)JsonCateedData * jsonCateData;
@property(nonatomic,strong)NSMutableArray *goodsArray;

- (void)loadCategoryNetDataWith:(NSString*)categoryId and:(NSString*)searchType  and:(getDataBlock)block;
-(void)loadCategoryMoreData:(getDataBlock)block;
@end
