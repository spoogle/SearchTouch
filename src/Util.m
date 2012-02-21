//
//  Util.m
//  Search
//
//  Created by Julian Richardson on 1/30/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Util.h"

@implementation Util

+ (void)append:(NSString *)s toOutput:(NSMutableString *)o {
    NSLog(@"%@",s);
    if (o) {
        [o appendString:s];
        [o appendString:@"\n"];
    }
}

@end
