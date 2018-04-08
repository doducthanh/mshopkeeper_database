//
//  LoginViewController.m
//  mshopkeeper_manager
//
//  Created by Admin on 4/8/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "LoginViewController.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- onclick

- (IBAction)onClickLogin:(id)sender {
//    UIStoryboard *storyBoard = [[UIStoryboard alloc] instantiateInitialViewController];
    HomeViewController *homeVC = [[UIStoryboard alloc] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    MenuViewController *menuVC = [[UIStoryboard alloc] instantiateViewControllerWithIdentifier:@"MenuViewController"];
    SWRevealViewController *revealVC = [[SWRevealViewController alloc] initWithRearViewController:homeVC frontViewController:menuVC];
    [self presentViewController:revealVC animated:true completion:nil];
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
