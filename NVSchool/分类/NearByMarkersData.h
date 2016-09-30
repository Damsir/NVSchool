//
//  NearByMarkersData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "mainImageData.h"
#import "PoiData.h"
@protocol NearByMarkersData<NSObject>
@end
@interface NearByMarkersData : JSONModel
@property(nonatomic,copy) NSString *my_id;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *productCount;
@property(nonatomic,copy) NSString *isShowPicture;
@property(nonatomic,strong)mainImageData *image;
@property(nonatomic,strong)PoiData *poi;
@end
