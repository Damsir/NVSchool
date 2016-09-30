//
//  User.m
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "User.h"

@implementation User
//解档
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        _userName=[aDecoder decodeObjectForKey:@"userName"];
        _passWorld=[aDecoder decodeObjectForKey:@"passWord"];
        _userID=[aDecoder decodeObjectForKey:@"userID"];
        _imageData=[aDecoder decodeObjectForKey:@"imageData"];
        _descriptionStr=[aDecoder decodeObjectForKey:@"descriptionStr"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.userName forKey:@"passWord"];
    [aCoder encodeObject:self.passWorld forKey:@"passWord"];
    [aCoder encodeObject:self.imageData forKey:@"imageData"];
    [aCoder encodeObject:self.descriptionStr forKey:@"descriptionStr"];
}
@end
