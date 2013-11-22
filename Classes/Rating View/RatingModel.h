#import <CoreData/CoreData.h>


@interface RatingModel : NSManagedObject  {
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *point;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSNumber *timeMin;
@property (nonatomic, retain) NSNumber *timeSec;

@end
