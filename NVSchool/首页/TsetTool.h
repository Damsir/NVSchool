//
//  TsetTool.h
//  NVSchool
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TsetTool : NSObject
+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isValidateMobile:(NSString *)mobile;
@end
