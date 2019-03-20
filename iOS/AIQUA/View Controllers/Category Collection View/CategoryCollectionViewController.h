//
//  CategoryCollectionViewController.h
//  AIQUA
//
//  Created by Shiv.Raj on 13/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Category;
@interface CategoryCollectionViewController : UICollectionViewController

@property (nonatomic) NSArray *categoryProducts;
@property (nonatomic) Category *category;

@end
