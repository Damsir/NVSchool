//
//  FindMoreGood.h
//  NVSchool
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "GoodMessage.h"
@interface FindMoreGood : JSONModel
@property(nonatomic,strong)NSArray<GoodMessage>*findMoreProduct;
@end
