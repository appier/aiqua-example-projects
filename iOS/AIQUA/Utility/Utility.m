//
//  Utility.m
//  AIQUA
//
//  Created by Shiv.Raj on 9/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "Utility.h"

@implementation Utility

static Utility *sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Utility alloc] init];
    });
    return sharedInstance;
}

+ (NSArray *)country {
    static NSArray *data;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = @[
                    @{
                        @"name": @"select country",
                        },
                    @{
                        @"name": @"TAIWAN",
                        },
                    @{
                        @"name": @"SINGAPORE",
                        },
                    @{
                        @"name": @"HONG KONG",
                        },
                    @{
                        @"name": @"MALAYSIA",
                        },
                    @{
                        @"name": @"INDONESIA",
                        },
                    @{
                        @"name": @"INDIA",
                        },
                    @{
                        @"name": @"VIETNAM",
                        },
                    @{
                        @"name": @"THAILAND",
                        },
                    @{
                        @"name": @"JAPAN",
                        },
                    @{
                        @"name": @"KOREA",
                        }
                ];
    });
    return data;
}

// -------------------------------------------------
#pragma mark - Ecommerce Demo Data
// -------------------------------------------------

+ (NSArray *)category {
    static NSArray *categoryData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        categoryData = @[
                         @{
                             @"_id": @"c0",
                             @"name": @"Fashion",
                             @"title": @"Shop\nNew Arrival in\nFashion",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/ecomHomeScreen/ecomHomeScreen_CategoryA_cover.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/ecomHomeScreen/ecomHomeScreen_CategoryA_thumbnail.jpg",
                             @"deeplink": @"aiquademo://category/c0"
                             },
                         @{
                             @"_id": @"c1",
                             @"name": @"Shoes",
                             @"title": @"Latest\nStyles in\nShoes",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/ecomHomeScreen/ecomHomeScreen_CategoryB_cover.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/ecomHomeScreen/ecomHomeScreen_CategoryB_thumbnail.jpg",
                             @"deeplink": @"aiquademo://category/c1"
                             },
                         @{
                             @"_id": @"c2",
                             @"name": @"Electronics",
                             @"title": @"Looking\nfor an\nUpgrade?",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/ecomHomeScreen/ecomHomeScreen_CategoryC_cover.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/ecomHomeScreen/ecomHomeScreen_CategoryC_thumbnail.jpg",
                             @"deeplink": @"aiquademo://category/c2"
                             },
                         @{
                             @"_id": @"c3",
                             @"name": @"Pet Supplies",
                             @"title": @"Only\nThe Best\nFor Your\nBest Friend",
                             @"image": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/ecomHomeScreen_CategoryD_cover.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/ecomHomeScreen_CategoryD_thumbnail.jpg",
                             @"deeplink": @"aiquademo://category/c3"
                             }
                ];
    });
    
    return categoryData;
}

