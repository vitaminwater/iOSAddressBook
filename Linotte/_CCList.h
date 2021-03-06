// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CCList.h instead.

#import <CoreData/CoreData.h>

extern const struct CCListAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *authorIdentifier;
	__unsafe_unretained NSString *avgInactiveDays;
	__unsafe_unretained NSString *hasNew;
	__unsafe_unretained NSString *icon;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *isdefault;
	__unsafe_unretained NSString *lastEventDate;
	__unsafe_unretained NSString *lastOpened;
	__unsafe_unretained NSString *lastUpdate;
	__unsafe_unretained NSString *lastZoneCleaningLatitude;
	__unsafe_unretained NSString *lastZoneCleaningLongitude;
	__unsafe_unretained NSString *lastZoneRefreshLatitude;
	__unsafe_unretained NSString *lastZoneRefreshLongitude;
	__unsafe_unretained NSString *lastZonesRefresh;
	__unsafe_unretained NSString *localIdentifier;
	__unsafe_unretained NSString *longNextRefreshDate;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *needsRefreshZone;
	__unsafe_unretained NSString *notify;
	__unsafe_unretained NSString *owned;
	__unsafe_unretained NSString *searchable;
	__unsafe_unretained NSString *shortNextRefreshDate;
	__unsafe_unretained NSString *waitingTime;
} CCListAttributes;

extern const struct CCListRelationships {
	__unsafe_unretained NSString *addressMetas;
	__unsafe_unretained NSString *addresses;
	__unsafe_unretained NSString *metas;
	__unsafe_unretained NSString *serverEvents;
	__unsafe_unretained NSString *zones;
} CCListRelationships;

@class CCAddressMeta;
@class CCAddress;
@class CCListMeta;
@class CCServerEvent;
@class CCListZone;

@interface CCListID : NSManagedObjectID {}
@end

@interface _CCList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CCListID* objectID;

@property (nonatomic, strong) NSString* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* authorIdentifier;

//- (BOOL)validateAuthorIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* avgInactiveDays;

@property (atomic) double avgInactiveDaysValue;
- (double)avgInactiveDaysValue;
- (void)setAvgInactiveDaysValue:(double)value_;

//- (BOOL)validateAvgInactiveDays:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* hasNew;

@property (atomic) BOOL hasNewValue;
- (BOOL)hasNewValue;
- (void)setHasNewValue:(BOOL)value_;

//- (BOOL)validateHasNew:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* icon;

//- (BOOL)validateIcon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* identifier;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isdefault;

@property (atomic) BOOL isdefaultValue;
- (BOOL)isdefaultValue;
- (void)setIsdefaultValue:(BOOL)value_;

//- (BOOL)validateIsdefault:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* lastEventDate;

//- (BOOL)validateLastEventDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* lastOpened;

//- (BOOL)validateLastOpened:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* lastUpdate;

//- (BOOL)validateLastUpdate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* lastZoneCleaningLatitude;

@property (atomic) double lastZoneCleaningLatitudeValue;
- (double)lastZoneCleaningLatitudeValue;
- (void)setLastZoneCleaningLatitudeValue:(double)value_;

//- (BOOL)validateLastZoneCleaningLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* lastZoneCleaningLongitude;

@property (atomic) double lastZoneCleaningLongitudeValue;
- (double)lastZoneCleaningLongitudeValue;
- (void)setLastZoneCleaningLongitudeValue:(double)value_;

//- (BOOL)validateLastZoneCleaningLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* lastZoneRefreshLatitude;

@property (atomic) double lastZoneRefreshLatitudeValue;
- (double)lastZoneRefreshLatitudeValue;
- (void)setLastZoneRefreshLatitudeValue:(double)value_;

//- (BOOL)validateLastZoneRefreshLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* lastZoneRefreshLongitude;

@property (atomic) double lastZoneRefreshLongitudeValue;
- (double)lastZoneRefreshLongitudeValue;
- (void)setLastZoneRefreshLongitudeValue:(double)value_;

//- (BOOL)validateLastZoneRefreshLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* lastZonesRefresh;

//- (BOOL)validateLastZonesRefresh:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* localIdentifier;

