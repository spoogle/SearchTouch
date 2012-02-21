//
//  PostingCF.h
//  Search
//
//  Created by Julian Richardson on 2/7/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Posting.h"

@interface PostingCF : Posting {
    DocID docid;
    int _npostings;
    uint32_t *_positions;
}


@property (nonatomic) DocID docid;
@property (nonatomic) uint32_t *positions;
@property (nonatomic) int npostings;

@end
