//
//  GoodSellerData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
@protocol GoodSellerData
@end
@interface GoodSellerData : JSONModel
//avatar
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *thumb_url;
@property(nonatomic,copy) NSString *width;
@property(nonatomic,copy) NSString *height;
@property(nonatomic,copy) NSString *rotation;
//province
@property(nonatomic,copy) NSString *my_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *parentId;
@property(nonatomic,copy) NSString *parentName;
//city
//district

//goodEvaluate  normalEvaluate  badEvaluate
//@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *count;
//avater
//@property(nonatomic,copy) NSString *my_id;
//@property(nonatomic,copy) NSString *url;
@end
