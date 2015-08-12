// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PARBook.h instead.

#import <CoreData/CoreData.h>

extern const struct PARBookAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *bookURL;
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *coverURL;
	__unsafe_unretained NSString *objectId;
	__unsafe_unretained NSString *summary;
	__unsafe_unretained NSString *tags;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *webURL;
} PARBookAttributes;

extern const struct PARBookRelationships {
	__unsafe_unretained NSString *notes;
} PARBookRelationships;

@class PARNote;

@class NSObject;

@interface PARBookID : NSManagedObjectID {}
@end

@interface _PARBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PARBookID* objectID;

@property (nonatomic, strong) NSString* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* bookURL;

//- (BOOL)validateBookURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* coverURL;

//- (BOOL)validateCoverURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* objectId;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* summary;

//- (BOOL)validateSummary:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id tags;

//- (BOOL)validateTags:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* webURL;

//- (BOOL)validateWebURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PARNote *notes;

//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;

@end

@interface _PARBook (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;

- (NSString*)primitiveBookURL;
- (void)setPrimitiveBookURL:(NSString*)value;

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSString*)primitiveCoverURL;
- (void)setPrimitiveCoverURL:(NSString*)value;

- (NSString*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSString*)value;

- (NSString*)primitiveSummary;
- (void)setPrimitiveSummary:(NSString*)value;

- (id)primitiveTags;
- (void)setPrimitiveTags:(id)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveWebURL;
- (void)setPrimitiveWebURL:(NSString*)value;

- (PARNote*)primitiveNotes;
- (void)setPrimitiveNotes:(PARNote*)value;

@end
