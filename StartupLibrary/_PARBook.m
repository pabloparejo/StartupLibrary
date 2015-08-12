// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PARBook.m instead.

#import "_PARBook.h"

const struct PARBookAttributes PARBookAttributes = {
	.author = @"author",
	.bookURL = @"bookURL",
	.category = @"category",
	.coverURL = @"coverURL",
	.objectId = @"objectId",
	.summary = @"summary",
	.tags = @"tags",
	.title = @"title",
	.webURL = @"webURL",
};

const struct PARBookRelationships PARBookRelationships = {
	.notes = @"notes",
};

@implementation PARBookID
@end

@implementation _PARBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (PARBookID*)objectID {
	return (PARBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic author;

@dynamic bookURL;

@dynamic category;

@dynamic coverURL;

@dynamic objectId;

@dynamic summary;

@dynamic tags;

@dynamic title;

@dynamic webURL;

@dynamic notes;

@end

