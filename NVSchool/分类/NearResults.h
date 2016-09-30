//
//  NearResults.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "NearProducts.h"
@interface NearResults : JSONModel
@property(nonatomic,strong)NSArray <NearProducts>*nearbyFilterResults;
@property(nonatomic,assign)NSNumber* time;
@end
