//
//  IndexCDW.m
//  Search
//
//  Created by Julian Richardson on 2/8/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "IndexCDW.h"

@implementation IndexCDW
@synthesize index=_index;

- (id)initWithFilenamesFromFile:(NSString *)_filename {
    if (( self = [super init] )) {
        self.index = [CDIndex loadIndex];
        if (!self.index) {
            self.index = [CDIndex addIndex];
            self.index.sourcename = _filename;
        }
    }
    return self;
}

- (id)init {
    self = [super init];
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return NSAllocateObject([self class], 0, zone);
}

- (NSString *)sourcename {
    return self.index.sourcename;
}

- (void)setSourcename:(NSString *)source {
    self.index.sourcename = [source copy];
}

- (double)avgdoclen {
    return self.index.avgdoclen;
}

- (void)setAvgdoclen:(double)x {
    self.index.avgdoclen = x;
}

- (int)ndocs {
    return self.index.ndocs;
}

- (void)setNdocs:(int)n {
    self.index.ndocs = n;
}

- (BOOL)hasBeenBuilt {
    return [self.index hasBeenBuilt];
}

- (void)save {
    [self.index save];
}

- (DocTree *)indexForWord:(NSString *)word {
    return [self.index indexForWord:word];
}

+ (IndexCDW *)addIndex {
    IndexCDW *new = [[IndexCDW alloc] init];
    new.index = [CDIndex addIndex];
    return new;
}

- (DocDetails *)detailsForDoc:(uint32_t)docid{
    return [self.index detailsForDoc:docid];
}

- (void)addDetailsForDoc:(DocID)docid andName:(NSString *)name andText:(NSString *)text andLength:(int)len {
    [self.index addDetailsForDoc:docid andName:name andText:text andLength:len];
}

- (void)addIndexForWord:(NSString *)w withData:(NSArray *)data andNumberOfOccurrencesInDocset:(int)nDocsContainingWord {
    [self.index addIndexForWord:w withData:data andNumberOfOccurrencesInDocset:nDocsContainingWord];
}

- (int)numberOfDocumentsContainingWord:(NSString *)w {
    return [self.index numberOfDocumentsContainingWord:w];
}

- (IndexCDW *)flush {
    self.index = [self.index flush];
    return self;
}

+ (IndexCDW *)loadIndex {
    IndexCDW *new = [[IndexCDW alloc] init];
    new.index = [CDIndex loadIndex];
    return new;
}

- (void)dealloc {
    [_index release];
    [super dealloc];
}

@end
