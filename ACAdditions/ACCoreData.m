//
//  CoreData.m
//  GCDtest
//
//  Created by Adam Burkepile on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "ACCoreData.h"

@implementation NSManagedObject(CRUD)

+ (id)createNewEntity{
    return [self createNewEntityInManagedObjectContext:appManagedObjectContext];
}
+ (id)createNewEntityInManagedObjectContext:(NSManagedObjectContext*)context{
    id entity = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];

    if ([entity respondsToSelector:@selector(setCreatedDate:)]) {
        [entity performSelector:@selector(setCreatedDate:) withObject:[NSDate date]];
    }

    return entity;
}
+ (NSSet*)retrieveAll {
    return [self retrieveAllFromManagedObjectContext:appManagedObjectContext];
}
+ (NSSet*)retrieveAllFromManagedObjectContext:(NSManagedObjectContext*)context {
    return [self retrieveFromManagedObjectContext:context withPredicate:nil];
}

+ (NSSet*)retrieveWithPredicate:(id)stringOrPredicate,... {
    return [self retrieveFromManagedObjectContext:appManagedObjectContext withPredicate:stringOrPredicate];
}
+ (NSSet*)retrieveFromManagedObjectContext:(NSManagedObjectContext*)context withPredicate:(id)stringOrPredicate,... {
    return [context fetchObjectsForEntityName:NSStringFromClass([self class]) withPredicate:stringOrPredicate];
}

+ (void)deleteAll {
    [self deleteAllFromManagedObjectContext:appManagedObjectContext];
}
+ (void)deleteAllFromManagedObjectContext:(NSManagedObjectContext*)context {
    NSMutableArray* retItems = [[self retrieveAllFromManagedObjectContext:context] mutableCopy];

    [retItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
}

+ (NSEntityDescription*)entityDescription {
    return [self entityDescriptionInManagedObjectContext:appManagedObjectContext];
}
+ (NSEntityDescription*)entityDescriptionInManagedObjectContext:(NSManagedObjectContext*)context {
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:NSStringFromClass([self class])
                                                         inManagedObjectContext:context];
    return entityDescription;
}

+ (id)objectWithId:(int)value forField:(NSString*)key {
    NSString* pred = [NSString stringWithFormat:@"%@ == %d",key,value];
    NSManagedObject* foundObject = [[self retrieveWithPredicate:pred] anyObject];
    
    return foundObject;
}
@end

@implementation NSManagedObjectContext (OneLineFetch)
// Convenience method to fetch the array of objects for a given Entity
// name in the context, optionally limiting by a predicate or by a predicate
// made from a format NSString and variable arguments.
//
- (NSSet *)fetchObjectsForEntityClass:(Class)inClass withPredicate:(id)stringOrPredicate, ... {
    return [self fetchObjectsForEntityName:NSStringFromClass(inClass) withPredicate:stringOrPredicate];
}
- (NSSet *)fetchObjectsForEntityName:(NSString *)newEntityName withPredicate:(id)stringOrPredicate, ...
{
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:newEntityName inManagedObjectContext:self];
    
    NSFetchRequest *request = [ACCoreData fetchRequestOnEntity:entity withPredicate:stringOrPredicate];
    
    NSError *error = nil;
    NSArray *results = [self executeFetchRequest:request error:&error];
    if (error != nil)
    {
        [NSException raise:NSGenericException format:@"%@",[error description]];
    }
    
    return [NSSet setWithArray:results];
}

- (void)saveContext
{
    NSError *error = nil;
    if (self != nil) {
        if ([self hasChanges] && ![self save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}
@end

@implementation ACCoreData
static NSManagedObjectContext *managedObjectContext_;
static NSManagedObjectModel *managedObjectModel_;
static NSPersistentStoreCoordinator *persistentStoreCoordinator_;

@dynamic managedObjectContext;
@dynamic managedObjectModel;
@dynamic persistentStoreCoordinator;

#pragma mark -
#pragma mark Core Data stack

+ (NSFetchRequest*)fetchRequestOnEntity:(NSEntityDescription*)inEntityDescription 
                          withPredicate:(id)stringOrPredicate, ... {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:inEntityDescription];
    
    if (stringOrPredicate)
    {
        NSPredicate *predicate;
        if ([stringOrPredicate isKindOfClass:[NSString class]])
        {
            va_list variadicArguments;
            va_start(variadicArguments, stringOrPredicate);
            predicate = [NSPredicate predicateWithFormat:stringOrPredicate
                                               arguments:variadicArguments];
            va_end(variadicArguments);
        }
        else
        {
            NSAssert2([stringOrPredicate isKindOfClass:[NSPredicate class]],
                      @"Second parameter passed to %s is of unexpected class %@",
                      sel_getName(_cmd), [[stringOrPredicate class] description]);
            predicate = (NSPredicate *)stringOrPredicate;
        }
        [request setPredicate:predicate];
    }

    return request;
}

+ (void)resetCoreDataData {
    NSLog(@"Removing Core Data file");
    [[NSFileManager defaultManager] removeItemAtPath:[ACCoreData persistentStoreCoordinatorFile] error:nil];
    managedObjectModel_ = nil;
    managedObjectContext_ = nil;
    persistentStoreCoordinator_ = nil;
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
+ (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
+ (NSManagedObjectModel *)managedObjectModel:(NSString*)inMOMD {
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:inMOMD ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}
+ (NSManagedObjectModel *)managedObjectModel {
    return [self managedObjectModel:applicationName];
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator:(NSString*)inSqlite {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath:[self persistentStoreCoordinatorFile:inSqlite]];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        if ([error code] == 134100) {
            [ACCoreData resetCoreDataData];
            return [self persistentStoreCoordinator:inSqlite];
        }
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    return [self persistentStoreCoordinator:applicationName];
}
+ (NSString*)persistentStoreCoordinatorFile:(NSString*)inSqlite {
    return [applicationDocumentsDirectoryString stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",inSqlite]];
}
+ (NSString*)persistentStoreCoordinatorFile {
    return [self persistentStoreCoordinatorFile:applicationName];
}
@end