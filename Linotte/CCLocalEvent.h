#import "_CCLocalEvent.h"

typedef enum : int16_t {
    CCLocalEventAddressCreated = 1,
    CCLocalEventListCreated,
    
    CCLocalEventListRemoved,
    
    CCLocalEventAddressMovedToList,
    CCLocalEventAddressMovedFromList,
    
    CCLocalEventAddressUpdated,
    CCLocalEventListUpdated,

    CCLocalEventAddressUserDataUpdated,
    CCLocalEventListUserDataUpdated,
    
    CCLocalEventListAdded,
    
    CCLocalEventAddressMetaAdded,
} CCLocalEventEvent;

@interface CCLocalEvent : _CCLocalEvent {}

@end
