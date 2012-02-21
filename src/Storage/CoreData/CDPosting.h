//
//  CDPosting.h
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CDManager.h"
#import "SearchDefs.h"

@interface CDPosting : NSManagedObject

@property (nonatomic, retain) NSNumber *pdocid;
@property (nonatomic, retain) NSNumber *pnpostings;
@property (nonatomic, retain) NSData *ppositions;
@property (nonatomic) uint32_t docid;
@property (nonatomic, readonly) int npostings;
@property (nonatomic, readonly) uint32_t *positions;

+ (CDPosting *)addPosting;
- (void)setPositionsFromArray:(NSArray *)_positionsArray;
@end
