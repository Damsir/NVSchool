//
//  GoodDetailCommentCell.h
//  NVSchool
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodDetaiData.h"
@interface GoodDetailCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
-(void)setUIWith :(GoodDetaiData *)commUser;
@end
