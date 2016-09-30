//
//  sellerData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "avatarData.h"
@interface sellerData : JSONModel
@property(nonatomic,strong)avatarData *avatar;
@property(nonatomic,copy)NSString *my_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *my_description;

@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *location;
@end
