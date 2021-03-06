//
//  CCNotificationGenerator.m
//  AdRem
//
//  Created by stant on 09/02/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCGeohashMonitor.h"

#import "CCGeohashHelper.h"


@implementation CCGeohashMonitor
{
    CLLocationManager *_locationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (![CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]] ||
            ![CLLocationManager significantLocationChangeMonitoringAvailable]) {
            // TODO: tell user
        }
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        
        [_locationManager startMonitoringSignificantLocationChanges];
    }
    return self;
}

- (void)updateMonitoredGeohashes:(CLLocationCoordinate2D)coordinates
{
    NSMutableArray *geohashes = [[CCGeohashHelper geohashGridSurroundingCoordinate:coordinates radius:2 digits:kCCGeohashHelperNDigits all:NO] mutableCopy];
    
    for (CLRegion *region in _locationManager.monitoredRegions) {
        if (![geohashes containsObject:region.identifier]) {
            [_locationManager stopMonitoringForRegion:region];
        } else {
            [geohashes removeObject:region.identifier];
        }
    }
    for (NSString *geohash in geohashes) {
        CLLocationCoordinate2D coord = [CCGeohashHelper coordinatesFromGeohash:geohash];
        CLRegion *region = [[CLCircularRegion alloc] initWithCenter:coord radius:100 identifier:geohash];
        [_locationManager startMonitoringForRegion:region];
    }
}

#pragma mark - CLLocationManagerDelegate methods

#pragma mark region monitoring methods

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    if ([region isKindOfClass:[CLCircularRegion class]]) {
        CCLog(@"CCGeohashMonitor locationManager:didEnterRegion:");
        
        NSArray *geohashes = [CCGeohashHelper calculateAdjacentGeohashes:region.identifier];
        [_delegate didEnterGeohashes:geohashes];
        [self updateMonitoredGeohashes:((CLCircularRegion *)region).center];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
}

#pragma mark significant location change monitoring

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CCLog(@"CCGeohashMonitor locationManager:didUpdateLocations:");
    
    CLLocation *location = [locations lastObject];
    [self updateMonitoredGeohashes:location.coordinate];
}

@end
