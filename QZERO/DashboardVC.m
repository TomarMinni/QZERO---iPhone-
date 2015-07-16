//
//  DashboardVC.m
//  QZERO
//
//  Created by BT on 7/16/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import "DashboardVC.h"

@interface DashboardVC ()
{
    UIButton *backButton;
    UIButton *menuButton;
    CGSize screenSize;
}

@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    //[self.navigationController.navigationBar setBackgroundImage:kNavigationBar forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:136.0/255.0 green:56.0/255.0 blue:55.0/255.0 alpha:1.0];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ozero.png"]];
    
    [self.navigationItem setHidesBackButton:YES];
    
    
    CGRect frameimg1 = CGRectMake(10,12,20,20);
    menuButton = [[UIButton alloc] initWithFrame:frameimg1];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"Menu.png"] forState:UIControlStateNormal];
    [menuButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *barBtnLeft = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = barBtnLeft;
    
    
    CGRect frameimg2 = CGRectMake(screenSize.width-30,8,20,20);
    backButton = [[UIButton alloc] initWithFrame:frameimg2];
    [backButton setBackgroundImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
    [backButton setShowsTouchWhenHighlighted:YES];
    [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnRight = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = barBtnRight;

}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
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
