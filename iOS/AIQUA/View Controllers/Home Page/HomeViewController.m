//
//  HomeViewController.m
//  AIQUA
//
//  Created by Shiv.Raj on 10/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "HomeViewController.h"
#import "DemoSplashViewController.h"
#import "QGSdk.h"
#import "Utility.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *personalisationButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiseLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    // add shadow effect
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_backgroundView.bounds];
    _backgroundView.layer.masksToBounds = NO;
    _backgroundView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
    _backgroundView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    _backgroundView.layer.shadowOpacity = 0.5f;
    _backgroundView.layer.shadowRadius = 8;
    _backgroundView.layer.shadowPath = shadowPath.CGPath;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

- (IBAction)contactSalesClicked:(id)sender {
    NSString *email = [[NSUserDefaults standardUserDefaults] valueForKey:WORK_EMAIL];
    [[QGSdk getSharedInstance] logEvent:CONTACTED_SALES withParameters:@{WORK_EMAIL: email}];
}

- (IBAction)personalisationButtonClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DemoSplashViewController *pvc = [storyboard instantiateViewControllerWithIdentifier:@"DemoSplash"];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:pvc animated:true];
}

- (void)initialiseLayout {
    [self changeButtonStyle:self.personalisationButton];
    
    self.coverImageView.layer.masksToBounds = YES;
}

- (void)changeButtonStyle:(UIButton *)button {
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:36/255.0 green:172/255.0 blue:255/255.0 alpha:0.7].CGColor;
    button.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
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
