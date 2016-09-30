//
//  CatagoryJsonData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "categoryData.h"
@interface CatagoryJsonData : JSONModel
@property(nonatomic,strong)NSArray<categoryData>*categoryList;
@end
