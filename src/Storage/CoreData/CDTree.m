//
//  CDTree.m
//  Search
//
//  Created by Julian Richardson on 1/31/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "CDTree.h"
#import "CDManager.h"
#import "PostingCDW.h"

@implementation CDTree

@dynamic root;
@dynamic p;
@dynamic ppostings;
@dynamic max;
@dynamic pivot;
@dynamic l;
@dynamic r;

- (void)setInfo:(DocID)max pivot:(DocID)pivot data:(NSArray *)data {
    self.max = [NSNumber numberWithInt:max];
    self.pivot = [NSNumber numberWithInt:pivot];
    self.postings = data;
}

/*! Pull set of postings from core data store, wrap each one into a PostingCDW and return a sorted array of the wrapped postings. */
- (NSArray *)postings {
    [self willAccessValueForKey:@"postings"];
    NSSet *pp = self.ppostings;
    [self didAccessValueForKey:@"postings"];
    NSMutableArray *wrappedPostings = [NSMutableArray array];
    for (CDPosting *p in pp) {
        [wrappedPostings addObject:[[[PostingCDW alloc] initWithCoreData:p] autorelease]];
    }
    return [wrappedPostings sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"docid" ascending:YES]]];
}

- (void)setPostings:(NSArray *)postings {
    NSMutableSet *unwrappedPostings = [NSMutableSet set];
    for (PostingCDW *p in postings) {
        [unwrappedPostings addObject:[p posting]];
    }
    self.ppostings = unwrappedPostings;
}

+ (TreeInfo *)infoFromData:(NSData *)infodata {
    return (TreeInfo *)[infodata bytes];
}

+ (CDTree *)addTree {
    CDTree *new = [NSEntityDescription insertNewObjectForEntityForName:@"CDTree" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    new.root = new;
    new.p = NULL;
    return new;
}

- (CDTree *)addTree {
    return [[self class] addTree];
}

- (id)initWithTree:(CDTree *)t {
    return t;
}

- (void)appendChild:(CDTree *)child {
    if (self.l) {
        self.r = child;
    }
    else self.l = child;
}

- (BOOL)isLeaf {
    return (!self.l && !self.r);
}

- (CDTree *)left {
    return self.l;
}

- (CDTree *)right {
    return self.r;
}

- (CDTree *)parent {
    return self.p;
}

- (CDTree *)reset {
    return self.root;
}

#ifdef DEBUG_FAULTS
- (void)awakeFromFetch {
    NSLog(@"CDTree awakefromfetch");
    [super awakeFromFetch];
}

- (void)willTurnIntoFault {
    NSLog(@"CDTree will fault for tree %p",self);
    [super willTurnIntoFault];
}
#endif

- (BOOL)nonEmpty {
    return YES;
}

@end
