//
//  Index.m
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Index.h"
#import "CDIndex.h"
#import "CFTreeIndex.h"
#import "IndexPlaceholder.h"

@implementation Index
@dynamic sourcename;
@dynamic ndocs;
@dynamic avgdoclen;

+ (id)allocWithZone:(NSZone *)zone {
    return [IndexPlaceholder sharedIndexPlaceholder];
}

/*! Index the files with names read from filename */
- (void)buildIndex:(NSDictionary *)options {
    BOOL storetext = (options && [options valueForKey:@"storetext"] && [[options valueForKey:@"storetext"] boolValue] == YES);
    double totaldoclen = 0.0;
    /*! Number of documents containing each word - used for IDF calculation */
    NSMutableDictionary *nDocsContainingWord = [NSMutableDictionary dictionary];
    NSMutableDictionary *wordToDocTreeMapping = [NSMutableDictionary dictionary];
    NSString *fileList = [NSString stringWithContentsOfFile:self.sourcename encoding:NSStringEncodingConversionAllowLossy error:nil];
    NSArray *files = [fileList componentsSeparatedByString:@"\n"];
    self.ndocs = (int)[files count];
    int onePercent = self.ndocs / 100;
    if (onePercent == 0) onePercent = 1;
    
    int i = 0;
    for (NSString *f in files) {
        if (++i % onePercent == 0) {
            putc('.',stdout);
            fflush(stdout);
        }
        Extractor *e = [[Extractor alloc] initWithFile:f];
        [self addDetailsForDoc:[e docid] andName:f andText:(storetext ? [e tokenizedText] : @"") andLength:[e doclen]];
        totaldoclen += [e doclen];
        for (NSString *w in [[e wordPositions] allKeys]) {
            NSMutableArray *val;
            if (!( val = [wordToDocTreeMapping valueForKey:w] )) {
                val = [NSMutableArray array];
                [wordToDocTreeMapping setValue:val forKey:w];
            }
            Posting *payload = [[[Posting alloc] initWithDocID:[e docid] andContents:[[e wordPositions] valueForKey:w]] autorelease];
            [val addObject:payload];
            
            // keep count of how many documents contain each word
            NSNumber *previousCount = [nDocsContainingWord valueForKey:w];
            if (previousCount) {
                [nDocsContainingWord setValue:[NSNumber numberWithInt:1+[previousCount intValue]] forKey:w];
            }
            else {
                [nDocsContainingWord setValue:[NSNumber numberWithInt:1] forKey:w];
            }
        }
        [e release];
    }
    
    NSLog(@"%d words in index",[[wordToDocTreeMapping allKeys] count]);
    for (NSString *w in [wordToDocTreeMapping allKeys]) {
        // build index for word
        [self addIndexForWord:w withData:[wordToDocTreeMapping valueForKey:w] andNumberOfOccurrencesInDocset:[[nDocsContainingWord valueForKey:w] intValue]];
    }
    self.avgdoclen = totaldoclen / self.ndocs;
    
    [self save];
}

@end
