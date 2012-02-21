//
//  PostingCF.m
//  Search
//
//  Created by Julian Richardson on 2/7/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "PostingCF.h"

@implementation PostingCF
@synthesize docid;
@synthesize npostings=_npostings;
@synthesize positions=_positions;

- (id)initWithDocID:(DocID)_docid andContents:(NSArray *)contents {
    if (( self = [ super init] )) {
        self.docid = _docid;
        if (contents) {
            self.npostings = [contents count];
            self.positions = (uint32_t *)(calloc(self.npostings, sizeof(uint32_t)));
            for (int i=0; i < self.npostings; i++) {
                self.positions[i] = (uint32_t)[[contents objectAtIndex:i] intValue];
            }
        }
        else {
            self.npostings = 0;
            self.positions = NULL;
        }
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return NSAllocateObject([self class], 0, zone);
}

- (void)dealloc {
    free(_positions);
    [super dealloc];
}

- (NSString *)description {
    NSMutableString *contentsS = [NSMutableString string];
    for (int i=0; i < _npostings; i++) {
        [contentsS appendFormat:@"%d ", _positions[i]];
    }
    return [NSString stringWithFormat:@"%d: %@",docid,contentsS];
}

@end
