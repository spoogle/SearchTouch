//
//  CDIndexForWord.h
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CDTree.h"

@interface CDIndexForWord : NSManagedObject

@property (nonatomic, retain) NSString *word;
@property (nonatomic, retain) CDTree *index;
@property (nonatomic, retain) NSNumber *pnumberOfOccurrencesInDocset;
@property (nonatomic) int numberOfOccurrencesInDocset;

+ (CDIndexForWord *)addIndexForWord;

@end
