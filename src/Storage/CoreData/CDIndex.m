//
//  CDIndex.m
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "CDIndex.h"
#import "CDManager.h"
#import "CDTree.h"

@implementation CDIndex

@dynamic indicesforwords;
@dynamic sourcename;
@dynamic pndocs;
@dynamic pavgdoclen;

+ (CDIndex *)addIndex {
    CDIndex *new = [NSEntityDescription insertNewObjectForEntityForName:@"CDIndex" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    return new;
}

- (int)numberOfDocumentsContainingWord:(NSString *)w; {
    CDIndexForWord *i = [self cdindexforword:w];
    if (i) {
        return [i numberOfOccurrencesInDocset];
    }
    return 0;
}

- (int)ndocs {
    [self willAccessValueForKey:@"ndocs"];
    uint32_t r = [self.pndocs intValue];
    [self didAccessValueForKey:@"ndocs"];
    return r;
}

- (void)setNdocs:(int)ndocs {
    self.pndocs = [NSNumber numberWithInt:ndocs];
}

- (double)avgdoclen {
    [self willAccessValueForKey:@"avgdoclen"];
    uint32_t r = [self.pavgdoclen intValue];
    [self didAccessValueForKey:@"avgdoclen"];
    return r;
}

- (void)setAvgdoclen:(double)avgdoclen {
    self.pavgdoclen = [NSNumber numberWithInt:avgdoclen];
}

- (CDIndexForWord *)cdindexforword:(NSString *)word {
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDIndexForWord" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.word == %@",word];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [[[CDManager sharedCDManager] managedObjectContext] executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error fetching index for word %@: %@", word, [error description]);
        return nil;
    }
    if ([array count] == 0) {
        return nil;
    }
    CDIndexForWord *i = [array objectAtIndex:0];
    return i;
}

- (DocTree *)indexForWord:(NSString *)word {
    CDIndexForWord *i = [self cdindexforword:word];
    return [[[DocTree alloc] initWithWord:word andTree:i.index andNumberOfOccurrencesInDocset:i.numberOfOccurrencesInDocset] autorelease];
}

- (DocDetails *)detailsForDoc:(uint32_t)docid {
    CDDocDetails *d;
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDDocDetails" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    [request setEntity:entity];


    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.pdocid == %d",docid];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [[[CDManager sharedCDManager] managedObjectContext] executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error fetching details for doc id %d: %@", docid, [error description]);
        return nil;
    }
    if ([array count] == 0) {
        return nil;
    }
    d = [array objectAtIndex:0];
    DocDetails *ret = [[[DocDetails alloc] initWithDocID:docid] autorelease];
    ret.name = d.name;
    ret.text = d.text;
    ret.len = d.len;
    return ret;
}

- (void)addDetailsForDoc:(DocID)docid andName:(NSString *)name andText:(NSString *)text andLength:(int)len {
    CDDocDetails *d = [CDDocDetails addDocDetails];
    d.docid = docid;
    d.name = name;
    d.text = text;
    d.len = len;
}

- (void)addIndexForWord:(NSString *)w withData:(NSArray *)data andNumberOfOccurrencesInDocset:(int)nDocsContainingWord {
    CDTree *tree = [CDTree addTree];
    DocTree *t = [[[DocTree alloc] initWithTree:tree] autorelease];
    t.data = data;
    CDIndexForWord *windex = [CDIndexForWord addIndexForWord];
    windex.word = w;
    windex.index = tree;
    windex.numberOfOccurrencesInDocset = nDocsContainingWord;
    [self addIndicesforwordsObject:windex];
}

- (void)save {
    NSError *error = nil;
    NSLog(@"Data saving started");
    [[[CDManager sharedCDManager] managedObjectContext] save:&error];
    NSLog(@"Data save finished");
    if (error) {
        NSLog(@"Error saving core data context %@",[error description]);
    }
}

+ (CDIndex *)loadIndex {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDIndex" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *array = [[[CDManager sharedCDManager] managedObjectContext] executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Could not load index: %@", [error description]);
        return nil;
    }
    if ([array count] == 0) {
        return nil;
    }
    return [array objectAtIndex:0];
}

- (CDIndex *)flush {
    [[[CDManager sharedCDManager] managedObjectContext] reset];
    return [[self class] loadIndex];
}

- (BOOL)hasBeenBuilt {
    return (self.ndocs > 0);
}

#ifdef DEBUG_FAULTS
- (void)willTurnIntoFault {
    NSLog(@"CDIndex will turn %p into fault",self);
    [super willTurnIntoFault];
}
#endif

@end
