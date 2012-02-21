//
//  DocDetails.m
//  Search
//
//  Created by Julian Richardson on 2/2/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "DocDetails.h"

@implementation DocDetails

@synthesize docid, name, text, len;

- (id)initWithDocID:(DocID)_docid {
    if (( self = [super init] )) {
        self.docid = _docid;
    }
    return self;
}

- (void)dealloc {
    [name release];
    [text release];
    [super dealloc];
}

@end
