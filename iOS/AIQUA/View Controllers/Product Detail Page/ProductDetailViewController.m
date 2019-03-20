//
//  ProductDetailViewController.m
//  AIQUA
//
//  Created by Shiv.Raj on 13/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "Product.h"
#import "UIImageView+WebCache.h"
#import "QGSdk.h"
#import "Utility.h"

@interface ProductDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productColor;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;

@property (weak, nonatomic) IBOutlet UIView *ratingView;

@property (weak, nonatomic) IBOutlet UILabel *productRating;
@property (weak, nonatomic) IBOutlet UILabel *productRatingCount;

@property (weak, nonatomic) IBOutlet UILabel *discoutedPrice;
@property (weak, nonatomic) IBOutlet UILabel *originalPrice;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UIButton *wishlistButton;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;

@end

@implementation ProductDetailViewController

@synthesize product;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.layer.masksToBounds = YES;
    
    self.navigationItem.title = product.name;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:[UIImage imageNamed:@"preview-image"]];
    
    self.productName.text = product.name;
    self.productColor.text = [NSString stringWithFormat:@"• %@", product.color];
    self.productDescription.text = [NSString stringWithFormat:@"• %@", product.description];
    self.productRating.text = product.rating;
    self.productRatingCount.text = [product.ratingsCount stringByAppendingString:@" ratings"];
    self.discoutedPrice.text = product.discountedPrice;
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:product.originalPrice];
    [string addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(0, string.length)];
    self.originalPrice.attributedText = string;
    
    self.discount.text = [NSString stringWithFormat:@"%@ off", product.discount];
    
    [self sendEventWithName:PRODUCT_VIEWED];
}

- (IBAction)addedToWishList:(UIButton *)sender {
    if (sender.selected) {
        [sender setSelected:false];
    } else {
        [sender setSelected:true];
        [self sendEventWithName:ADDED_TO_WISHLIST];
    }
}

- (IBAction)addedToCart:(UIButton *)sender {
    if (sender.selected) {
        [sender setSelected:false];
    } else {
        [sender setSelected:true];
        [self sendEventWithName:ADDED_TO_CART];
    }
}

- (void)sendEventWithName:(NSString *)eventName {
    [[QGSdk getSharedInstance] logEvent:eventName withParameters:@{
                                                                     PRODUCT_NAME: product.name,
                                                                     PRODUCT_PRICE: product.discountedPrice,
                                                                     PRODUCT_RATING: product.rating,
                                                                     PRODUCT_CATEGORY: product.category,
                                                                     PRODUCT_IMAGE_URL: product.image,
                                                                     PRODUCT_DEEPLINK: product.deeplink
                                                                     }];
}

@end
