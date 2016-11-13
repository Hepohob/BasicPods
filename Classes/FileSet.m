//
//  FileSet.m
//  MCX Basic
//
//  Created by Алексей Неронов on 28.06.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

#import "FileSet.h"

@implementation FileSet

@synthesize mode;
@synthesize name;
@synthesize value;

#pragma mark NSCoding

#define kFileMode  @"FileMode"
#define kFileName  @"FileName"
#define kFileValue @"FileValue"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:mode forKey:kFileMode];
    [encoder encodeObject:name forKey:kFileName];
    [encoder encodeObject:value forKey:kFileValue];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [self init]))
    {
        mode = [decoder decodeObjectForKey:kFileMode];
        name = [decoder decodeObjectForKey:kFileName];
        value = [decoder decodeObjectForKey:kFileValue];
    }
    return [self init];
}

@end