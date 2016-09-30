//
//  JsonMapMarkData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "NearByMarkersData.h"
@interface JsonMapMarkData : JSONModel
@property(nonatomic,copy) NSString* my_id;
@property(nonatomic,strong)NSArray<NearByMarkersData>*nearbyMarkers;
@end
