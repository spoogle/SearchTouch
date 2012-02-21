//
//  CDDocDetails.m
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "CDDocDetails.h"
#import "CDManager.h"

@implementation CDDocDetails

@dynamic pdocid;
@dynamic plen;
@dynamic text;
@dynamic name;

- (int)len {
    [self willAccessValueForKey:@"len"];
    int r = [self.plen intValue];
    [self didAccessValueForKey:@"len"];
    return r;
}

- (void)setLen:(int)len {
    self.plen = [NSNumber numberWithInt:len];
}

- (void)setDocid:(uint32_t)docid {
    self.pdocid = [NSNumber numberWithLong:docid];
}

- (uint32_t)docid {
    [self willAccessValueForKey:@"docid"];
    uint32_t r = [self.pdocid intValue];
    [self didAccessValueForKey:@"docid"];
    return r;
}

+ (CDDocDetails *)addDocDetails {
    CDDocDetails *new = [NSEntityDescription insertNewObjectForEntityForName:@"CDDocDetails" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    return new;
}

#ifdef DEBUG_FAULTS
- (void)willTurnIntoFault {
    NSLog(@"CDDocDetails will turn %p into fault",self);
    [super willTurnIntoFault];
}
#endif

@end
