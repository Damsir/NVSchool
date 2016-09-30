//
//  HeadBannerData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "bannerData.h"
@interface HeadBannerData : JSONModel
@property(nonatomic,strong)NSArray<bannerData>*bannerList;
@end
