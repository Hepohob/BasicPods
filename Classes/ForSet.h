//
//  forSet.h
//  Basic
//
//  Created by Алексей Неронов on 12.11.16.
//  Copyright © 2015 Алексей Неронов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForSet : NSObject <NSCoding>
{
    NSString* _forLine;
    NSString* _forName;
    NSString* _forStep;
    NSString* _forTo;
}

@property(nonatomic, readwrite) NSString* forLine;
@property(nonatomic, readwrite) NSString* forName;
@property(nonatomic, readwrite) NSString* forStep;
@property(nonatomic, readwrite) NSString* forTo;

@end
