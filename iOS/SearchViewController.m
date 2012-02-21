//
//  SearchViewController.m
//  Search
//
//  Created by Julian Richardson on 8/29/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import "SearchViewController.h"
#import "Search.h"
#import "Util.h"

@implementation SearchViewController
@synthesize textView;
@synthesize index=_index;

- (void)dealloc
{
    [textView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    _index = [[Index alloc] initWithFilenamesFromFile:@"/Users/julianr/Dropbox/Private/world_factbook/files.txt"];
    if (!_index || ![_index hasBeenBuilt]) {
        [_index buildIndex:
            [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] 
                                        forKey:@"storetext"]];
    }
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSString *searchtermtext = [textField text];
    NSMutableString *output = [NSMutableString string];

    Search *s = [[Search alloc] initWithQueryString:searchtermtext andIndex:self.index];
    s.output = output;
    
    [Util append:@"Start" toOutput:output];
    [s rankedResults];
    [Util append:@"End" toOutput:output];
    self.textView.text = output;
    [s release];
    return YES;
}
@end
