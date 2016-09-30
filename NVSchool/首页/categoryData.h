//
//  categoryData.h
//  NVSchool
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "iconData.h"
#import "subCataGoryData.h"
@protocol categoryData<NSObject>
@end
@interface categoryData : JSONModel
@property(nonatomic,copy)NSString *my_id;
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *hasBrand;
@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)iconData *normalIcon;
@property(nonatomic,copy)iconData *selectIcon;
@property(nonatomic,strong) NSArray<subCataGoryData>*subCategory;
@end
