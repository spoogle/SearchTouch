//
//  CDTree.h
//  Search
//
//  Created by Julian Richardson on 1/31/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Tree.h"
#import "SearchDefs.h"

@class CDTree;

@interface CDTree : NSManagedObject <Tree>

@property (nonatomic, retain) NSNumber *max;
@property (nonatomic, retain) NSNumber *pivot;
@property (nonatomic, assign) CDTree *root;
@property (nonatomic, retain) CDTree *p;
@property (nonatomic, retain) CDTree *l;
@property (nonatomic, retain) CDTree *r;
@property (nonatomic, retain) NSSet *ppostings;
@property (nonatomic, assign) NSArray *postings;

+ (TreeInfo *)infoFromData:(NSData *)infodata;
+ (CDTree *)addTree;
@end

