//
//  Search.m
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Search.h"
#import "Extractor.h"
#import "Util.h"
#import "SearchResult.h"

@implementation Search
@synthesize index=_index;
@synthesize streams=_streams;
@synthesize acceptedTerms=_acceptedTerms;
@synthesize deletedTerms=_deletedTerms;
@synthesize lastDocID=_lastDocID;
@synthesize output=_output;

/*! Designated initializer */
- (id)initWithTerms:(NSArray *)terms andIndex:(Index *)index {
    if (( self = [super init] )) {
        self.index = index;
        self.lastDocID = -1;
        self.streams = [NSMutableArray array];
        self.deletedTerms = [NSMutableArray array];
        self.acceptedTerms = [NSMutableArray array];
        for (NSString *term in terms) {
            DocTree *tree = [self.index indexForWord:term];
            if (tree) {
                [self.acceptedTerms addObject:term];
                [self.streams addObject:[[[Stream alloc] initWithTree:tree forWord:term] autorelease]];
            }
            else {
                [self.deletedTerms addObject:term];
            }
        }
    }
    return self;
}

/*! Tokenize query and return initialized search for query terms */
- (id)initWithQueryString:(NSString *)query andIndex:(Index *)index {
    Extractor *e = [[Extractor alloc] initWithString:query];
    NSArray *terms = [[e wordPositions] allKeys];
    [e release];
    return [self initWithTerms:terms andIndex:index];
}

- (void)dealloc {
    [_index release];
    [_streams release];
    [_deletedTerms release];
    [super dealloc];
}

// TODO: intersection should just be the seek method of an Intersection subclass of Stream. Likewise union and negation.

/*! Search for a DocID which is in every stream.
 
 Loop through streams until either all at position lastDocID, 
 or some stream returns nil => no match 
 When a stream seeks to a position > lastDocID then we reset the counter and loop back 
 When a stream seeks to a position = lastDocID we move the stream to the end of the queue and advance to the next stream
 */
- (NSMutableDictionary *)intersection {
    if (0 == [self.streams count]) return nil;
    // keep count of how many streams we have processed in current 
    // search for an intersection
    int numberOfStreamsToSeek = [self.streams count];
    
    self.lastDocID++;
  
    while (YES) {
        Posting *p = [[self.streams objectAtIndex:0] seek:self.lastDocID];
        if (!p) {
            return nil;
        }
                
        if ([p docid] > self.lastDocID) {
            // failed to find docID in current stream
            // found docID becomes the one we are searching for
            self.lastDocID = [p docid];
            [self moveFirstStreamToBack];
            
            // reset the other streams
            numberOfStreamsToSeek = [self.streams count];
            for (int i=0; i < numberOfStreamsToSeek; i++) {
                [(Stream *)[self.streams objectAtIndex:i] reset];
            }
        }
        else {
            numberOfStreamsToSeek--;
            if (0 == numberOfStreamsToSeek) {
                // search successful - return result
                return [self result];
            } 
            else {
                // found docID in current stream - continue searching
                // the remaining streams
                [self moveFirstStreamToBack];
            }
        }
    }
}

- (void)moveFirstStreamToBack {
    Stream *s = [self.streams objectAtIndex:0];
    [s retain];
    [self.streams removeObjectAtIndex:0];
    [self.streams addObject:s];
    [s release];
}

- (NSMutableDictionary *)result {
    NSMutableDictionary *match = [NSMutableDictionary dictionary];
    for (Stream *s in self.streams) {
        NSString *term = [s term];
        Posting *p = [s match];
        [match setValue:p forKey:term];
    }
    return match;
}

/*! Build array of results and rank them using TFIDF following formulae in:
 http://en.wikipedia.org/wiki/Probabilistic_relevance_model_(BM25)
 */
- (NSArray *)rankedResults {
    NSMutableArray *results = [NSMutableArray array];
    [Util append:[NSString stringWithFormat:@"Matches for %@", self.acceptedTerms] toOutput:self.output];
    
    NSMutableDictionary *idfDict = [NSMutableDictionary dictionary];
    while (( [self intersection] )) {
        NSMutableDictionary *match = [self result];
        int docid = [[[match allValues] objectAtIndex:0] docid];
        DocDetails *docdetails = [self.index detailsForDoc:docid];
        int doclen = [docdetails len];
        NSString *filename = [[docdetails name] lastPathComponent];
        double score = 0.0;
        for (NSString *term in match) {
            // is it OK to return a CDPosting here?
            Posting *payload = [match valueForKey:term];
            int nmatches = [payload npostings];
            NSNumber *idfn = [idfDict valueForKey:term];
            double idf;
            if (idfn) {
                idf = [idfn doubleValue];
            }
            else {
                int numberOfDocsContainingTerm = [self.index numberOfDocumentsContainingWord:term];
                // scale and set to a very small positive value in 
                // case it is negative, which happens when the term
                // appears in more than half the documents in the 
                // corpus
                idf = 1000.0*log((self.index.ndocs - numberOfDocsContainingTerm + 0.5) / (numberOfDocsContainingTerm + 0.5));
                if (idf < 0.0) idf = 1.0;
                [idfDict setValue:[NSNumber numberWithDouble:idf] forKey:term];
            }
            double k1 = 1.5;
            double b = 0.75;
            double tfidf = idf * nmatches * (1.0 + k1) / (nmatches + k1 * (1.0 - b + b * doclen / self.index.avgdoclen));
            score = score + tfidf;
        }
        [results addObject:[[[SearchResult alloc] initWithRank:-1 andScore:score andDocID:docid andDocname:filename andSnippet:@"" andPostingsForTerms:match] autorelease]];
    }

    [results sortUsingComparator:(NSComparator)^(id a, id b) 
                         {
                         return [[NSNumber numberWithDouble:[b score]] compare:[NSNumber numberWithDouble:[a score]]];
                         }
                         ];
    [Util append:[NSString stringWithFormat:@"%d results", [results count]] toOutput:self.output];
    int rank = 1;
    for (SearchResult *result in results) {
        result.rank = rank++;
        [Util append:[NSString stringWithFormat:@"%@",[result docname]] toOutput:self.output];
    }
    return results;
}

@end
