//
//  GoodMessage.h
//  NVSchool
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "GoodImage.h"
@protocol GoodMessage<NSObject>
@end
@interface GoodMessage : JSONModel
@property(nonatomic,strong)GoodImage *mainImage;
@property(nonatomic,copy)NSString *my_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *location;
@end
