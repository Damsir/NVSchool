//
//  GoodDetaiData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "brandData.h"
#import "sellerData.h"
#import "mainImageData.h"
#import "GoodProductDetail.h"
@protocol GoodDetaiData
@end
@interface GoodDetaiData : JSONModel
@property(nonatomic,copy) NSString *my_id;
@property(nonatomic,strong)brandData *brand;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong)sellerData *seller;
@property(nonatomic,copy) NSString *fav;
@property(nonatomic,copy) NSString *favNum;
@property(nonatomic,copy) NSString *commenNum;
@property(nonatomic,copy) NSString *oriPrice;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *updataTime;
@property(nonatomic,copy) NSString *location;
@property(nonatomic,copy) NSString *latitude;
@property(nonatomic,copy) NSString *longitude;
@property(nonatomic,strong)mainImageData *mainImage;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *productState;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *stockCount;
@property(nonatomic,copy) NSString *canRefund;
@property(nonatomic,copy) NSString *isCanPermute;
@property(nonatomic,copy) NSString *browNum;
@property(nonatomic,copy) NSString *isRefresh;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *productStockCount;
@property(nonatomic,copy) NSString *rateCount;
@property(nonatomic,strong) NSArray<GoodProductDetail> *images;
@property(nonatomic,strong)GoodProductDetail *category;
@property(nonatomic,copy) NSString *recentcyStr;
@property(nonatomic,copy) NSString *isSupportBargain;
@property(nonatomic,strong)GoodProductDetail *province;
@property(nonatomic,strong)GoodProductDetail *city;
@property(nonatomic,strong)GoodProductDetail *district;
@property(nonatomic,copy) NSString *supportBargain;
@property(nonatomic,copy) NSString *canPermute;
@property(nonatomic,copy) NSString *refresh;

//@property(nonatomic,copy) NSString *my_id;
@property(nonatomic,copy) NSString *commentTime;
@property(nonatomic,strong)GoodProductDetail *user;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *contented;
//@property(nonatomic,copy) NSString *replyComment;
@property(nonatomic,copy) NSString *isDeleted;
@property(nonatomic,copy) NSString *deleted;
@end
