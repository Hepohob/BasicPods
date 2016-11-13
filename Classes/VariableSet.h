//
//  VariableSet.h
//  Basic
//
//  Created by Алексей Неронов on 16.10.15.
//  Copyright © 2015 Алексей Неронов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariableSet : NSObject <NSCoding>
{
    id _var;
    NSString* _name;
    BOOL _stringType;
}

@property(nonatomic, readwrite) id var;
@property(nonatomic, readwrite) NSString* name;
@property(nonatomic, readwrite) BOOL stringType;

@end