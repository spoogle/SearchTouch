//
//  Tree.h
//  Search
//
//  Created by Julian Richardson on 10/29/11.
//  Copyright (c) 2011 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//
#import "SearchDefs.h"

/*! Interface for tree class which is used to store search index. */
@protocol Tree

+ (id <Tree>)addTree;
- (id <Tree>)addTree;
- (id)initWithTree:(id <Tree>)t;
- (void)appendChild:(id <Tree>)child;
- (BOOL)isLeaf;
- (id <Tree>)left;
- (id <Tree>)right;
- (id <Tree>)parent;
- (id <Tree>)reset;
- (NSArray *)postings;
- (void)setInfo:(DocID)max pivot:(DocID)pivot data:(NSArray *)data;
- (NSNumber *)max;
- (NSNumber *)pivot;
- (void)release;
- (BOOL)nonEmpty;

@end
