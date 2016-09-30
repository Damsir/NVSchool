//
//  MyTableViewCell.m
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MyTableViewCell.h"
@interface MyTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCellWith:(NSInteger)indexPath
{
    NSArray *arr = @[@"购买订单",@"卖出订单",@"退款管理",@"我的账户",@" 收藏的商品",@"发布的商品",@" 我的关注",@"帮助中心",@"联系客服",@"叫快递"];
    NSArray *imageArray = @[@"my_buy",@"my_sell",@"my_tuikuan",@"my_account",@"my_favorite",@"my_fabu",@"my_friend",@"my_help_center",@"my_contact_us",@"my_call_logistics"];
    self.label.text  =arr[indexPath];
    [self.imageVi setImage:[UIImage imageNamed:imageArray[indexPath]]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
