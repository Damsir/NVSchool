//
//  sellerData.m
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "sellerData.h"

@implementation sellerData
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"my_id",@"description":@"my_description"}];
}
@end
