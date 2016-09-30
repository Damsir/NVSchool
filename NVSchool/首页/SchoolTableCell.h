//
//  SchoolTableCell.h
//  NVSchool
//
//  Created by qianfeng on 15/9/30.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
@protocol SchoolTableCellDelegate <NSObject>
-(void)showBigImage :(UIImage *)image;
@end
@interface SchoolTableCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UIImageView *schoolImage;
@property(nonatomic,weak) IBOutlet UILabel *name;
@property(nonatomic,weak) IBOutlet UILabel *message;
@property(nonatomic,strong)  id<SchoolTableCellDelegate> delegate;
-(void)setUIWith : (CityModel *)city;
@end
