//
//  SettingTableViewCell.m
//  NVSchool
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "UserManager.h"
@implementation SettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setUI];
}
-(void)setUI
{
    User *user = [[UserManager shareUserManager].usersArray lastObject];
    
    [self.imageVi setImage:[UIImage imageWithData:user.imageData]];
    self.nameLab.text = user.userName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
