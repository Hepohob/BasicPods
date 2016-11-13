//
//  Files.h
//  MCX Basic
//
//  Created by Алексей Неронов on 28.06.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Files : NSObject

-(bool) openFile:(NSString*)pathAndName forMode:(NSString*)mode asNumber:(NSInteger)number;
-(bool) closeFile:(NSInteger)number;
-(bool) printFile:(NSString*)string forOutputAs:(NSInteger)number;
-(int) eof:(NSInteger)number;
-(NSString*) inputAs:(NSInteger)number;
-(void) clear;
-(NSMutableArray*)listReformat:(NSString*)string;

@end
