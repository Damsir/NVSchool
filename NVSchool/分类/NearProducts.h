//
//  NearProducts.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "ProductsData.h"
@protocol NearProducts<NSObject>
@end
@interface NearProducts : JSONModel
@property(nonatomic,copy) NSString *distance;
@property(nonatomic,copy) NSString *distanceDes;
@property(nonatomic,assign) NSNumber* productCount;
@property(nonatomic,strong)NSArray<ProductsData>*products;
@property(nonatomic,assign) NSNumber* zoom;
@end
