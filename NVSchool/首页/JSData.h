//
//  JSData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "sellerData.h"
#import "brandData.h"
#import "mainImageData.h"
@protocol JSData <NSObject>
@end
@interface JSData : JSONModel
//goodList
@property (nonatomic, copy) NSString *my_id;

@property (nonatomic, strong) brandData *brand;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) sellerData *seller;

@property (nonatomic, copy) NSString *fav;
@property (nonatomic, strong) NSNumber *favNum;
@property (nonatomic, strong) NSNumber *commentNum;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSString *oriPrice;

@property (nonatomic, copy) mainImageData *mainImage;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *productState;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSNumber *canPermute;
@property (nonatomic, strong) NSNumber *isCanPermute;
@property (nonatomic, strong) NSNumber *browNum;

@property (nonatomic, strong) NSNumber *isRefresh;
@property (nonatomic, strong) NSNumber *refresh;
@property (nonatomic, strong) NSNumber *canRefund;

//labelList
@property (nonatomic, copy) NSString *labelName;


@end
