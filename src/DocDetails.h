//
//  DocDetails.h
//  Search
//
//  Created by Julian Richardson on 2/2/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"

@interface DocDetails : NSObject {
    DocID docid;
    int len;
    NSString *name;
    NSString *text;
}

@property (nonatomic) DocID docid;
@property (nonatomic) int len;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;

- (id)initWithDocID:(DocID)_docid;
@end
