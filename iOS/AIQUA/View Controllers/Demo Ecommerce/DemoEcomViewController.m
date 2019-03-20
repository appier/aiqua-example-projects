//
//  DemoEcomViewController.m
//  AIQUA
//
//  Created by Shiv.Raj on 10/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "DemoEcomViewController.h"
#import "DemoEcomTableViewCell.h"
#import "CategoryCollectionViewController.h"
#import "Category.h"
#import "Utility.h"
#import "QGSdk.h"
#import "UIImageView+WebCache.h"

@interface DemoEcomViewController ()<UITableViewDelegate, UITableViewDataSource, CategoryCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *getNotificationButton;
@property (weak, nonatomic) IBOutlet UILabel *coverTitle;

@end

@implementation DemoEcomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeLayout];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DemoEcomTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *category_name = @"default";
    if ([defaults boolForKey:CATEGORY_VIEWED_STATUS]) {
        category_name = [defaults valueForKey:LAST_VIEWED_CATEGORY_NAME];
    }
    NSString *page_name = [@"ecomHomeScreen_" stringByAppendingString:category_name];
    [[QGSdk getSharedInstance] logEvent:PAGE_VIEWED withParameters:@{PAGE_NAME: page_name, CATEGORY_NAME: category_name}];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:CATEGORY_VIEWED_STATUS]) {
        NSString *image = [defaults objectForKey:LAST_VIEWED_CATEGORY_IMAGE];
        NSString *title = [defaults objectForKey:LAST_VIEWED_CATEGORY_TITLE];
        self.coverTitle.text = title;
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:image]];
        self.getNotificationButton.hidden = false;
        self.explainLabel.hidden = true;
    } else {
        self.coverTitle.text = @"AIQUA\n1:1 Personalization\nDemo";
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:@"https://cdn.qgraph.io/img/aiqua-demo/ecomHomeScreen/ecomHomeScreen_cover.jpg"]];
        self.getNotificationButton.hidden = true;
        self.explainLabel.hidden = false;
    }
}

#pragma mark - TableView Delegates

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DemoEcomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Category *category = [[Category alloc] initWithJSONData:[Utility category][indexPath.row]];
    [cell initWithData:category];
    cell.delegate = self;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (IBAction)getNotificationClicked:(id)sender {
    [[QGSdk getSharedInstance] logEvent:CLICKED_PERSONALIZED_NOTIF];
}

#pragma mark - Category Select Protocol

- (void)categoryCellSelected:(Category *)category {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:CATEGORY_VIEWED_STATUS]) {
        [defaults setBool:true forKey:CATEGORY_VIEWED_STATUS];
    }
    [defaults setValue:category.image forKey:LAST_VIEWED_CATEGORY_IMAGE];
    [defaults setValue:category.title forKey:LAST_VIEWED_CATEGORY_TITLE];
    [defaults setValue:category.name forKey:LAST_VIEWED_CATEGORY_NAME];
    self.coverTitle.text = category.title;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:category.image]];
    self.getNotificationButton.hidden = true;
    self.explainLabel.hidden = false;
    [self pushToCategoryPage:category];
}

- (void)pushToCategoryPage:(Category *)category {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryCollectionViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CategoryVC"];
    vc.title = category.name;
    vc.category = category;
    vc.categoryProducts = [Utility products][category._id];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)initializeLayout {
    self.coverImageView.layer.masksToBounds = true;
    [self changeButtonStyle:self.getNotificationButton];
}

- (void)changeButtonStyle:(UIButton *)button {
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    button.layer.borderColor = BUTTON_BORDER_COLOR.CGColor;
    button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
