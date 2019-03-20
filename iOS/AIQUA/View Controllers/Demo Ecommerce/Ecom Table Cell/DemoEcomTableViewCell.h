//
//  DemoEcomTableViewCell.h
//  AIQUA
//
//  Created by Shiv.Raj on 10/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Category;
@protocol CategoryCellProtocol;

@interface DemoEcomTableViewCell : UITableViewCell

- (void)initWithData:(Category *)category;

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UIButton *viewAllButton;

@property (nonatomic) Category * category;

@property (nonatomic, assign) id <CategoryCellProtocol> delegate;

@end

@protocol CategoryCellProtocol <NSObject>

- (void)categoryCellSelected:(Category *)category;

@end
