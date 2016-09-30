//
//  SettingTableViewCell.h
//  NVSchool
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface SettingTableViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UIImageView *imageVi;
@property(nonatomic,weak) IBOutlet UILabel *nameLab;
-(void)setUI;
@end
