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

@end
