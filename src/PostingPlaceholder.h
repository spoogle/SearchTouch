//
//  PostingPlaceholder.h
//  Search
//
//  Created by Julian Richardson on 2/7/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"
#import "Posting.h"

@interface PostingPlaceholder : NSObject

- (Posting *)initWithDocID:(DocID)_docid andContents:(NSArray *)contents;
+ (PostingPlaceholder *)sharedPostingPlaceholder;
@end
