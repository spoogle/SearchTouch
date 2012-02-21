//
//  Payload.h
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"

/**
 Postings is a class cluster. Its alloc method returns a
 PostingsPlaceholder singleton instance.
 
 Postings : NSObject {
 }
 
 + (id)allocWithZone:(NSZone *)aZone {
 return [PostingsPlaceholder sharedPlaceholder];
 }
 
 PostingsPlaceholder's singleton instance returns either a core
 foundation PostingsCF object, or a PostingsCDW which boxes a PostingsCD
 core data object. The indirection in the core data case is necessary
 because the core data postings class is a subclass of NSManagedObject
 and not of NSObject, and therefore cannot be a subclass of
 Postings.
 
 PostingsPlaceholder
 
 - (id)init...
 if (coredata) return PostingsCDW : Postings
 else return          PostingsCF : Postings
 
 PostingsCDW : Postings {
 PostingsCD *p;
 }
 
 PostingsCF : Postings {
 }
*/
@interface Posting : NSObject

- (DocID)docid;
- (int)npostings;
- (uint32_t *)positions;
- (id)initWithDocID:(DocID)_docid andContents:(NSArray *)contents;

@end
