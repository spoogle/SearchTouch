//
//  PostingPlaceholder.m
//  Search
//
//  Created by Julian Richardson on 2/7/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "PostingPlaceholder.h"
#import "Singleton.h"
#import "PostingCDW.h"
#import "PostingCF.h"

@implementation PostingPlaceholder
SYNTHESIZE_SINGLETON_FOR_CLASS(PostingPlaceholder)

/*! Designated initializer */
- (Posting *)initWithDocID:(DocID)_docid andContents:(NSArray *)contents {
#ifndef NO_CORE_DATA
    return [[PostingCDW alloc] initWithDocID:_docid andContents:contents];
#else
    return [[PostingCF alloc] initWithDocID:_docid andContents:contents];
#endif
}

@end
