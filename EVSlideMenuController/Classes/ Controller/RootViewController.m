//
//  RootViewController.m
//  EVSlideMenuController
//
//  Created by iwevon on 16/8/10.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

#define kCOLOUR_THEME_FONT   [UIColor grayColor]
#define kCOLOUR_TAB_SELECT   [UIColor redColor]


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)pushSlideMenuController:(id)sender {
    
    NSArray *titleArray = @[@"视图一", @"视图二", @"视图三", @"视图四", @"视图五", @"视图六"];
    //创建顶部滑动控制器
    ViewController *viewController = [ViewController slideMenuControllerWithMenuArray:titleArray menuWidth:80.0f normalTitleColor:kCOLOUR_THEME_FONT selectTitleColor:kCOLOUR_TAB_SELECT];
    viewController.selectedIndex = 0;
    [self.navigationController pushViewController:viewController animated:YES];
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
