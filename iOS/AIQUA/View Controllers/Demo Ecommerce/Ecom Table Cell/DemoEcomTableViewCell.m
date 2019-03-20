//
//  DemoEcomTableViewCell.m
//  AIQUA
//
//  Created by Shiv.Raj on 10/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "DemoEcomTableViewCell.h"
#import "Category.h"
#import "Utility.h"
#import "UIImageView+WebCache.h"

@implementation DemoEcomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.viewAllButton.layer.cornerRadius = 5;
    self.categoryImageView.layer.masksToBounds = true;
}

- (void)initWithData:(Category *)category {
    self.category = category;
    self.categoryName.text = category.name;
    [self.categoryImageView sd_setImageWithURL:[NSURL URLWithString:category.thumbnail]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)viewAllClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(categoryCellSelected:)]) {
        [self.delegate categoryCellSelected:self.category];
    }
}

@end
