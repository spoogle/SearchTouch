//
//  CDIndexForWord.m
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "CDIndexForWord.h"
#import "CDTree.h"
#import "CDManager.h"


@implementation CDIndexForWord

@dynamic word;
@dynamic pnumberOfOccurrencesInDocset;
@dynamic index;

- (int)numberOfOccurrencesInDocset {
    [self willAccessValueForKey:@"numberOfOccurrencesInDocset"];
    uint32_t r = [self.pnumberOfOccurrencesInDocset intValue];
    [self didAccessValueForKey:@"numberOfOccurrencesInDocset"];
    return r;
}

- (void)setNumberOfOccurrencesInDocset:(int)numberOfOccurrencesInDocset {
    self.pnumberOfOccurrencesInDocset = [NSNumber numberWithInt:numberOfOccurrencesInDocset];
}

+ (CDIndexForWord *)addIndexForWord {
    CDIndexForWord *new = [NSEntityDescription insertNewObjectForEntityForName:@"CDIndexForWord" inManagedObjectContext:[[CDManager sharedCDManager] managedObjectContext]];
    return new;
}

#ifdef DEBUG_FAULTS
- (void)willTurnIntoFault {
    NSLog(@"CDIndexForWord will turn %p into fault",self);
    [super willTurnIntoFault];
}
#endif

@end