//- (BOOL)validateLocalIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* longNextRefreshDate;

//- (BOOL)validateLongNextRefreshDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* needsRefreshZone;

@property (atomic) BOOL needsRefreshZoneValue;
- (BOOL)needsRefreshZoneValue;
- (void)setNeedsRefreshZoneValue:(BOOL)value_;

//- (BOOL)validateNeedsRefreshZone:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* notify;

@property (atomic) BOOL notifyValue;
- (BOOL)notifyValue;
- (void)setNotifyValue:(BOOL)value_;

//- (BOOL)validateNotify:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* owned;

@property (atomic) BOOL ownedValue;
- (BOOL)ownedValue;
- (void)setOwnedValue:(BOOL)value_;

//- (BOOL)validateOwned:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* searchable;

@property (atomic) BOOL searchableValue;
- (BOOL)searchableValue;
- (void)setSearchableValue:(BOOL)value_;

//- (BOOL)validateSearchable:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* shortNextRefreshDate;

//- (BOOL)validateShortNextRefreshDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* waitingTime;

@property (atomic) int32_t waitingTimeValue;
- (int32_t)waitingTimeValue;
- (void)setWaitingTimeValue:(int32_t)value_;

//- (BOOL)validateWaitingTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *addressMetas;

- (NSMutableSet*)addressMetasSet;

@property (nonatomic, strong) NSSet *addresses;

- (NSMutableSet*)addressesSet;

@property (nonatomic, strong) NSSet *metas;

- (NSMutableSet*)metasSet;

@property (nonatomic, strong) NSSet *serverEvents;

- (NSMutableSet*)serverEventsSet;

@property (nonatomic, strong) NSSet *zones;

- (NSMutableSet*)zonesSet;

@end

@interface _CCList (AddressMetasCoreDataGeneratedAccessors)
- (void)addAddressMetas:(NSSet*)value_;
- (void)removeAddressMetas:(NSSet*)value_;
- (void)addAddressMetasObject:(CCAddressMeta*)value_;
- (void)removeAddressMetasObject:(CCAddressMeta*)value_;

@end

@interface _CCList (AddressesCoreDataGeneratedAccessors)
- (void)addAddresses:(NSSet*)value_;
- (void)removeAddresses:(NSSet*)value_;
- (void)addAddressesObject:(CCAddress*)value_;
- (void)removeAddressesObject:(CCAddress*)value_;

@end

@interface _CCList (MetasCoreDataGeneratedAccessors)
- (void)addMetas:(NSSet*)value_;
- (void)removeMetas:(NSSet*)value_;
- (void)addMetasObject:(CCListMeta*)value_;
- (void)removeMetasObject:(CCListMeta*)value_;

@end

@interface _CCList (ServerEventsCoreDataGeneratedAccessors)
- (void)addServerEvents:(NSSet*)value_;
- (void)removeServerEvents:(NSSet*)value_;
- (void)addServerEventsObject:(CCServerEvent*)value_;
- (void)removeServerEventsObject:(CCServerEvent*)value_;

@end

@interface _CCList (ZonesCoreDataGeneratedAccessors)
- (void)addZones:(NSSet*)value_;
- (void)removeZones:(NSSet*)value_;
- (void)addZonesObject:(CCListZone*)value_;
- (void)removeZonesObject:(CCListZone*)value_;

@end

