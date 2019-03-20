//
//  Category.h
//  AIQUA
//
//  Created by Shiv.Raj on 12/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

- (id)initWithJSONData:(NSDictionary*)data;

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *deeplink;

@end
