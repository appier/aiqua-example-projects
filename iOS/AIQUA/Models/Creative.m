//
//  Creative.m
//  AIQUA
//
//  Created by Shiv.Raj on 15/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "Creative.h"

@implementation Creative

@synthesize type;
@synthesize name;
@synthesize event;
@synthesize button;
@synthesize detail;
@synthesize icon;

- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.type = [data[@"type"] integerValue];
        self.name = data[@"name"];
        self.event = data[@"event"];
        self.button = data[@"button"];
        self.detail = data[@"detail"];
        self.icon = data[@"icon"];
    }
    return self;
}

@end
