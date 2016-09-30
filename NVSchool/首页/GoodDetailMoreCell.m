//
//  GoodDetailMoreCell.m
//  NVSchool
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "GoodDetailMoreCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "FindMoreGood.h"
@interface GoodDetailMoreCell()
{
    NSMutableArray *dataArray;
}
@end
@implementation GoodDetailMoreCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setUIWith:(NSString *)goodId
{
    dataArray = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //command	get_detail_more
    //source	android
    //version	3.3.2
    //client_id	864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc
    //product_id	200-123130
    //version_code	332
    //channel	5001.1007.1001
    NSDictionary *dict = @{@"command":@"get_detail_more",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"product_id":goodId,@"version_code":@"332",@"channel":@"5001.1007.1001"};
    
    [manager POST:DETAIL_MORE parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FindMoreGood *moreData = [[FindMoreGood alloc] initWithString:operation.responseString error:nil];
        
        GoodMessage *goodData1 = moreData.findMoreProduct[0];
        [self.imageVi1 setImageWithURL:[NSURL URLWithString:goodData1.mainImage.url]];
        self.name1.text = goodData1.name;
        self.price1.text = goodData1.price;
        [dataArray addObject:goodData1];
        
        GoodMessage *goodData2 = moreData.findMoreProduct[1];
        [self.imageVi2 setImageWithURL:[NSURL URLWithString:goodData2.mainImage.url]];
        self.name2.text = goodData2.name;
        self.price2.text = goodData2.price;
        [dataArray addObject:goodData2];
        
        GoodMessage *goodData3 = moreData.findMoreProduct[2];
        [self.imageVi3 setImageWithURL:[NSURL URLWithString:goodData3.mainImage.url]];
        self.name3.text = goodData3.name;
        self.price3.text = goodData3.price;
        [dataArray addObject:goodData3];
        
        [self imageAddGesture];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
-(void)imageAddGesture
{

    UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]init];
    [tap1 addTarget:self action:@selector(pushToGood:)];
    
    UITapGestureRecognizer *tap2 =[[UITapGestureRecognizer alloc]init];
    [tap2 addTarget:self action:@selector(pushToGood:)];
    
    UITapGestureRecognizer *tap3 =[[UITapGestureRecognizer alloc]init];
    [tap3 addTarget:self action:@selector(pushToGood:)];
    self.imageVi1.userInteractionEnabled = YES;
    self.imageVi2.userInteractionEnabled = YES;
    self.imageVi3.userInteractionEnabled = YES;

    
    [self.imageVi1 addGestureRecognizer:tap1];
    [self.imageVi2 addGestureRecognizer:tap2];
    [self.imageVi3 addGestureRecognizer:tap3];
}
-(void)pushToGood :(UITapGestureRecognizer *)tap
{
    UIImageView *imageVi = (UIImageView *)[tap view];
    
    GoodMessage *goodData = [[GoodMessage alloc] init];
    
    if (imageVi == self.imageVi1) {
        goodData = dataArray[0];
    }
    if (imageVi == self.imageVi2) {
        goodData = dataArray[1];
    }
    if (imageVi == self.imageVi3) {
        goodData = dataArray[2];
    }
    [self.delegate pushToViewControllWith:goodData.my_id];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
