//
//  SearchAppDelegate.h
//  Search
//
//  Created by Julian Richardson on 8/29/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <UIKit/UIKit.h>

@class SearchViewController;

@interface SearchAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SearchViewController *viewController;

@end
