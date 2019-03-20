//
//  CategoryCollectionViewCell.h
//  AIQUA
//
//  Created by Shiv.Raj on 13/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@interface CategoryCollectionViewCell : UICollectionViewCell

- (void)initWithData:(Product *)product;

@property (weak, nonatomic) IBOutlet UIView *backgroundCover;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productColor;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *productDiscountedPrice;
@property (weak, nonatomic) IBOutlet UILabel *productOriginalPrice;

@end
