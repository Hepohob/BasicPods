//
//  FileSet.h
//  MCX Basic
//
//  Created by Алексей Неронов on 28.06.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSet : NSObject <NSCoding>
{
    NSString* mode;
    NSString* name;
    NSString* value;
}

@property(nonatomic, readwrite) NSString* mode;
@property(nonatomic, readwrite) NSString* name;
@property(nonatomic, readwrite) NSString* value;

@end