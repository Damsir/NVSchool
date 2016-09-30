//
//  Json.h
//  NVSchool
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "JSData.h"
@interface Json : JSONModel

@property(nonatomic,strong) NSArray<JSData> *goodList;
@property(nonatomic,strong) NSArray<JSData> *labelList;

@property (nonatomic, copy) NSString *my_id;
@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSNumber *happenTime;
@property (nonatomic, strong) NSNumber *endTime;
@property (nonatomic, strong) NSNumber *errorCode;
@property (nonatomic, copy) NSString *countDownMsg;

@property (nonatomic, copy) NSString *command;
@property (nonatomic, copy) NSString *serverMsg;
@property (nonatomic, strong) NSNumber *curTime;

@end
