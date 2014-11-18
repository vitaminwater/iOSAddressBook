#import "_CCList.h"

#import <CoreLocation/CoreLocation.h>

@interface CCList : _CCList {}

- (NSArray *)getListZonesSortedByDistanceFromLocation:(CLLocationCoordinate2D)location;

+ (CCList *)insertOrUpdateInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext fromLinotteAPIDict:(NSDictionary *)dict;

@end
