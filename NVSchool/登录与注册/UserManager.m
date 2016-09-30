//
//  UserManager.m
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.usersArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+(UserManager*)shareUserManager{
    static UserManager *manager = nil;
    if (manager == nil) {
        manager = [[UserManager alloc] init];
    }
    return manager;
}
// 用于判断用户名是否重名，两个密码是否一致
//返回相关信息
-(NSString *)addUserAndUserName:(NSString *)name andPassWorld:(NSString *)world  andRepeatPassWorld:(NSString *)repeatWorld
{
    //先判断两个密码是否一致
    if (name.length &&world.length)
    {
        
    if([world isEqualToString:repeatWorld])
    {
        for (User *user in self.usersArray)
        {
            if ([user.userName isEqualToString:name])
            {
                return @"该用户名已注册";
            }
        }
        //没有重复用户名，那么创建user对象，把对象加入到数组里保存起来
        User *user = [[User alloc] init];
        user.userName = name;
        user.passWorld = world;

        user.imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"my_default_avatar"], 0.7);
        user.goodComent= @"0";
        user.successTime= @"0";
        user.goodLab= @"0";
        user.normalLab= @"0";
        user.badLab= @"0";
        user.descriptionStr= @"";
    
        [self.usersArray addObject:user];
        
        return @"注册成功,请返回";
    }
    
    else
    {
        return @"您输入的密码不一致";
     }
    }
        return @"请完善信息";
}
-(NSString *)loginUserName:(NSString *)name andPassWord:(NSString *)word
{
    if (name.length) {
    for (User *user in self.usersArray)
    {
        if ([user.userName isEqualToString:name]&&[user.passWorld isEqualToString:word])
        {
            return @"登陆成功";
        }
    }
    return @"用户名或密码错误";
  }
   return @"请输入信息";
}

@end





















