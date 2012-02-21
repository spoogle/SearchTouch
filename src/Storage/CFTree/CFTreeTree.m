//
//  CFTreeTree.m
//  Search
//
//  Created by Julian Richardson on 10/29/11.
//  Copyright (c) 2011 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "CFTreeTree.h"
#import "SearchDefs.h"

@interface CFTreeTree ()

void releaseCallBack(const void *info);

@end

@implementation CFTreeTree

+ (CFTreeTree *)addTree {
    return [[[CFTreeTree alloc] init] autorelease];
}

- (CFTreeTree *)addTree {
    return [CFTreeTree addTree];
}

- (NSNumber *)max {
    TreeInfo *info = self.info;
    DocID max = info -> max;
    return [NSNumber numberWithInt:max];
}

- (NSNumber *)pivot {
    TreeInfo *info = self.info;
    DocID pivot = info -> pivot;
    return [NSNumber numberWithInt:pivot];
}
    

- (id)init {
    if (( self = [super init] )) {
        /*! info belongs to the tree, and is
         released by the tree node release callback */
        CFTreeContext rootcontext = { 0, NULL, 
            NULL, releaseCallBack, 
            nil };
        TreeInfo *info = (TreeInfo *)calloc(1, sizeof(TreeInfo));
        rootcontext.info = info;
        _root=CFTreeCreate(kCFAllocatorDefault, &rootcontext);
        _current = _root;
    }
    return self;
}

- (id)initWithTree:(CFTreeTree *)t {
    t->_current = t->_root;
    return t;
}

- (void)appendChild:(CFTreeTree *)child {
    CFTreeAppendChild(_current,child->_root);
};

- (BOOL)isLeaf {
    return (!_current || 0 == CFTreeGetChildCount(_current));
};

- (TreeInfo *)info {
    CFTreeContext *context = calloc(1, sizeof(CFTreeContext));
    CFTreeGetContext(_current, context);
    TreeInfo *info = context -> info;
    free(context);
    return info;
}

- (NSArray *)postings {
    TreeInfo *info = [self info];
    return info -> data;
}

- (void)setInfo:(DocID)max pivot:(DocID)pivot data:(NSArray *)data {
    // i gets released in releaseCallBack for tree node
    TreeInfo *i = calloc(1,sizeof(TreeInfo));
    i -> max = max;
    i -> pivot = pivot;
    i -> data = [data retain];
    CFTreeContext *context = calloc(1, sizeof(CFTreeContext));
    CFTreeGetContext(_current, context);
    context -> info = i;
    CFTreeSetContext(_current, context);
    free(context);
}

- (CFTreeTree *)left {
    if ([self isLeaf]) {
        return nil;
    }
    
    _current = CFTreeGetChildAtIndex(_current, 0);
    return self;
}

- (CFTreeTree *)right {
    if ([self isLeaf] || CFTreeGetChildCount(_current) < 2) {
        return nil;
    }
    _current = CFTreeGetChildAtIndex(_current, 1);
    return self;
};

- (CFTreeTree *)parent {
    _current = CFTreeGetParent(_current);
    return self;
};

void releaseCallBack(const void *info) {
    [(((TreeInfo *)info) -> data) release];
    free((void *)info);
};

- (CFTreeTree *)reset {
    _current = _root;
    return self;
}

- (BOOL)nonEmpty {
    if (_current) return YES;
    return NO;
}

@end
