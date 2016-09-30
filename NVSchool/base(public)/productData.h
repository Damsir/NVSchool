//
//  productData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "brandData.h"
#import "sellerData.h"
@interface productData : JSONModel
@property(nonatomic,copy)NSString *my_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)brandData *brand;
@property(nonatomic,strong)sellerData *seller;
@property(nonatomic,strong)NSString *favNum;
@property(nonatomic,strong)NSString *commentNum;
@property(nonatomic,strong)NSString *oriPrice;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *stockCount;
@end
