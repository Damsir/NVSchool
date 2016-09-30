//
//  UserManager.h
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <UIKit/UIKit.h>
@interface UserManager : NSObject

@property(nonatomic,strong)NSMutableArray *usersArray;

+(UserManager*)shareUserManager;

//判断用户名是否重名，两个密码是否一致
//返回相关信息
-(NSString *)addUserAndUserName:(NSString *)name andPassWorld:(NSString *)world  andRepeatPassWorld:(NSString *)repeatWorld;

//做登陆判断
-(NSString *)loginUserName:(NSString *)name andPassWord:(NSString *)word;

@end






















