//
//  DocTree.m
//  Search
//
//  Created by Julian Richardson on 8/29/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "DocTree.h"


@implementation DocTree
@synthesize tree=_tree;
@synthesize word=_word;
@synthesize numberOfOccurrencesInDocset=_numberOfOccurrencesInDocset;

- (void)dealloc {
    [_tree release];
    _tree = nil;
    [super dealloc];
}

/*! Designated initializer. Serves to provide class with an instance of a class
 meeting the Tree protocol, which encodes the underlying Tree methods. */
- (id)initWithTree:(id <Tree> )t {
    if ((self = [super init])) {
        self.tree = [t reset];
    }
    return self;
}

- (id)initWithWord:(NSString *)w andTree:(id <Tree> )tree andNumberOfOccurrencesInDocset:(int)numberOfOccurrencesInDocset {
    if (( self = [self initWithTree:tree] )) {
        self.numberOfOccurrencesInDocset = numberOfOccurrencesInDocset;
        self.word = w;
    }
    return self;
};

- (void)setData:(NSArray *)data {
    [self setData:data forTree:self.tree];
}

- (void)setData:(NSArray *)data forTree:(id <Tree>)parent {
    /*! info should be assumed to be retained by the tree, and
     should be released by the tree node release callback */
    DocID max = [(Posting *)[data lastObject] docid];
    DocID pivot = 0;
    NSArray *d = nil;
    if ([data count] < MAXSIZE) {
        // if data packet is small enough, set it at node and we are done
        /*! data is assumed retained by the tree node and should be
         released by the tree node release callback */
        d = data;
    }
    else {
        // otherwise split data packet in two, create two subtrees, and
        // assign them as children of parent
        pivot = [[data objectAtIndex:[data count] / 2 - 1] docid];
        id <Tree> left = [_tree addTree];
        id <Tree> right = [_tree addTree];
        [parent appendChild:left];
        [parent appendChild:right];
        [self setData:[data objectsAtIndexes:[[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, [data count] / 2)] autorelease]] forTree:left];
        [self setData:[data objectsAtIndexes:[[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange([data count] / 2, [data count] - [data count] / 2)] autorelease]] forTree:right];
    }
    [parent setInfo:max pivot:pivot data:d];
}

@end

