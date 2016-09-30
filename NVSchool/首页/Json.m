//
//  Json.m
//  NVSchool
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "Json.h"

@implementation Json
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"my_id"}];
}
@end
