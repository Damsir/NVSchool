//
//  MainDetailGoodVC.m
//  NVSchool
//
//  Created by qianfeng on 15/10/7.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MainDetailGoodVC.h"
#import "GoodDetailMessageCell.h"
#import "GoodDetailCommentCell.h"
#import "GoodDetailMoreCell.h"
#import "MainHeadView.h"

#import "GoodModel.h"
@interface MainDetailGoodVC ()<UITableViewDataSource,UITableViewDelegate,MainHeadViewDelegate,GoodDetailMoreCellDelegate>
{
    
    IBOutlet UITableView *table;
    MainHeadView *headView;
    GoodModel *goodModel;
}
@end

@implementation MainDetailGoodVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setMainArrage];
    [self loadNetDataWith:self.product_id];
}
-(void)setMainArrage
{
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.1];
    
    UINib *meeeageNib = [UINib nibWithNibName:@"GoodDetailMessageCell" bundle:nil];
    UINib *commentNib = [UINib nibWithNibName:@"GoodDetailCommentCell" bundle:nil];
    UINib *moreNib = [UINib nibWithNibName:@"GoodDetailMoreCell" bundle:nil];
    
    [table registerNib:meeeageNib forCellReuseIdentifier:@"GoodDetailMessageCell"];
    [table registerNib:commentNib forCellReuseIdentifier:@"GoodDetailCommentCell"];
    [table registerNib:moreNib forCellReuseIdentifier:@"GoodDetailMoreCell"];
    
    headView = [[[NSBundle mainBundle]loadNibNamed:@"MainHeadView" owner:nil options:nil]firstObject];
    headView.delegate = self;
    table.tableHeaderView = headView;
    [self creatFootButton];
}
-(void)creatFootButton
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    [self.view addSubview:view];
    
    UIButton *btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBuy.backgroundColor = [UIColor redColor];
    btnBuy.frame = CGRectMake(0, 0, self.view.frame.size.width/2, view.frame.size.height);
    [btnBuy setTitle:@"立即购买" forState:UIControlStateNormal];
    [btnBuy addTarget:self action:@selector(btnBuy) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnBuy];
    
    UIButton *btnDiscount = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDiscount.backgroundColor = [UIColor blackColor];
    btnDiscount.frame = CGRectMake(CGRectGetMaxX(btnBuy.frame), 0, self.view.frame.size.width/2, view.frame.size.height);
    [btnDiscount setTitle:@"侃价" forState:UIControlStateNormal];
    [btnDiscount addTarget:self action:@selector(btnDiscount) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btnDiscount];
    
}
-(void)loadNetDataWith:(NSString*)productId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *dict = @{@"command":@"get_product_by_id",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"product_id":productId,@"version_code	332":@"332",@"channel":@"5001.1007.1001"};
    [manager POST:GOOD_DETAIL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",operation.responseString);
        goodModel = [[GoodModel alloc] initWithString:operation.responseString error: nil];
        [headView setUIWith:goodModel.product];
        [table reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

}
#pragma mark --UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return goodModel.comments.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    GoodDetailMessageCell *cell = [table dequeueReusableCellWithIdentifier:@"GoodDetailMessageCell"];
        [cell setUIWith:goodModel.product];
        
        return cell;
    }
    if (indexPath.section == 1) {
        GoodDetailCommentCell *cell = [table dequeueReusableCellWithIdentifier:@"GoodDetailCommentCell"];
        [cell setUIWith:[goodModel.comments objectAtIndex:indexPath.row ]];
        return cell;
    }
    if (indexPath.section ==2) {
        GoodDetailMoreCell *cell = [table dequeueReusableCellWithIdentifier:@"GoodDetailMoreCell"];
        [cell setUIWith:self.product_id];
        cell.delegate = self;
        return cell;
    }
    return [[UITableViewCell alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    lab.backgroundColor = self.view.backgroundColor;
    lab.font = [UIFont boldSystemFontOfSize:20];
    
    if (section ==0) {
        lab.text = @"商品信息";
    }
    if (section==1) {
        NSString *str = [NSString stringWithFormat:@"猎人留言(%lu)",(unsigned long)goodModel.comments.count];
       lab.text = str;
    }
    if (section ==2) {
        lab.text = @"发现更多";
    }
    return lab;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        NSString *des = goodModel.product.desc;
        CGFloat h_h = [MainDetailGoodVC getHight:des andFont:[UIFont systemFontOfSize:17] andWidth:self.view.frame.size.width-20];
        return 156-21+h_h;
    }
    if (indexPath.section ==1) {
        return 80;
    }
    if (indexPath.section ==2) {
        return 150;
    }
    return 44;
}

//获得可变高的高
+(CGFloat)getHight :(NSString *)text andFont :(UIFont*)font andWidth :(CGFloat)width
{
    CGRect frame=[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:nil];
    CGFloat height=frame.size.height;
    return height;
}

//第一个view的点击函数代理
-(void)pushToViewControll:(UIViewController *)ViewCont
{
    [self.navigationController pushViewController:ViewCont animated:YES];
}
//推荐的代理函数
-(void)pushToViewControllWith:(NSString *)producrId
{
    NSLog(@"%@",producrId);
    [self loadNetDataWith:producrId];
}
-(void)btnBuy
{
    NSLog(@"买");
}
-(void)btnDiscount
{
    NSLog(@"侃价");
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
