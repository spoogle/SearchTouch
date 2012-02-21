//
//  CDIndex.h
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CDIndexForWord.h"
#import "CDDocDetails.h"
#import "DocTree.h"
#import "DocDetails.h"
#import "SearchDefs.h"

@interface CDIndex : NSManagedObject

@property (nonatomic, retain) NSNumber *pndocs;
@property (nonatomic, retain) NSNumber *pavgdoclen;
@property (nonatomic, retain) NSSet *indicesforwords;
@property (nonatomic, retain) NSString *sourcename;
@property (nonatomic) int ndocs;
@property (nonatomic) double avgdoclen;

+ (CDIndex *)addIndex;
- (DocTree *)indexForWord:(NSString *)word;
- (DocDetails *)detailsForDoc:(uint32_t)docid;
- (void)addDetailsForDoc:(DocID)docid andName:(NSString *)name andText:(NSString *)text andLength:(int)len;
- (void)addIndexForWord:(NSString *)w withData:(NSArray *)data andNumberOfOccurrencesInDocset:(int)nDocsContainingWord;
- (int)numberOfDocumentsContainingWord:(NSString *)w;
- (BOOL)hasBeenBuilt;
- (void)save;
- (CDIndex *)flush;
// following make private
- (CDIndexForWord *)cdindexforword:(NSString *)word;
+ (CDIndex *)loadIndex;

@end

@interface CDIndex (CoreDataGeneratedAccessors)

- (void)addIndicesforwordsObject:(NSManagedObject *)value;
- (void)removeIndicesforwordsObject:(NSManagedObject *)value;
- (void)addIndicesforwords:(NSSet *)values;
- (void)removeIndicesforwords:(NSSet *)values;
@end
