//
//  CDDocDetails.h
//  Search
//
//  Created by Julian Richardson on 2/1/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDDocDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * pdocid;
@property (nonatomic, retain) NSNumber * plen;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) uint32_t docid;
@property (nonatomic) int len;

+ (CDDocDetails *)addDocDetails;

@end
