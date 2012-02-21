//
//  SearchResult.h
//  Search
//
//  Created by Julian Richardson on 1/31/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"

@interface SearchResult : NSObject {
    int _rank;
    double _score;
    DocID _docid;
    NSString *_docname;
    NSString *_snippet;
    NSDictionary *_payloads;
}

@property (nonatomic) int rank;
@property (nonatomic) double score;
@property (nonatomic) DocID docid;
@property (nonatomic, copy) NSString *docname;
@property (nonatomic, copy) NSString *snippet;
@property (nonatomic, retain) NSDictionary *payloads;

- (id)initWithRank:(int)rank andScore:(double)score andDocID:(DocID)docid andDocname:(NSString *)docname andSnippet:(NSString *)snippet andPayloads:(NSDictionary *)payloads;
@end
