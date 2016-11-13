//
//  VariableSet.m
//  Basic
//
//  Created by Алексей Неронов on 16.10.15.
//  Copyright © 2015 Алексей Неронов. All rights reserved.
//

#import "VariableSet.h"

@implementation VariableSet

@synthesize var = _var;
@synthesize name = _name;
@synthesize stringType = _stringType;

#pragma mark NSCoding

#define kVarValue @"VarValue"
#define kVarName  @"VarName"
#define kVarType  @"VarType"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_var forKey:kVarValue];
    [encoder encodeObject:_name forKey:kVarName];
    [encoder encodeBool:_stringType forKey:kVarType];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [self init]))
    {
        _var = [decoder decodeObjectForKey:kVarValue];
        _name = [decoder decodeObjectForKey:kVarName];
        _stringType = [decoder decodeBoolForKey:kVarType];
    }
    return [self init];
}

@end