//
//  CategoryCollectionViewController.m
//  AIQUA
//
//  Created by Shiv.Raj on 13/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "CategoryCollectionViewController.h"
#import "CategoryCollectionViewCell.h"
#import "ProductDetailViewController.h"
#import "Product.h"
#import "Utility.h"
#import "QGSdk.h"
#import "Category.h"

@interface CategoryCollectionViewController ()<UICollectionViewDelegateFlowLayout>

@end

@implementation CategoryCollectionViewController

@synthesize categoryProducts;
@synthesize category;

static NSString * const reuseIdentifier = @"CategoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [[QGSdk getSharedInstance] logEvent:CATEGORY_VIEWED withParameters:@{CATEGORY_NAME: category.name, CATEGORY_DEEPLINK: category.deeplink}];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return categoryProducts.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Product *product = [[Product alloc] initWithJSONData:categoryProducts[indexPath.row]];
    [cell initWithData: product];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    Product *product = [[Product alloc] initWithJSONData:categoryProducts[indexPath.row]];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    vc.product = product;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect rect = self.view.bounds;
    
//    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    CGFloat height = 260;
    CGFloat width = (rect.size.width - 36)/2;
    
    return CGSizeMake(width, height);
}

@end
