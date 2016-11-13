//
//  ArraySet.h
//  Basic
//
//  Created by Алексей Неронов on 04.11.15.
//  Copyright © 2015 Алексей Неронов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArraySet : NSObject <NSCoding>
{
    NSMutableArray* _value;
    NSString* _name;
    int _size;
    int _size2;
}

@property(nonatomic, readwrite) NSMutableArray* value;
@property(nonatomic, readwrite) NSString* name;
@property(nonatomic, readwrite) int size;
@property(nonatomic, readwrite) int size2;

@end
