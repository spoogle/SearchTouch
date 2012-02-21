//
//  Stream.m
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Stream.h"
#import "CDTree.h"

@implementation Stream
@synthesize index;
@synthesize nodeData=_nodeData;
@synthesize match=_match;
@synthesize term=_term;
@synthesize current;

- (id)initWithTree:(DocTree *)t forWord:(NSString *)w {
    if (( self = [super initWithTree:t.tree] )) {
        // set search to start at root, no seek state
        index = 0;
        self.nodeData = nil;
        self.term = w;
        self.current = _tree;
    }
    return self;
}

- (void)dealloc {
    [_nodeData release];
    [_match release];
    [super dealloc];
}

/*! Return data item from first node with DocID >= docid. 
 
 Traverse the tree looking for docid. The state of the search is
 preserved after the search has finished, so next seek we 
 recommence with the tree we left off with, and if we were 
 looking through the array of data items in some node, we pick
 up again at the index'th element of the data array.
 
 Return nil if there are no more DocIDs >= docid.
 */
- (id)seek:(DocID)docid {
    while (current && [current nonEmpty]) {
        // get current node info
        DocID max = [[current max] intValue];
        DocID pivot = [[current pivot] intValue];
        // ascend to parent if docid is larger than maximum
        // docid held at or under this tree node
        if (docid > max) {
            self.nodeData = nil;
            current = [current parent];
            continue;
        }
        
        // current tree node is either a leaf 
        if ([current isLeaf]) {
            if (docid <= max) {
                // start index of search in data array
                int i0;
                if (self.nodeData) {
                    // we are continuing a previous search of this data
                    // array - start at element after that examined at last seek
                    i0 = index+1;
                }
                else {
                    // start at beginning of data array
                    i0 = 0;
                    self.nodeData = [current postings];
                }
                
                // search through array
                for (int i = i0; i < [self.nodeData count]; i++) {
                    Posting *p = [self.nodeData objectAtIndex:i];
                    if ([p docid] >= docid) {
                        // DocID >= docid found - return datum, seek state is
                        // preserved in Stream instance variables
                        index = i;
                        self.match = p;
                        return p;
                    }
                }
            }
            // data array exhausted or docid not in [min,max] range
            self.nodeData = nil;
            current = [current parent];
        }
        // or an intermediate node
        else if (docid <= pivot) {
            current = [current left];
            }
        else {
            current = [current right];
        }
    }
    return nil;
}

- (void)reset {
    current = [_tree reset];
    self.nodeData = nil;
    index = 0;
}
@end
