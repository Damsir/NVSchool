//
//  CityModel.h
//  NVSchool
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property(nonatomic,copy)NSString *my_id;
@property(nonatomic,copy)NSString *displayName;
@property(nonatomic,copy)NSString *searchName;
@property(nonatomic,copy)NSString *letter;
@property(nonatomic,assign)NSNumber *longitude;
@property(nonatomic,assign)NSNumber *latitude;
@end
