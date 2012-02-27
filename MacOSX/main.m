//
//  main.m
//  SearchMacOSX
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "Search.h"
#import "Index.h"
#import "CFTreeTree.h"
#import "CDTree.h"
#import "Util.h"

int main (int argc, const char * argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    Index *index = [[Index alloc] initWithFilenamesFromFile:@"/Users/me/SearchTouch/world_factbook/files.txt"];
    if (!index || ![index hasBeenBuilt]) {
        [index buildIndex:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"storetext"]];
    }
    
    NSMutableString *searchtermtext = [NSMutableString string];

    BOOL gotquery = NO;
    for (int i=1; i<argc; i++) {
        NSString *arg = [NSString stringWithCString:argv[i] encoding:NSStringEncodingConversionAllowLossy];
        if (gotquery) {
            [searchtermtext appendFormat:@"%@ ", arg];
        }
        if ([arg isEqualToString:@"-q"]) {
            gotquery = YES;
        }
    }
    
    NSMutableString *output = [NSMutableString string];
    
    Search *s = [[Search alloc] initWithQueryString:searchtermtext andIndex:index];
    s.output = output;
    
    [Util append:@"Start" toOutput:output];
    NSArray *matches = [s rankedResults];
    [Util append:@"End" toOutput:output];
    [s release];
    
    [pool drain];
    return 0;
}

