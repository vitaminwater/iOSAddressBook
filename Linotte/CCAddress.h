#import "_CCAddress.h"

#import <CoreLocation/CoreLocation.h>

@interface CCAddress : _CCAddress {}

@property(nonatomic, readonly)CLLocation *location;

- (NSArray *)metasForActions:(NSArray *)actions;

+ (NSUInteger)numberOfNotifyingAddressesInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (CCAddress *)insertOrUpdateInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext fromLinotteAPIDict:(NSDictionary *)dict;
+ (NSArray *)insertOrUpdateInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext fromLinotteAPIDictArray:(NSArray *)dictArray list:(CCList *)list;
+ (NSArray *)insertInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext fromLinotteAPIDictArray:(NSArray *)dictArray;
+ (NSArray *)updateUserDatasInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext fromLinotteAPIDictArray:(NSArray *)dictArray list:(CCList *)list shittyBlock:(void(^)(NSArray *addresses))shittyBlock;

@end
