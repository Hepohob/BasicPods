//
//  Files.m
//  MCX Basic
//
//  Created by Алексей Неронов on 28.06.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

#import "Files.h"
#import "GlobalVars.h"
#import "FileSet.h"
#import "NormalizeString.h"
#import "DigitalFunc.h"

@implementation Files {
    GlobalVars *globals;
    NormalizeString *normaStr;
    DigitalFunc *digitalFunc;
}

-(bool) openFile:(NSString*)pathAndName forMode:(NSString*)mode asNumber:(NSInteger)number {
    globals = [GlobalVars sharedInstance];
    normaStr = [[NormalizeString alloc]init];
    
    pathAndName = [normaStr removeSpaceInBegin:pathAndName];
    pathAndName = [pathAndName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    
    bool result=false;
    FileSet *fileSetCurrent;
    fileSetCurrent = [globals.filesList objectAtIndex:number];
    if ([fileSetCurrent.mode isEqualToString:@"empty"])
        if (pathAndName.length>0 && number>0 && number<99) {
            if ([mode isEqualToString:@"output"]) {
                fileSetCurrent.mode = mode;
                fileSetCurrent.name = [documentsDirectory stringByAppendingPathComponent:pathAndName];
                [globals.filesList replaceObjectAtIndex:number withObject:fileSetCurrent];
                result = true;
            } else if ([mode isEqualToString:@"input"] || [mode isEqualToString:@"append"]) {
                fileSetCurrent.mode = mode;
                fileSetCurrent.name = [documentsDirectory stringByAppendingPathComponent:pathAndName];
                fileSetCurrent.value = [self readFile:fileSetCurrent.name];
                //NSLog(@"±±±±INPUT value-'%@'",fileSetCurrent.value);
                if (fileSetCurrent.value.length>0){
                    [globals.filesList replaceObjectAtIndex:number withObject:fileSetCurrent];
                    result=true;
                }
            }
        }
//    fileSetCurrent = [globals.filesList objectAtIndex:number];
    //    NSLog(@"±±±±openFile filesList mode-'%@' number-'%ld' file-'%@'",fileSetCurrent.mode,(long)number,fileSetCurrent.name);
    return result;
}

-(bool) closeFile:(NSInteger)number {
    globals = [GlobalVars sharedInstance];
    bool result=false;
    FileSet *fileSetCurrent = [globals.filesList objectAtIndex:number];
    if ([fileSetCurrent.mode isEqualToString:@"output"] || [fileSetCurrent.mode isEqualToString:@"append"]) {
        NSError *error;
        BOOL succeed = [fileSetCurrent.value writeToFile:fileSetCurrent.name
                                              atomically:YES
                                                encoding:NSUTF8StringEncoding
                                                   error:&error];
        if (!succeed) {
            globals.error = @"Bad file number or file name\n";
        }
        //        NSLog(@"closeFile error -'%@'",error);
        [globals.filesList replaceObjectAtIndex:number withObject:[self emptyFileSet]];
        result=succeed;
    } else if ([fileSetCurrent.mode isEqualToString:@"input"]) {
    } else if ([fileSetCurrent.mode isEqualToString:@"append"]) {
    } else {
        globals.error = @"File not OPEN\n";
    }
    
    //    NSLog(@"±±±±closeFile mode-'%@' number-'%ld' value-'%@'",fileSetCurrent.mode,(long)number,fileSetCurrent.value);
    return result;
}

-(bool) printFile:(NSString*)string forOutputAs:(NSInteger)number {
    globals = [GlobalVars sharedInstance];
    FileSet *fileSetCurrent = [globals.filesList objectAtIndex:number];
    bool result=false;
    if ([fileSetCurrent.mode isEqualToString:@"output"] || [fileSetCurrent.mode isEqualToString:@"append"]){
        result=true;
        fileSetCurrent.value = [NSString stringWithFormat:@"%@%@",fileSetCurrent.value,string];
        [globals.filesList replaceObjectAtIndex:number withObject:fileSetCurrent];
        //        NSLog(@"±±±± value-'%@'",fileSetCurrent.value);
    } else if ([fileSetCurrent.mode isEqualToString:@"input"]) {
        
    } else {
        globals.error = @"File not OPEN\n";
    }
    
    return result;
}

-(NSString*) inputAs:(NSInteger)number {
    globals = [GlobalVars sharedInstance];
    FileSet* fileSetCurrent = [globals.filesList objectAtIndex:number];
    NSMutableArray* arrInput = [NSMutableArray arrayWithArray:[fileSetCurrent.value componentsSeparatedByString: @"\n"]];
    NSString* curString;
    //NSLog(@"±±±± count=%lu value-'%@'\n%@",[arrInput count],[arrInput objectAtIndex:0],fileSetCurrent.value);
    if ([arrInput count]>1) {
        curString = [arrInput objectAtIndex:0];
        [arrInput removeObjectAtIndex:0];
        fileSetCurrent.value  = [arrInput componentsJoinedByString: @"\n"];
    } else {
        globals.error = @"Input past end\n";
    }
    return curString;
}

-(void) clear {
    globals = [GlobalVars sharedInstance];
    for (int i = 0; i < 99; i++) [globals.filesList replaceObjectAtIndex:i withObject:[self emptyFileSet]];
}

-(FileSet*)emptyFileSet {
    FileSet *fileSetCurrent=[[FileSet alloc]init];
    fileSetCurrent.mode = @"empty";
    fileSetCurrent.name = @"";
    fileSetCurrent.value = @"";
    return fileSetCurrent;
}

-(NSString*)readFile:(NSString*)pathAndName {
    globals = [GlobalVars sharedInstance];
    NSString* result=@"";
    NSError *error;
    result = [NSString stringWithContentsOfFile:pathAndName encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        result = @"";
        globals.error = @"File not found\n";
    }
    //    NSLog(@"±±±±readFile result-'%@' err-'%@' filemname-'%@'",result,error,pathAndName);
    return result;
}

-(int) eof:(NSInteger)number {
    globals = [GlobalVars sharedInstance];
    FileSet* fileSetCurrent = [globals.filesList objectAtIndex:number];
    if ([fileSetCurrent.mode isEqualToString:@"input"]){
        return (int)[[NSMutableArray arrayWithArray:[fileSetCurrent.value componentsSeparatedByString: @"\n"]] count]-2;
    } else {
        globals.error = @"Direct statement in file\n";
        return 0;
    }
}

-(NSMutableArray*)listReformat:(NSString*)string {
    digitalFunc=[[DigitalFunc alloc]init];
    int counter=0;
    NSMutableArray* result = [NSMutableArray arrayWithArray:[string componentsSeparatedByString: @"\n"]];
    if ([result count]>0){
        for (int i=0; i<[result count]; i++) {
            string = [result objectAtIndex:i];
            if (![digitalFunc isOnlyDigitsAndNotEmpty:[self returnBaseCommand:string]]){
                counter+=10;
                string = [NSString stringWithFormat:@"%d %@",counter,string];
                [result replaceObjectAtIndex:i withObject:string];
            } else {
                int oldCount=counter;
                counter = [self returnBaseCommand:string].intValue;
                if (oldCount>=counter) {
                    counter+=10;
                    string = [NSString stringWithFormat:@"%d %@",counter,[string substringFromIndex:[string rangeOfString:@" "].location+1]];
                    [result replaceObjectAtIndex:i withObject:string];
                }
            }
        }
    }
    return result;
}


-(NSString*) returnBaseCommand:(NSString*)string
{
    NSString* result = [string componentsSeparatedByString:@" "][0];
    globals = [GlobalVars sharedInstance];
    for (int i=0; i<[globals.listOfAll count]; i++) {
        NSRange range=[[string lowercaseString] rangeOfString:[globals.listOfAll objectAtIndex:i]];
        if (range.location != NSNotFound && range.location==0) result=[globals.listOfAll objectAtIndex:i];
    }
    return result;
}

@end
