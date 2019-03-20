//
//  Category.m
//  AIQUA
//
//  Created by Shiv.Raj on 12/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "Category.h"

@implementation Category

@synthesize _id;
@synthesize name;
@synthesize title;
@synthesize image;
@synthesize thumbnail;
@synthesize deeplink;

- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self._id = data[@"_id"];
        self.name =  data[@"name"];
        self.title = data[@"title"];
        self.image = data[@"image"];
        self.thumbnail = data[@"thumbnail"];
        self.deeplink = data[@"deeplink"];
    }
    return self;
}

@end
