//
//  Product.m
//  AIQUA
//
//  Created by Shiv on 10/08/18.
//  Copyright (c) 2018 APPIER. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize _id;
@synthesize name;
@synthesize category;
@synthesize color;
@synthesize description;
@synthesize originalPrice;
@synthesize discountedPrice;
@synthesize discount;
@synthesize rating;
@synthesize ratingsCount;
@synthesize image;
@synthesize thumbnail;
@synthesize deeplink;

- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self._id = [data[@"_id"] integerValue];
        self.name =  data[@"name"];
        self.category = data[@"category"];
        self.color = data[@"color"];
        self.description = data[@"description"];
        self.originalPrice = data[@"original_price"];
        self.discountedPrice = data[@"discounted_price"];
        self.discount = data[@"discount"];
        self.rating = data[@"rating"];
        self.ratingsCount = data[@"rating_count"];
        self.image = data[@"image"];
        self.thumbnail = data[@"thumbnail"];
        self.deeplink = data[@"deeplink"];
    }
    
    return self;
}

@end
