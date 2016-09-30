//
//  ProductsData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "productData.h"
#import "userData.h"
@protocol ProductsData<NSObject>
@end
@interface ProductsData : JSONModel
@property(nonatomic,strong)productData *product;
@property(nonatomic,strong)userData *user;
@end
