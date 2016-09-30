//
//  NormalRegistVC.m
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "NormalRegistVC.h"
#import "UserManager.h"
@interface NormalRegistVC ()<UITextFieldDelegate>
{
    UILabel *_label;//显示注册是否成功等信息
}
@end

@implementation NormalRegistVC
-(void)viewWillAppear:(BOOL)animated
{
   self.navigationController.navigationBar.translucent = NO;
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_background"]];
    
    backImage.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:backImage];
    [self.view sendSubviewToBack:backImage];
    
    [self setMainArrange];
}
-(void)setMainArrange
{
    NSArray *textArr = @[@"用户名:",@"密码:",@"再次输入密码"];
    NSArray *filedArr = @[@"请输入用户",@"请输入密码",@"请再次输入密码"];
    NSArray *btnArr = @[@"返回",@"注册"];
    
    for (int i = 0; i<3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100+i*50, 120, 40)];
        label.text = textArr[i];
        [self.view addSubview:label];
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(130, 100+i*50, 160, 40)];
        field.placeholder = filedArr[i];
        field.borderStyle = UITextBorderStyleRoundedRect;
        field.returnKeyType = UIReturnKeyNext;
        field.backgroundColor = [UIColor whiteColor];
        field.tag = 100+i;
        field.delegate = self;
        [self.view addSubview:field];
        
        if (i<2) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(70+i*100, 350, 80, 40);
            [btn setTitle:btnArr[i] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor yellowColor];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 200+i;
            [self.view addSubview:btn];
        }
        
    }
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 260, 40)];
    _label.text = @"未注册";
    _label.textColor = [UIColor redColor];
    _label.backgroundColor = [UIColor lightGrayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];

}
-(void)btnClick:(UIButton *)btn{
    if (btn.tag == 200)
    {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {//注册
        UITextField *field1 = (UITextField *)[self.view viewWithTag:100];
        UITextField *field2 = (UITextField *)[self.view viewWithTag:101];
        UITextField *field3 = (UITextField *)[self.view viewWithTag:102];
        
        UserManager *manager = [UserManager shareUserManager];
        //把输入的用户名，密码，重复密码传给用户管理类去业务逻辑判断
        NSString *rect =  [manager  addUserAndUserName:field1.text andPassWorld:field2.text andRepeatPassWorld:field3.text];
        _label.text = rect;
        
        if ([rect isEqualToString:@"注册成功,请返回"]) {
            
        NSUserDefaults *deafults=[NSUserDefaults standardUserDefaults];
        [deafults setObject:field1.text forKey:@"newName"];
        [deafults setObject:field2.text forKey:@"newPassWord"];
        [deafults synchronize];
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *field1 = (UITextField *)[self.view viewWithTag:100];
    UITextField *field2 = (UITextField *)[self.view viewWithTag:101];
    UITextField *field3 = (UITextField *)[self.view viewWithTag:102];
    [field1 resignFirstResponder];
    [field2 resignFirstResponder];
    [field3 resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField  resignFirstResponder];
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
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
