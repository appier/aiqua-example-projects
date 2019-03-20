//
//  LaunchScreenViewController.m
//  AIQUA
//
//  Created by Shiv.Raj on 9/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "Utility.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(pushToLoginPage) withObject:nil afterDelay:3.0];
}

- (void)pushToLoginPage {
    // check the login status
    BOOL isLoggedIn = false;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:AIQUA_LOGIN_STATUS]) {
        isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:AIQUA_LOGIN_STATUS];
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    if (isLoggedIn) {
        HomeViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
        [self.navigationController pushViewController:homeVC animated:false];
    } else {
        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self.navigationController pushViewController:loginVC animated:false];
    }
}

@end
