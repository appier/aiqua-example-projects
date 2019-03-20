//
//  Creative.h
//  AIQUA
//
//  Created by Shiv.Raj on 15/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

@interface Creative : NSObject

- (id)initWithJSONData:(NSDictionary*)data;

@property (nonatomic, assign) Type type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *event;
@property (nonatomic, copy) NSString *button;
@property (nonatomic, copy) NSString *icon;

@end
