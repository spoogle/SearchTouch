//
//  Payload.m
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Posting.h"
#import "PostingPlaceholder.h"

@implementation Posting

+ (id)allocWithZone:(NSZone *)zone {
    return [PostingPlaceholder sharedPostingPlaceholder];
}

- (NSString *)description {
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"DocID:%d, %d positions:", self.docid, self.npostings];
    for (int i=0; i < self.npostings; i++) {
        [desc appendFormat:@" %d",(self.positions)[i]];
    }
    return [NSString stringWithString:desc];
}
@end
