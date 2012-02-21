//
//  SearchViewController.h
//  Search
//
//  Created by Julian Richardson on 8/29/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <UIKit/UIKit.h>
#import "SearchDefs.h"
#import "DocTree.h"
#import "Stream.h"
#import "Search.h"
#import "Index.h"

@interface SearchViewController : UIViewController <UITextFieldDelegate>{
    Index *_index;
    
}
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, retain) Index *index;

@end
