//
//  bannerData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "BannerDatail.h"
@protocol bannerData
@end
@interface bannerData : JSONModel
@property(nonatomic,copy) NSString *bannerType;
@property(nonatomic,strong) BannerDatail *bannerImages;
@property(nonatomic,copy) NSString *bannerId;
@property(nonatomic,copy) NSString *bannnerName;
@property(nonatomic,strong) BannerDatail *shareInfo;
@end
