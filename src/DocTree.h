//
//  DocTree.h
//  Search
//
//  Created by Julian Richardson on 8/29/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import "SearchDefs.h"
#import "Posting.h"
#import "Tree.h"

@interface DocTree : NSObject {
    /*! Maximum length of data array at a node before we have to split it
     into subtrees */
    id<Tree> _tree;
    NSString *_word;
    int _numberOfOccurrencesInDocset;
}

@property (nonatomic, retain) id<Tree> tree;
@property (nonatomic, retain) NSString *word;
@property (nonatomic) int numberOfOccurrencesInDocset;

- (id)initWithWord:(NSString *)w andTree:(id <Tree> )tree andNumberOfOccurrencesInDocset:(int)numberOfOccurrencesInDocset;
- (id)initWithTree:(id <Tree> )t;
- (void)setData:(NSArray *)data forTree:(id <Tree> )parent;
- (void)setData:(NSArray *)data;
@end
