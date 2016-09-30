//
//  MainNetData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Json.h"
typedef void (^getDataBlock)(BOOL isSuccess,NSError *error);
@interface MainNetData : NSObject
@property(nonatomic,strong)Json * jsonData;
@property(nonatomic,strong)NSMutableArray *goodsArray;
-(void)loadMoreData:(getDataBlock)block;
- (void)loadMainNetDataWith:(int)pageNum and:(getDataBlock)block;
@end
