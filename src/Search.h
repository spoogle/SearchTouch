//
//  Search.h
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"
#import "Posting.h"
#import "DocTree.h"
#import "Stream.h"
#import "Index.h"

@interface Search : NSObject {
    Index *_index;
    NSMutableArray *_streams;
    NSMutableArray *_acceptedTerms;
    NSMutableArray *_deletedTerms;
    NSMutableString *_output;
    DocID _lastDocID;
}

@property (nonatomic, retain) Index *index;
@property (nonatomic, retain) NSMutableArray *streams;
@property (nonatomic, retain) NSMutableArray *acceptedTerms;
@property (nonatomic, retain) NSMutableArray *deletedTerms;
@property (nonatomic, retain) NSMutableString *output;
@property (nonatomic) DocID lastDocID;

/*! Designated initializer */
- (id)initWithTerms:(NSArray *)terms andIndex:(Index *)index;
- (id)initWithQueryString:(NSString *)query andIndex:(Index *)index;
- (NSMutableDictionary *)intersection;
- (void)moveFirstStreamToBack;
- (NSMutableDictionary *)result;
- (NSArray *)rankedResults;
@end
