//
//  CDPosting.m
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "CDPosting.h"

@implementation CDPosting

@dynamic pdocid;
@dynamic pnpostings;
@dynamic ppositions;

- (void)setPositionsFromArray:(NSArray *)contents {
    self.pnpostings = [NSNumber numberWithInt:[contents count]];
    uint32_t *contentsCArray = (uint32_t *)calloc([contents count],sizeof(uint32_t));
    for (int i=0; i < [contents count]; i++) {
        contentsCArray[i] = (uint32_t)[[contents objectAtIndex:i] intValue];
    }
    self.ppositions = [NSData dataWithBytes:contentsCArray length:[contents count]*sizeof(uint32_t)];
    free(contentsCArray);
}

- (DocID)docid {
    [self willAccessValueForKey:@"docid"];
    DocID r = [self.pdocid intValue];
    [self didAccessValueForKey:@"docid"];
    return r;
}

- (void)setDocid:(uint32_t)docid {
    self.pdocid = [NSNumber numberWithLong:docid];
}

- (int)npostings {
    [self willAccessValueForKey:@"npostings"];
    uint32_t r = [self.pnpostings intValue];
    [self didAccessValueForKey:@"npostings"];
    return r;
}

- (uint32_t *)positions {
    [self willAccessValueForKey:@"positions"];
    uint32_t *r = (uint32_t *)[self.ppositions bytes];
    [self didAccessValueForKey:@"positions"];
    return r;
}

+ (CDPosting *)addPosting {
    CDPosting *new = [NSEntityDescription insertNewObjectForEntityForName:@"CDPosting" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    return new;
}

#ifdef DEBUG_FAULTS
- (void)willTurnIntoFault {
    NSLog(@"CDPosting will turn %p into fault",self);
    [super willTurnIntoFault];
}
#endif

@end
