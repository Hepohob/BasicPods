//
//  forSet.m
//  Basic
//
//  Created by Алексей Неронов on 12.11.16.
//  Copyright © 2015 Алексей Неронов. All rights reserved.
//

#import "ForSet.h"

@implementation ForSet
@synthesize  forLine=_forLine ;
@synthesize  forName=_forName ;
@synthesize  forStep=_forStep ;
@synthesize  forTo=_forTo ;

#pragma mark NSCoding

#define kForLine @"ForLine"
#define kForName @"ForName"
#define kForStep @"ForStep"
#define kForTo @"ForTo"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_forLine forKey:kForLine];
    [encoder encodeObject:_forName forKey:kForName];
    [encoder encodeObject:_forStep forKey:kForStep];
    [encoder encodeObject:_forTo forKey:kForTo];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [self init]))
    {
        _forLine = [decoder decodeObjectForKey:kForLine];
        _forName = [decoder decodeObjectForKey:kForName];
        _forStep = [decoder decodeObjectForKey:kForStep];
        _forTo = [decoder decodeObjectForKey:kForTo];
    }
    return [self init];
}

@end
