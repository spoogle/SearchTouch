//
//  Extractor.m
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Extractor.h"


@implementation Extractor
@synthesize source;
@synthesize text;
@synthesize tokenizedText;
@synthesize title;
@synthesize docid;
@synthesize doclen;
@synthesize wordPositions;
@synthesize stopWords;

/*! Designated initializer */
- (id)initWithString:(NSString *)_text {
    static int docidseq = 0;
    if (( self = [super init] )) {
        self.docid = ++docidseq;
        self.text = _text;
        self.stopWords = [NSMutableDictionary dictionary];
        for (NSString *stopWord in [NSArray arrayWithObjects:
                                    @"a",@"an",@"and",@"but",@"he",@"her",@"hers",@"him",@"his",@"how",@"i",@"it",@"its",@"of",@"or",@"she",@"the",@"their",@"them",@"there",@"these",@"they",@"to",@"who",@"why",@"where",@"when",@"what",@"which",@"you",@"your", nil]) {
            [stopWords setValue:[NSNumber numberWithBool:YES] forKey:stopWord];
        }
        self.wordPositions = [NSMutableDictionary dictionary];
        [self tokenizeDocument];
    }
    return self;
}

- (id)initWithFile:(NSString *)filename {
    if (( self = [self initWithString:[NSString stringWithContentsOfFile:filename encoding:NSStringEncodingConversionAllowLossy error:nil]] )) {
        self.source = filename;
    }
    return self;
}

- (NSString *)canonicalize:(NSString *)word {
    if ([stopWords valueForKey:word]) {
        return nil;
    }
    
    NSMutableString *cword = [NSMutableString stringWithString:word];
    NSRange matchRange = [word rangeOfString:@"'s" options:(NSBackwardsSearch | NSAnchoredSearch)];
    if (matchRange.location != NSNotFound) {
        [cword replaceCharactersInRange:matchRange withString:@""];
    }
    
    if ([cword compare:@"0.0"] == NSOrderedSame || [cword doubleValue] != 0.0) {
        return NUMBERTOKEN;
    }

    return cword;
}

- (void)tokenizeDocument {
    NSMutableString *tokenized = [NSMutableString string];
    NSString *lctext = [[self text] lowercaseString];
    
    CFStringTokenizerRef tokenizer = CFStringTokenizerCreate(NULL, (CFStringRef)lctext, CFRangeMake(0, [lctext length]), kCFStringTokenizerUnitWord, NULL);
    
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(tokenizer);
    range = CFStringTokenizerGetCurrentTokenRange(tokenizer);
    int pos = 0;
    while (range.location != kCFNotFound) {
        NSString *word = [self canonicalize:[lctext substringWithRange:NSMakeRange(range.location, range.length)]];
        if (word) {
            [tokenized appendFormat:@"%@ ",word];
            NSMutableArray *val;
            if (!( val = [wordPositions valueForKey:word] )) {
                val = [NSMutableArray array];
                [wordPositions setValue:val forKey:word];
            }
            [val addObject:[NSNumber numberWithInt:pos]];
        }
        CFStringTokenizerAdvanceToNextToken(tokenizer);
        range = CFStringTokenizerGetCurrentTokenRange(tokenizer);      
        pos++;
    }
    CFRelease(tokenizer);
    self.tokenizedText = tokenized;
    self.doclen = pos;
}

- (void)dealloc {
    [source release];
    [text release];
    [title release];
    [tokenizedText release];
    [stopWords release];
    [super dealloc];
}
@end
