//
//  PoiData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"

@interface PoiData : JSONModel
@property (nonatomic, copy) NSString *my_id;
@property (nonatomic, strong) NSNumber *refreshLevel;
@property (nonatomic, copy) NSString *adName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, copy) NSString *provinceCode;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *snippet;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *adCode;
@property (nonatomic, strong) NSNumber *zoom;

@end
