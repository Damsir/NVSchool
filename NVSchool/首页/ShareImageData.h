//
//  ShareImageData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"

@interface ShareImageData : JSONModel
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *thumb_url;
@end
