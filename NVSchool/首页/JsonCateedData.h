//
//  JsonCateedData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "JSData.h"
@interface JsonCateedData : JSONModel
@property(nonatomic,strong)NSArray<JSData>*goodsList;
@end
