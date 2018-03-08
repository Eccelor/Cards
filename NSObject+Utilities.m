//
//  NSObject+Utilities.m
//
//  Created by Eccelor on 18/09/17.
//  Copyright © 2017 Eccelor. All rights reserved.
//

#import "NSObject+Utilities.h"

@implementation NSObject (Utilities)

+ (BOOL) isNil: (NSObject *) object
{
    return !object || object == nil || object == [NSNull null];
}

@end