+ (NSDictionary *)products {
    static NSDictionary *data;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = @{
                 @"c0": @[
                         @{
                             @"_id": @0,
                             @"name": @"Generic Striped T-Shirt",
                             @"category": @"Fashion",
                             @"color": @"Black and White",
                             @"description": @"Slim Fit",
                             @"original_price": @"29.99",
                             @"discounted_price": @"$ 19.99",
                             @"discount": @"33%",
                             @"rating": @"4.4",
                             @"rating_count": @"5,112",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryA_product1.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryA_product1.jpg",
                             @"deeplink": @"aiquademo://products/c0/0"
                             },
                         @{
                             @"_id": @1,
                             @"name": @"Generic Sweater",
                             @"category": @"Fashion",
                             @"color": @"Women Sweater",
                             @"description": @"Half Sleeved",
                             @"original_price": @"74.99",
                             @"discounted_price": @"$ 49.99",
                             @"discount": @"33%",
                             @"rating": @"3.9",
                             @"rating_count": @"8,434",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryA_product2.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryA_product2.jpg",
                             @"deeplink": @"aiquademo://products/c0/1"
                             },
                         @{
                             @"_id": @2,
                             @"name": @"Generic Henley T-Shirt",
                             @"category": @"Fashion",
                             @"color": @"Blue and White",
                             @"description": @"Regular Fit",
                             @"original_price": @"29.99",
                             @"discounted_price": @"$ 24.99",
                             @"discount": @"17%",
                             @"rating": @"4.1",
                             @"rating_count": @"8,302",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryA_product3.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryA_product3.jpg",
                             @"deeplink": @"aiquademo://products/c0/2"
                             },
                         @{
                             @"_id": @3,
                             @"name": @"Generic Checkered Shirt",
                             @"category": @"Shoes",
                             @"color": @"Blue, Black and White",
                             @"description": @"Slim Fit, Full Sleeves",
                             @"original_price": @"49.99",
                             @"discounted_price": @"$ 39.99",
                             @"discount": @"20%",
                             @"rating": @"4.3",
                             @"rating_count": @"1,978",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryA_product4.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryA_product4.jpg",
                             @"deeplink": @"aiquademo://products/c0/3"
                             }
                 ],
                 
                 @"c1": @[
                         @{
                             @"_id": @0,
                             @"name": @"Sports Shoes",
                             @"category": @"Shoes",
                             @"color": @"Grey Color",
                             @"description": @"Foam Padding",
                             @"original_price": @"129.99",
                             @"discounted_price": @"$ 99.99",
                             @"discount": @"23%",
                             @"rating": @"4.5",
                             @"rating_count": @"4,429",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryB_product1.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryB_product1.jpg",
                             @"deeplink": @"aiquademo://products/c1/0"
                             },
                         @{
                             @"_id": @1,
                             @"name": @"Running Shoes",
                             @"category": @"Shoes",
                             @"color": @"Aqua Green",
                             @"description": @"Foam Sole",
                             @"original_price": @"399.99",
                             @"discounted_price": @"$ 299.99",
                             @"discount": @"25%",
                             @"rating": @"4.0",
                             @"rating_count": @"6,814",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryB_product2.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryB_product2.jpg",
                             @"deeplink": @"aiquademo://products/c1/1"
                             },
                         @{
                             @"_id": @2,
                             @"name": @"Stilettos",
                             @"category": @"Shoes",
                             @"color": @"Blue and Gold",
                             @"description": @"4 inch Heels",
                             @"original_price": @"499.99",
                             @"discounted_price": @"$ 249.99",
                             @"discount": @"50%",
                             @"rating": @"4.8",
                             @"rating_count": @"1,446",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryB_product3.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryB_product3.jpg",
                             @"deeplink": @"aiquademo://products/c1/2"
                             },
                         @{
                             @"_id": @3,
                             @"name": @"Sneakers",
                             @"category": @"Shoes",
                             @"color": @"Yellow Color",
                             @"description": @"Lace-Up, Synthetic",
                             @"original_price": @"249.99",
                             @"discounted_price": @"$ 199.99",
                             @"discount": @"20%",
                             @"rating": @"3.9",
                             @"rating_count": @"377",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryB_product4.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryB_product4.jpg",
                             @"deeplink": @"aiquademo://products/c1/3"
                             }
                 ],
                 
                 @"c2": @[
                         @{
                             @"_id": @0,
                             @"name": @"Generic Headphone",
                             @"category": @"Electronics",
                             @"color": @"Silver Color",
                             @"description": @"Faux Leather Ear Pads",
                             @"original_price": @"149.99",
                             @"discounted_price": @"$ 99.99",
                             @"discount": @"33%",
                             @"rating": @"4.3",
                             @"rating_count": @"9,256",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryC_product1.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryC_product1.jpg",
                             @"deeplink": @"aiquademo://products/c2/0"
                             },
                         @{
                             @"_id": @1,
                             @"name": @"Generic Laptop",
                             @"category": @"Electronics",
                             @"color": @"Very Fast Processor",
                             @"description": @"Included Optical Drive",
                             @"original_price": @"1499.99",
                             @"discounted_price": @"$ 1099.99",
                             @"discount": @"27%",
                             @"rating": @"3.5",
                             @"rating_count": @"3,827",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryC_product2.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryC_product2.jpg",
                             @"deeplink": @"aiquademo://products/c2/1"
                             },
                         @{
                             @"_id": @2,
                             @"name": @"Generic Printer",
                             @"category": @"Electronics",
                             @"color": @"A4 Size",
                             @"description": @"Ink Jet Technology",
                             @"original_price": @"249.99",
                             @"discounted_price": @"$ 199.99",
                             @"discount": @"20%",
                             @"rating": @"4.5",
                             @"rating_count": @"8,248",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryC_product3.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryC_product3.jpg",
                             @"deeplink": @"aiquademo://products/c2/2"
                             },
                         @{
                             @"_id": @3,
                             @"name": @"Generic Speakers",
                             @"category": @"Electronic",
                             @"color": @"2.1 Channel",
                             @"description": @"Powerful Bass",
                             @"original_price": @"199.99",
                             @"discounted_price": @"$ 149.99",
                             @"discount": @"25%",
                             @"rating": @"4.1",
                             @"rating_count": @"9,987",
                             @"image": @"https://cdn.qgraph.io/img/aiqua-demo/productScreen/productScreen_CategoryC_product4.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/aiqua-demo/productsListing/productListing_CategoryC_product4.jpg",
                             @"deeplink": @"aiquademo://products/c2/3"
                             }
                 ],
                 
                 @"c3": @[
                         @{
                             @"_id": @0,
                             @"name": @"Small Dog White Meat Chicken",
                             @"category": @"Pet Supplies",
                             @"color": @"7 lb. Bag",
                             @"description": @"Bite-sized kibble design",
                             @"original_price": @"17.99",
                             @"discounted_price": @"$ 15.99",
                             @"discount": @"11%",
                             @"rating": @"4.3",
                             @"rating_count": @"9,256",
                             @"image": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productScreen_CategoryD_product1.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productListing_CategoryD_product1.jpg",
                             @"deeplink": @"aiquademo://products/c3/0"
                             },
                         @{
                             @"_id": @1,
                             @"name": @"Dog Dental Chews Dog Treats",
                             @"category": @"Pet Supplies",
                             @"color": @"130-count pack",
                             @"description": @"Natural Ingredients",
                             @"original_price": @"29.99",
                             @"discounted_price": @"$ 26.99",
                             @"discount": @"10%",
                             @"rating": @"3.5",
                             @"rating_count": @"3,827",
                             @"image": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productScreen_CategoryD_product2.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productListing_CategoryD_product2.jpg",
                             @"deeplink": @"aiquademo://products/c3/1"
                             },
                         @{
                             @"_id": @2,
                             @"name": @"Bear Dog Toy",
                             @"category": @"Pet Supplies",
                             @"color": @"Soft and cuddly",
                             @"description": @"Extra durability",
                             @"original_price": @"14.99",
                             @"discounted_price": @"$ 10.99",
                             @"discount": @"33%",
                             @"rating": @"4.5",
                             @"rating_count": @"8,248",
                             @"image": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productScreen_CategoryD_product3.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productListing_CategoryD_product3.jpg",
                             @"deeplink": @"aiquademo://products/c3/2"
                             },
                         @{
                             @"_id": @3,
                             @"name": @"Premium Dog Bed",
                             @"category": @"Pet Supplies",
                             @"color": @"100% Polyester",
                             @"description": @"Soft and Cozy",
                             @"original_price": @"74.99",
                             @"discounted_price": @"$ 49.99",
                             @"discount": @"25%",
                             @"rating": @"4.1",
                             @"rating_count": @"9,987",
                             @"image": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productScreen_CategoryD_product4.jpg",
                             @"thumbnail": @"https://cdn.qgraph.io/img/574d03bff99b7e9109ec/productListing_CategoryD_product4.jpg",
                             @"deeplink": @"aiquademo://products/c3/3"
                             }
                 ]
        };
    });
    
    return data;
}




@end
