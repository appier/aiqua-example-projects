//
//  CategoryCollectionViewCell.m
//  AIQUA
//
//  Created by Shiv.Raj on 13/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "Product.h"
#import "UIImageView+WebCache.h"

@implementation CategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundCover.layer.cornerRadius = 5;
    self.backgroundCover.layer.masksToBounds = YES;
}

- (void)initWithData:(Product *)product {
    self.productName.text = product.name;
    self.productDiscountedPrice.text = product.discountedPrice;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.thumbnail] placeholderImage:[UIImage imageNamed:@"preview-image.png"]];
    self.productColor.text = [NSString stringWithFormat:@"• %@", product.color];
    self.productDescription.text = [NSString stringWithFormat:@"• %@", product.description];
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:product.originalPrice];
    [string addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(0, string.length)];
    
    self.productOriginalPrice.attributedText = string;
}

@end
