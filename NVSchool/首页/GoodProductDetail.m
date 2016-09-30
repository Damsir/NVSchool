//
//  GoodProductDetail.m
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "GoodProductDetail.h"

@implementation GoodProductDetail
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"my_id",@"friend":@"my_friend",@"description":@"my_description"}];
}
@end
