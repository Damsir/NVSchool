//
//  BannerDatail.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "ShareImageData.h"
@interface BannerDatail : JSONModel
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *thumb_url;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,strong)ShareImageData *image;
@end
