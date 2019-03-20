//
//  PersonalizationDemoViewController.m
//  AIQUA
//
//  Created by Shiv.Raj on 10/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "DemoSplashViewController.h"
#import "DemoEcomViewController.h"

@interface DemoSplashViewController ()
@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UIButton *startDemoButton;

@end

@implementation DemoSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    // add shadow effect
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_startView.bounds];
    _startView.layer.masksToBounds = NO;
    _startView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
    _startView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    _startView.layer.shadowOpacity = 0.5f;
    _startView.layer.shadowRadius = 8;
    _startView.layer.shadowPath = shadowPath.CGPath;
}

- (IBAction)startButtonClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DemoEcomViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DemoEcomVC"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)initializeLayout {
    [self changeButtonStyle:self.startDemoButton];
}

- (void)changeButtonStyle:(UIButton *)button {
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:36/255.0 green:172/255.0 blue:255/255.0 alpha:0.7].CGColor;
    button.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
