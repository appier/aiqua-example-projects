//
//  LoginViewController.m
//  AIQUA
//
//  Created by Shiv.Raj on 9/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"
#import "NotificationManager.h"
#import "Utility.h"
#import "QGSdk.h"

@interface LoginViewController ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

@property (weak, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet UIView *getStartedView;
@property (weak, nonatomic) IBOutlet UIButton *getStartedButton;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initialiseLayout];
    [self changeButtonStatus:false];
    [self.nameTextField becomeFirstResponder];
    
    // add picker done button
    [self addToolbarForPicker];
}

- (void)addToolbarForPicker {
    CGRect rect = self.view.bounds;
    CGRect frame = CGRectMake(0, rect.size.height - 200, rect.size.width, 216);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:frame];
    pickerView.showsSelectionIndicator = true;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = Color(0, 0, 0, 0.85);
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.translucent = true;
    [toolbar sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonDone:)];
    
    [toolbar setItems:@[doneButton]];
    toolbar.userInteractionEnabled = true;
    
    _countryTextField.inputView = pickerView;
    _countryTextField.inputAccessoryView = toolbar;
}

- (void)barButtonDone:(UIBarButtonItem *)sender {
    [self.view endEditing:true];
}

- (void)viewDidAppear:(BOOL)animated {
    [self initialiseLayout];
}

#pragma mark - UITextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if ([textField isEqual:_nameTextField]) {
        [_emailTextField becomeFirstResponder];
    } else if ([textField isEqual:_emailTextField]) {
        [_companyTextField becomeFirstResponder];
    } else if ([textField isEqual:_companyTextField]) {
        [_countryTextField becomeFirstResponder];
    }
    
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self validateForm];
    
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self validateForm];
    
    return true;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UIPickerView Delegate & Data Source

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [Utility country].count;
}

// The data to return for the row and component (column) that's being passed in
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [Utility country][row][@"name"];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        self.countryTextField.text = nil;
    } else {
        self.countryTextField.text = [Utility country][row][@"name"];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:row forKey:SELECTED_COUNTRY_INDEX];
}

// Enable and Disable the button
- (void)changeButtonStatus:(BOOL)status {
    _getStartedButton.enabled = status;
    if (status) {
        _getStartedView.layer.opacity = 1;
        _getStartedButton.enabled = true;
    } else {
        _getStartedView.layer.opacity = 0.3;
        _getStartedButton.enabled = false;
    }
}

- (IBAction)agreementClicked:(UIButton *)sender {
    if (!sender.selected) {
        sender.layer.opacity = 0.8;
    } else {
        sender.layer.opacity = 0.4;
    }
    [sender setSelected:!sender.selected];
    [self validateForm];
}

- (void)initialiseLayout {
    // layout textfield bottom border and placeholder color
    UIColor *color = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.1];
    _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Work Email" attributes:@{NSForegroundColorAttributeName: color}];
    _companyTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Company" attributes:@{NSForegroundColorAttributeName: color}];
    _countryTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Country" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self setViewBorder:_nameTextField];
    [self setViewBorder:_emailTextField];
    [self setViewBorder:_companyTextField];
    [self setViewBorder:_countryTextField];
//    [self setViewBorder:_agreeButton];
    _nameTextField.delegate = self;
    _emailTextField.delegate = self;
    _companyTextField.delegate = self;
    _countryTextField.delegate = self;
    
    _agreeButton.layer.borderColor = [UIColor colorWithRed:36/255.0 green:172/255.0 blue:255/255.0 alpha:0.7].CGColor;
    _agreeButton.layer.borderWidth = 1;
    _agreeButton.layer.cornerRadius = 4;
    _agreeButton.layer.opacity = 0.4;
    
    _formView.layer.cornerRadius = 8;
    _getStartedView.layer.cornerRadius = 5;
    
    _getStartedView.layer.borderColor = [UIColor colorWithRed:36/255.0 green:172/255.0 blue:255/255.0 alpha:0.7].CGColor;
    _getStartedView.layer.borderWidth = 1;
    
    _getStartedView.layer.opacity = 0.3;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_formView.bounds];
    _formView.layer.masksToBounds = NO;
    _formView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
    _formView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    _formView.layer.shadowOpacity = 0.5f;
    _formView.layer.shadowRadius = 8;
    _formView.layer.shadowPath = shadowPath.CGPath;
    
    [_formView layoutSubviews];
}

- (void)setViewBorder:(UIView *)view {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3].CGColor;
    border.frame = CGRectMake(0, view.frame.size.height - borderWidth, view.frame.size.width, view.frame.size.height);
    border.borderWidth = borderWidth;
    [view.layer addSublayer:border];
    view.layer.masksToBounds = YES;
}

- (void)validateForm {
    if ([self isFormValid]) {
        [self changeButtonStatus:true];
    } else {
        [self changeButtonStatus:false];
    }
}

// valid name and email check
- (BOOL)isFormValid {
    BOOL isName = [_nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0;
    BOOL isCountry = [_countryTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0;
    BOOL isCompany = [_companyTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0;
    BOOL isEmail = [self validEmail:_emailTextField.text];
    
    BOOL isAgreed = self.agreeButton.selected;
    
    return isName && isEmail && isCompany && isCountry && isAgreed;
}

- (BOOL) validEmail:(NSString*) emailString {
    
    if ([emailString length] == 0) {
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)getStartedClicked:(id)sender {
    NSString *name = self.nameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *company = self.companyTextField.text;
    NSString *trimmedName = [name stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimmedEmail = [email stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimmedCompany = [company stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:true forKey:AIQUA_LOGIN_STATUS];
    [defaults setValue:trimmedName forKey:NAME];
    [defaults setValue:trimmedEmail forKey:WORK_EMAIL];
    [defaults setValue:trimmedCompany forKey:COMPANY];
    
    // initialise sdk
    NSInteger selectedCountry = [[NSUserDefaults standardUserDefaults] integerForKey:SELECTED_COUNTRY_INDEX];
    NotificationManager *manager = [NotificationManager sharedInstance];
    [manager initializeSDKWithAppId];
    
    //request push permission
    [manager requestPushPermission];
    
    QGSdk *qgsdk = [QGSdk getSharedInstance];
    
    [qgsdk setName:trimmedName];
    [qgsdk setEmail:trimmedEmail];
    [qgsdk setCustomKey:WORK_EMAIL withValue:trimmedEmail];
    [qgsdk setCustomKey:COMPANY withValue:trimmedCompany];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:homeVC animated:true];
}

@end
