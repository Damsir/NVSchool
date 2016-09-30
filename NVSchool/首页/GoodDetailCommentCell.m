//
//  GoodDetailCommentCell.m
//  NVSchool
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "GoodDetailCommentCell.h"
#import "UIImageView+AFNetworking.h"
@implementation GoodDetailCommentCell

- (void)awakeFromNib {
    // Initialization code
}
//@property (weak, nonatomic) IBOutlet UILabel *time;
//@property (weak, nonatomic) IBOutlet UILabel *name;
//@property (weak, nonatomic) IBOutlet UILabel *message;
//@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
-(void)setUIWith:(GoodDetaiData *)commUser
{
    self.name.text = commUser.user.nickname;
    self.message.text = commUser.content;
    [self.imageVi setImageWithURL:[NSURL URLWithString:commUser.user.avatar.url]];
//    self.time.text = commUser.commentTime;
      self.time.text = @"7小时前";
    self.time.textColor = [UIColor lightGrayColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
