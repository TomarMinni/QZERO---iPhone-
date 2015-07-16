//
//  ViewController.m
//  QZERO
//
//  Created by BT on 7/14/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import "ViewController.h"
#import "SearchVC.h"
#import "LoginVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)SearchButtonAction:(id)sender
{
    SearchVC *search = (SearchVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    search.modalPresentationStyle = UIModalPresentationPageSheet;
    search.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:search animated:NO];
 
   
}
- (IBAction)LoginbuttonAction:(id)sender
{
    LoginVC *login = (LoginVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    login.modalPresentationStyle = UIModalPresentationPageSheet;
    login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:login animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
