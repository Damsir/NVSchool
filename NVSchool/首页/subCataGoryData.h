//
//  subCataGoryData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
@protocol  subCataGoryData<NSObject>
@end
@interface subCataGoryData : JSONModel
@property(nonatomic,copy) NSString *my_id;
@property(nonatomic,copy) NSString *parentId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *parentName;
@end
