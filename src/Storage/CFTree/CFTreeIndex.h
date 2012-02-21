//
//  CFIndex.h
//  Search
//
//  Created by Julian Richardson on 2/6/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "Index.h"

@interface CFTreeIndex : Index {
    NSMutableDictionary *_detailsForDocs;
    NSMutableDictionary *_indexesForWords;
    NSMutableDictionary *_numberOfDocumentsContainingWord;
    NSString *_sourcename;
    int ndocs;
    double avgdoclen;
}

@property (nonatomic, retain) NSMutableDictionary *detailsForDocs;
@property (nonatomic, retain) NSMutableDictionary *indexesForWords;
@property (nonatomic, retain) NSMutableDictionary *numberOfDocumentsContainingWord;
@property (nonatomic, copy) NSString *sourcename;
@property (nonatomic) int ndocs;
@property (nonatomic) double avgdoclen;


@end
