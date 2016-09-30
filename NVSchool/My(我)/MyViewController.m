//
//  MyViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MyViewController.h"

#import "HeadView.h"
#import "MyTableViewCell.h"
//登录
#import "LogViewController.h"
#import "SettingViewController.h"
#import "UserManager.h"

#import "UMSocial.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialDataDelegate>
{
    UITableView *tabel;
    HeadView *headView;
}
@end

@implementation MyViewController

-(void)viewWillAppear:(BOOL)animated
{
//    需要选择数据，viewDidLoad 只执行一次
    self.navigationController.navigationBar.translucent = NO;
    [self creatHeadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self creatNavigation];
}
-(void)creatNavigation
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingUser)];
}
-(void)creatHeadView
{
//    根据登录状态 选择头部view
    NSUserDefaults *deafults = [NSUserDefaults standardUserDefaults];
    NSString *isLogIn = [deafults objectForKey:@"isLogIn"];
    
    if ([isLogIn isEqualToString:@"YES"]) {
    
    self.user = [[UserManager shareUserManager].usersArray lastObject];
    headView = [[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:nil options:nil]lastObject];
    [headView setUIWith:self.user];
    }
    else
    {
    headView = [[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:nil options:nil]firstObject];
        [headView.logInButton addTarget:self action:@selector(pressLogIn) forControlEvents:UIControlEventTouchUpInside];
        [headView setPlaceHolderUI];
    }
//    创建整体table
    tabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    tabel.delegate = self;
    tabel.dataSource = self;
    [self.view addSubview:tabel];
    tabel.tableHeaderView = headView;
    
    UINib *cellNib = [UINib nibWithNibName:@"MyTableViewCell" bundle:nil];
    [tabel registerNib:cellNib forCellReuseIdentifier:@"MyTableViewCell"];
}
//设置
-(void)settingUser
{
    NSUserDefaults *deafults = [NSUserDefaults standardUserDefaults];
    NSString *isLogIn = [deafults objectForKey:@"isLogIn"];
    
    if ([isLogIn isEqualToString:@"YES"]) {
    SettingViewController *setVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil , nil];
        [alert show];
    }
}
#pragma mark--UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 4;
    }
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];

        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        [cell setCellWith:indexPath.row];
        return cell;
    }
    [cell setCellWith:indexPath.section*3+1+indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==2) {
        return 40;
    }
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能完善" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==2) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        button.backgroundColor = [UIColor lightGrayColor];
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action: @selector(share) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"分享" forState:UIControlStateNormal];
        return button;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    if (section ==2)
    {
        return 40;
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//分享功能
-(void)share
{
    //    sheetView 1、弹出到哪一个界面 2、appKey  3、分享的文字  4.分享的图片  5、分享到的平台   6、分享结果代理回调
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5614e40267e58ed89300425d" shareText:@"1504分享" shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToWechatTimeline] delegate:(id)self];
}
-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"分享成功");
    }
}
#pragma mark---Button点击事件
-(void)pressLogIn
{
    LogViewController *logVC = [[LogViewController alloc] initWithNibName:@"LogViewController" bundle:nil];
    [self.navigationController pushViewController:logVC animated:NO];
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
