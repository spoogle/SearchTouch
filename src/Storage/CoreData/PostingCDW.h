//
//  PostingCDW.h
//  Search
//
//  Created by Julian Richardson on 2/7/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Posting.h"
#import "CDPosting.h"

@interface PostingCDW : Posting {
    CDPosting *_posting;
}

@property (nonatomic, retain) CDPosting *posting;

- (PostingCDW *)initWithDocID:(DocID)_docid andContents:(NSArray *)contents;
- (PostingCDW *)initWithCoreData:(CDPosting *)p;

@end
