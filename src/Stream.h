//
//  Stream.h
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"
#import "DocTree.h"
#import "Posting.h"

@interface Stream : DocTree {
    int index;
    NSString *_term;
    NSArray *_nodeData;
    Posting *_match;
    id<Tree> current;
}

/*! Index into data array of last element returned from seek */
@property (nonatomic, assign) int index;
@property (nonatomic, copy) NSString *term;
/*! Data array from last seek, or nil */
@property (nonatomic, retain) NSArray *nodeData;
@property (nonatomic, retain) Posting *match;
@property (nonatomic, assign) id<Tree> current;

- (id)initWithTree:(DocTree *)t forWord:(NSString *)w;
- (id)seek:(DocID)docid;
- (void)reset;
@end
