//
//  GoodDetailMoreCell.h
//  NVSchool
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GoodDetailMoreCellDelegate<NSObject>
-(void)pushToViewControllWith :(NSString *)producrId;
@end
@interface GoodDetailMoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UIImageView *imageVi1;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UIImageView *imageVi2;
@property (weak, nonatomic) IBOutlet UILabel *name3;
@property (weak, nonatomic) IBOutlet UILabel *price3;
@property (weak, nonatomic) IBOutlet UIImageView *imageVi3;
@property(nonatomic,assign)id<GoodDetailMoreCellDelegate>delegate;
-(void)setUIWith:(NSString *)goodId;
@end
