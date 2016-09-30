//
//  SettingViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"

#import "SettingDetailVc.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSArray *titleArray;
}
@end

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationItem.backBarButtonItem setImage:[UIImage imageNamed:@"back_w_def"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    [self setMainArrange];
}
//界面布局
-(void)setMainArrange
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64+49) style:UITableViewStyleGrouped];
    
    table.delegate = self;
    table.dataSource = self;
    
    UINib *cellNib = [UINib nibWithNibName:@"SettingTableViewCell" bundle:nil];
    [table registerNib:cellNib forCellReuseIdentifier:@"SettingTableViewCell"];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:table];
    
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutButton.tag = 201;
    logOutButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    logOutButton.backgroundColor = [UIColor redColor];
    [logOutButton setTitle:@"退出" forState:UIControlStateNormal];
//
    logOutButton.showsTouchWhenHighlighted = YES;
    
    [logOutButton addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    table.tableFooterView = logOutButton;
}
//退出当前账号
-(void)logOut :(UIButton*)btn
{
    if (btn.tag ==201) {

    NSUserDefaults *deafults=[NSUserDefaults standardUserDefaults];
        [deafults setObject:@""  forKey:@"newName"];
        [deafults setObject:@""  forKey:@"newPassWord"];
        [deafults setObject:@"NO" forKey:@"isLogIn"];
        [deafults synchronize];
        
    }
}
#pragma mark ---UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 6;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 &&indexPath.row ==0) {
   SettingTableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
     cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell setUI];
    return cell;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        设置普通cell
        [self setCellUI:cell With:indexPath];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *sectionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    sectionLab.text = @"账号设置";
    
    return sectionLab;
}
//cell的选择函数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingDetailVc *settingVC = [[SettingDetailVc alloc] init];
    settingVC.indexPath = indexPath;
    settingVC.titleArray = titleArray;
    [self.navigationController pushViewController:settingVC animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}
//普通cell的赋值
-(void)setCellUI :(UITableViewCell *)cell With:(NSIndexPath*)indexPath
{
    titleArray = @[@"编辑个人资料",@"修改密码",@"绑定手机",@"地址管理",@"邀请好友",@"绑定第三方账号",@"消息推送",@"图片显示",@"清理缓存",@"给猎趣好评",@"意见反馈",@"关于猎趣"];
    if (indexPath.section==0) {
        cell.textLabel.text = titleArray[indexPath.row];
    }
    else
    {
        cell.textLabel.text = titleArray[indexPath.section*3+indexPath.row+3];
    }
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
