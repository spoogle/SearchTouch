//
//  CFTreeTree.h
//  Search
//
//  Created by Julian Richardson on 10/29/11.
//  Copyright (c) 2011 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "Tree.h"

/*
 root is a CFTreeRef
 current is a CFTreeRef
 
 */
@interface CFTreeTree : NSObject <Tree> {
    CFTreeRef _root;
    CFTreeRef _current;
}

- (TreeInfo *)info;

@end
