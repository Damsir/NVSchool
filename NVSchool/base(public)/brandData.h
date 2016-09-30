//
//  brandData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"

@interface brandData : JSONModel
@property(nonatomic,copy)NSString *my_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *productList;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *isStorage;
@end
