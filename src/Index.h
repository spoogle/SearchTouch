//
//  Index.h
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "DocTree.h"
#import "Extractor.h"
#import "Tree.h"
#import "DocDetails.h"
#import "CDIndex.h"

@interface Index : NSObject

@property (nonatomic, copy) NSString *sourcename;
@property (nonatomic) double avgdoclen;
@property (nonatomic) int ndocs;

/*! Designated initializer. Stores name of file from which to read
 names of files to index, but does no actual indexing. */
- (id)initWithFilenamesFromFile:(NSString *)_filename;
/*! Index the files with names read from filename */
- (void)buildIndex:(NSDictionary *)options;
/*! The DocTree index for a given word */
- (DocTree *)indexForWord:(NSString *)word;
- (DocDetails *)detailsForDoc:(DocID)docid;
- (int)numberOfDocumentsContainingWord:(NSString *)word;
- (BOOL)hasBeenBuilt;

+ (Index *)addIndex;
- (void)addDetailsForDoc:(DocID)docid andName:(NSString *)name andText:(NSString *)text andLength:(int)len;
- (void)addIndexForWord:(NSString *)w withData:(NSArray *)data andNumberOfOccurrencesInDocset:(int)nDocsContainingWord;
- (void)save;
- (Index *)flush;
+ (Index *)loadIndex;
@end
