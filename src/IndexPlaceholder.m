//
//  IndexPlaceholder.m
//  Search
//
//  Created by Julian Richardson on 2/8/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "IndexPlaceholder.h"
#import "Singleton.h"
#import "IndexCDW.h"
#import "CFTreeIndex.h"

@implementation IndexPlaceholder
SYNTHESIZE_SINGLETON_FOR_CLASS(IndexPlaceholder)

/*! Designated initializer */
- (Index *)initWithFilenamesFromFile:(NSString *)_filename {
#ifdef USE_CORE_DATA
    return [[IndexCDW alloc] initWithFilenamesFromFile:_filename];
#else
    return [[CFTreeIndex alloc] initWithFilenamesFromFile:_filename];
#endif
}

@end
