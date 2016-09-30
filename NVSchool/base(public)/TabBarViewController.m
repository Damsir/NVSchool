//
//  TabBarViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.selectedImageTintColor = [UIColor redColor] ;

    NSArray *names=@[@"首页",@"同城",@"我的"];
    NSArray *imageName = @[@"tab_main",@"tab_find",@"tab_wo"];
    NSArray *
    selectImageName = @[@"tab_main_p",@"tab_find_p",@"tab_wo_p"];
    
    int i=0;
    for (UINavigationController *navi in self.viewControllers) {
    
        UIViewController *vc = navi.viewControllers[0];
        UIImage *image = [TabBarViewController renderingImage:imageName[i]];
        UIImage *selectImage = [TabBarViewController renderingImage:selectImageName[i]];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:names[i] image:image selectedImage:selectImage];
         i++;
    }
    self.selectedIndex = 0;
}
+(UIImage*)renderingImage:(NSString*)imageName
{
    UIImage *image=[UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
