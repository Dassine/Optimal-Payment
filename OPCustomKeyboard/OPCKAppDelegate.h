//
//  OPCKAppDelegate.h
//  OPCustomKeyboard
//
//  Created by Lilia Dassine BELAID on 13-06-12.
//  Copyright (c) 2013 Lilia Dassine BELAID. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OPCKViewController;

@interface OPCKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) OPCKViewController *opckViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
