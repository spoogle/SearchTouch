//
//  CDManager.h
//  Search
//
//  Created by Julian Richardson on 1/31/12.
//  Copyright (c) 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CDManager : NSObject {
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectContext *_managedObjectContext;
}

@property (retain, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (retain, nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

+ (CDManager *)sharedCDManager;
- (BOOL)indexExists;
@end
