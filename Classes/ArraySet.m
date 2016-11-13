//
//  ArraySet.m
//  Basic
//
//  Created by Алексей Неронов on 04.11.15.
//  Copyright © 2015 Алексей Неронов. All rights reserved.
//

#import "ArraySet.h"

@implementation ArraySet

@synthesize name=_name;
@synthesize value=_value;
@synthesize size=_size;
@synthesize size2=_size2;

#pragma mark NSCoding

#define kValue @"Value"
#define kName  @"Name"
#define kSize  @"Size"
#define kSize2  @"Size2"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_value forKey:kValue];
    [encoder encodeObject:_name forKey:kName];
    [encoder encodeInt:_size forKey:kSize];
    [encoder encodeInt:_size2 forKey:kSize2];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [self init]))
    {
        _value = [decoder decodeObjectForKey:kValue];
        _name = [decoder decodeObjectForKey:kName];
        _size = [decoder decodeIntForKey:kSize];
        _size2 = [decoder decodeIntForKey:kSize2];
    }
    return [self init];
}

@end
