//
//  Extractor.h
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"

/*! Parse the given data source and determine document title,
 document ID, document text, and document word positions */
@interface Extractor : NSObject {
    NSString *source;
    NSString *text;
    NSString *tokenizedText;
    int doclen;
    NSString *title;
    DocID docid;
    NSMutableDictionary *wordPositions;
    NSMutableDictionary *stopWords;
}

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSString *tokenizedText;
@property (nonatomic, assign) DocID docid;
@property (nonatomic, assign) int doclen;
@property (nonatomic, assign) NSMutableDictionary *wordPositions;
@property (nonatomic, retain) NSMutableDictionary *stopWords;

- (void)tokenizeDocument;
- (id)initWithFile:(NSString *)filename;
- (id)initWithString:(NSString *)text;
- (NSString *)canonicalize:(NSString *)word;
@end
