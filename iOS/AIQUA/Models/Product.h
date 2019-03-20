//
//  Product.h
//  AIQUA
//
//  Created by Shiv on 10/08/18.
//  Copyright (c) 2018 APPIER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

- (id)initWithJSONData:(NSDictionary*)data;

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *ratingsCount;
@property (nonatomic, copy) NSString *originalPrice;
@property (nonatomic, copy) NSString *discountedPrice;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *deeplink;

@end
