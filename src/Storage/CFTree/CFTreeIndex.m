//
//  CFIndex.m
//  Search
//
//  Created by Julian Richardson on 2/6/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "CFTreeIndex.h"
#import "CFTreeTree.h"

@implementation CFTreeIndex

@synthesize indexesForWords=_indexesForWords;
@synthesize detailsForDocs=_detailsForDocs;
@synthesize numberOfDocumentsContainingWord=_numberOfDocumentsContainingWord;
@synthesize ndocs;
@synthesize sourcename=_sourcename;
@synthesize avgdoclen;

- (id)initWithFilenamesFromFile:(NSString *)_filename {
    if (( self = [super init] )) {
        self.sourcename = _filename;
        self.detailsForDocs = [NSMutableDictionary dictionary];
        self.indexesForWords = [NSMutableDictionary dictionary];
        self.numberOfDocumentsContainingWord = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return NSAllocateObject([self class], 0, zone);
}

- (void)dealloc {
    [_indexesForWords release];
    [_detailsForDocs release];
    [_numberOfDocumentsContainingWord release];
    [_sourcename release];
    [super dealloc];
}

+ (CFTreeIndex *)addIndex {
    return [[[[self class] alloc] init] autorelease];
}

- (int)numberOfDocumentsContainingWord:(NSString *)w; {
    NSNumber *n = [self.numberOfDocumentsContainingWord valueForKey:w];
    if (w) {
        return [n intValue];
    }
    return 0;
}

- (DocTree *)indexForWord:(NSString *)word {
    return [self.indexesForWords valueForKey:word];
}

- (DocDetails *)detailsForDoc:(uint32_t)docid {
    return [self.detailsForDocs objectForKey:[NSNumber numberWithInt:docid]];
}

- (void)addDetailsForDoc:(DocID)docid andName:(NSString *)name andText:(NSString *)text andLength:(int)len {
    DocDetails *d = [[[DocDetails alloc] initWithDocID:docid] autorelease];
    d.name = name;
    d.text = text;
    d.len = len;
    [self.detailsForDocs setObject:d forKey:[NSNumber numberWithInt:docid]];
}

- (void)addIndexForWord:(NSString *)w withData:(NSArray *)data andNumberOfOccurrencesInDocset:(int)nDocsContainingWord {
    id <Tree> tree = [CFTreeTree addTree];
    DocTree *t = [[[DocTree alloc] initWithTree:tree] autorelease];
    t.data = data;
    [self.indexesForWords setValue:t forKey:w];
    [self.numberOfDocumentsContainingWord setValue:[NSNumber numberWithInt:nDocsContainingWord] forKey:w];
}

- (void)save {
}

- (CFTreeIndex *)flush {
    return self;
}

+ (CFTreeIndex *)loadIndex {
    return nil;
}

- (BOOL)hasBeenBuilt {
    return NO;
}

@end

