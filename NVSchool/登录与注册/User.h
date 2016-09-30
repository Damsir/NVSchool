//
//  User.h
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
@property(nonatomic,copy) NSString *userID;
@property(nonatomic,copy)NSString *userName;//用户名
@property(nonatomic,copy)NSString *passWorld;//密码
@property(nonatomic,strong)NSData *imageData;
@property(nonatomic,copy)NSString *successTime;
@property(nonatomic,copy)NSString *goodComent;
@property(nonatomic,copy)NSString *goodLab;
@property(nonatomic,copy)NSString *normalLab;
@property(nonatomic,copy)NSString *badLab;
@property(nonatomic,copy) NSString *descriptionStr;
@end










