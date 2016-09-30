//
//  mainImageData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"

@interface mainImageData : JSONModel
@property(nonatomic,copy)NSString *my_id;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *thumb_url;
@property(nonatomic,copy)NSString *ori_url;
@property(nonatomic,copy) NSString *width;
@property(nonatomic,copy) NSString *heigth;
@property(nonatomic,copy) NSString *rotation;
@property(nonatomic,copy) NSString *token;
@end
