//
//  IndexCDW.h
//  Search
//
//  Created by Julian Richardson on 2/8/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Index.h"
#import "CDIndex.h"

@interface IndexCDW : Index {
    CDIndex *_index;
}

@property (nonatomic, retain) CDIndex *index;

@end
