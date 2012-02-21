//
//  PostingCDW.m
//  Search
//
//  Created by Julian Richardson on 2/7/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "PostingCDW.h"

@implementation PostingCDW
@synthesize posting=_posting;

- (PostingCDW *)initWithDocID:(DocID)_docid andContents:(NSArray *)contents {
    if ((self = [super init])) {
        self.posting = [CDPosting addPosting];
        self.posting.docid = _docid;
        [self.posting setPositionsFromArray:contents];
    }
    return self;        
}

- (PostingCDW *)initWithCoreData:(CDPosting *)p {
    if (( self = [super init] )) {
        self.posting = p;
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return NSAllocateObject([self class], 0, zone);
}

- (DocID)docid {
    return self.posting.docid;
}

- (uint32_t *)positions {
    return [self.posting positions];
}

- (int)npostings {
    return self.posting.npostings;
}


- (void)dealloc {
    [_posting release];
    [super dealloc];
}

@end
