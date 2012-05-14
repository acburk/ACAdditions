//
//  CoreData.h
//  GCDtest
//
//  Created by Adam Burkepile on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define appManagedObjectModel [ACCoreData managedObjectModel]
#define appPersistentStoreCoordinator [ACCoreData persistentStoreCoordinator]
#define appManagedObjectContext [ACCoreData managedObjectContext]

@interface NSManagedObject (CRUD)
+ (id)createNewEntity;
+ (id)createNewEntityInManagedObjectContext:(NSManagedObjectContext*)context;
+ (NSSet*)retrieveAll;
+ (NSSet*)retrieveAllFromManagedObjectContext:(NSManagedObjectContext*)context;
+ (NSSet*)retrieveWithPredicate:(id)stringOrPredicate,...;
+ (NSSet*)retrieveFromManagedObjectContext:(NSManagedObjectContext*)context withPredicate:(id)stringOrPredicate,...;
+ (void)deleteAll;
+ (void)deleteAllFromManagedObjectContext:(NSManagedObjectContext*)context;
+ (NSEntityDescription*)entityDescription;
+ (NSEntityDescription*)entityDescriptionInManagedObjectContext:(NSManagedObjectContext*)context;

@end

@interface NSManagedObjectContext (OneLineFetch)
- (NSSet *)fetchObjectsForEntityClass:(Class)inClass 
                        withPredicate:(id)stringOrPredicate, ...;
- (NSSet *)fetchObjectsForEntityName:(NSString *)newEntityName
                       withPredicate:(id)stringOrPredicate, ...;
- (void)saveContext;
@end

@interface ACCoreData : NSObject {
}
@property (nonatomic, readonly, getter=managedObjectContext) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, getter=managedObjectModel) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly, getter=persistentStoreCoordinator) NSPersistentStoreCoordinator *persistentStoreCoordinator;
+ (void)resetCoreDataData;
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator:(NSString*)inSqlite;
+ (NSManagedObjectModel *)managedObjectModel;
+ (NSManagedObjectModel *)managedObjectModel:(NSString*)inMOMD;
+ (NSManagedObjectContext *)managedObjectContext;
+ (NSString*)persistentStoreCoordinatorFile:(NSString*)inSqlite;
+ (NSString*)persistentStoreCoordinatorFile;
+ (NSFetchRequest*)fetchRequestOnEntity:(NSEntityDescription*)inEntityDescription 
                          withPredicate:(id)stringOrPredicate, ...;
@end