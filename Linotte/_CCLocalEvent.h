// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CCLocalEvent.h instead.

#import <CoreData/CoreData.h>

extern const struct CCLocalEventAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *event;
	__unsafe_unretained NSString *localAddressIdentifier;
	__unsafe_unretained NSString *localListIdentifier;
	__unsafe_unretained NSString *parameters;
} CCLocalEventAttributes;

@class NSObject;

@interface CCLocalEventID : NSManagedObjectID {}
@end

@interface _CCLocalEvent : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CCLocalEventID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* event;

@property (atomic) int16_t eventValue;
- (int16_t)eventValue;
- (void)setEventValue:(int16_t)value_;

//- (BOOL)validateEvent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* localAddressIdentifier;

//- (BOOL)validateLocalAddressIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* localListIdentifier;

//- (BOOL)validateLocalListIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id parameters;

//- (BOOL)validateParameters:(id*)value_ error:(NSError**)error_;

@end

@interface _CCLocalEvent (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSNumber*)primitiveEvent;
- (void)setPrimitiveEvent:(NSNumber*)value;

- (int16_t)primitiveEventValue;
- (void)setPrimitiveEventValue:(int16_t)value_;

- (NSString*)primitiveLocalAddressIdentifier;
- (void)setPrimitiveLocalAddressIdentifier:(NSString*)value;

- (NSString*)primitiveLocalListIdentifier;
- (void)setPrimitiveLocalListIdentifier:(NSString*)value;

- (id)primitiveParameters;
- (void)setPrimitiveParameters:(id)value;

@end
