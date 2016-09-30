//
//  GoodModel.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "GoodDetaiData.h"
@interface GoodModel : JSONModel
@property(nonatomic,strong) GoodDetaiData *product;
@property(nonatomic,strong) NSArray<GoodDetaiData> *comments;
@end