@interface _CCList (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;

- (NSString*)primitiveAuthorIdentifier;
- (void)setPrimitiveAuthorIdentifier:(NSString*)value;

- (NSNumber*)primitiveAvgInactiveDays;
- (void)setPrimitiveAvgInactiveDays:(NSNumber*)value;

- (double)primitiveAvgInactiveDaysValue;
- (void)setPrimitiveAvgInactiveDaysValue:(double)value_;

- (NSNumber*)primitiveHasNew;
- (void)setPrimitiveHasNew:(NSNumber*)value;

- (BOOL)primitiveHasNewValue;
- (void)setPrimitiveHasNewValue:(BOOL)value_;

- (NSString*)primitiveIcon;
- (void)setPrimitiveIcon:(NSString*)value;

- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;

- (NSNumber*)primitiveIsdefault;
- (void)setPrimitiveIsdefault:(NSNumber*)value;

- (BOOL)primitiveIsdefaultValue;
- (void)setPrimitiveIsdefaultValue:(BOOL)value_;

- (NSDate*)primitiveLastEventDate;
- (void)setPrimitiveLastEventDate:(NSDate*)value;

- (NSDate*)primitiveLastOpened;
- (void)setPrimitiveLastOpened:(NSDate*)value;

- (NSDate*)primitiveLastUpdate;
- (void)setPrimitiveLastUpdate:(NSDate*)value;

- (NSNumber*)primitiveLastZoneCleaningLatitude;
- (void)setPrimitiveLastZoneCleaningLatitude:(NSNumber*)value;

- (double)primitiveLastZoneCleaningLatitudeValue;
- (void)setPrimitiveLastZoneCleaningLatitudeValue:(double)value_;

- (NSNumber*)primitiveLastZoneCleaningLongitude;
- (void)setPrimitiveLastZoneCleaningLongitude:(NSNumber*)value;

- (double)primitiveLastZoneCleaningLongitudeValue;
- (void)setPrimitiveLastZoneCleaningLongitudeValue:(double)value_;

- (NSNumber*)primitiveLastZoneRefreshLatitude;
- (void)setPrimitiveLastZoneRefreshLatitude:(NSNumber*)value;

- (double)primitiveLastZoneRefreshLatitudeValue;
- (void)setPrimitiveLastZoneRefreshLatitudeValue:(double)value_;

- (NSNumber*)primitiveLastZoneRefreshLongitude;
- (void)setPrimitiveLastZoneRefreshLongitude:(NSNumber*)value;

- (double)primitiveLastZoneRefreshLongitudeValue;
- (void)setPrimitiveLastZoneRefreshLongitudeValue:(double)value_;

- (NSDate*)primitiveLastZonesRefresh;
- (void)setPrimitiveLastZonesRefresh:(NSDate*)value;

- (NSString*)primitiveLocalIdentifier;
- (void)setPrimitiveLocalIdentifier:(NSString*)value;

- (NSDate*)primitiveLongNextRefreshDate;
- (void)setPrimitiveLongNextRefreshDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveNeedsRefreshZone;
- (void)setPrimitiveNeedsRefreshZone:(NSNumber*)value;

- (BOOL)primitiveNeedsRefreshZoneValue;
- (void)setPrimitiveNeedsRefreshZoneValue:(BOOL)value_;

- (NSNumber*)primitiveNotify;
- (void)setPrimitiveNotify:(NSNumber*)value;

- (BOOL)primitiveNotifyValue;
- (void)setPrimitiveNotifyValue:(BOOL)value_;

- (NSNumber*)primitiveOwned;
- (void)setPrimitiveOwned:(NSNumber*)value;

- (BOOL)primitiveOwnedValue;
- (void)setPrimitiveOwnedValue:(BOOL)value_;

- (NSNumber*)primitiveSearchable;
- (void)setPrimitiveSearchable:(NSNumber*)value;

- (BOOL)primitiveSearchableValue;
- (void)setPrimitiveSearchableValue:(BOOL)value_;

- (NSDate*)primitiveShortNextRefreshDate;
- (void)setPrimitiveShortNextRefreshDate:(NSDate*)value;

- (NSNumber*)primitiveWaitingTime;
- (void)setPrimitiveWaitingTime:(NSNumber*)value;

- (int32_t)primitiveWaitingTimeValue;
- (void)setPrimitiveWaitingTimeValue:(int32_t)value_;

- (NSMutableSet*)primitiveAddressMetas;
- (void)setPrimitiveAddressMetas:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAddresses;
- (void)setPrimitiveAddresses:(NSMutableSet*)value;

- (NSMutableSet*)primitiveMetas;
- (void)setPrimitiveMetas:(NSMutableSet*)value;

- (NSMutableSet*)primitiveServerEvents;
- (void)setPrimitiveServerEvents:(NSMutableSet*)value;

- (NSMutableSet*)primitiveZones;
- (void)setPrimitiveZones:(NSMutableSet*)value;

@end
