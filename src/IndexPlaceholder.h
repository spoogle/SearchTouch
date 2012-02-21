//
//  IndexPlaceholder.h
//  Search
//
//  Created by Julian Richardson on 2/8/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>

@interface IndexPlaceholder : NSObject

+ (IndexPlaceholder *)sharedIndexPlaceholder;
- (id)initWithFilenamesFromFile:(NSString *)_filename;
@end
