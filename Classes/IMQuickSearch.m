//
//  IMQuickSearch.m
//  IMQuickSearch
//
//  Created by Ben Gordon on 12/13/13.
//  Copyright (c) 2013 Intermark. All rights reserved.
//

#import "IMQuickSearch.h"

@implementation IMQuickSearch

#pragma mark - Init
- (instancetype)initWithFilters:(NSArray *)filters {
    // Fuzziness is not implemented due to speed considerations
    // This value does not matter at all.
    return [self initWithFilters:filters fuzziness:0.0];
}

- (instancetype)initWithFilters:(NSArray *)filters fuzziness:(float)fuzziness {
    if (self = [super init]) {
        self.masterArray = filters;
        self.fuzziness = fuzziness;
    }
    
    return self;
}


#pragma mark - Filter
- (NSArray *)filteredObjectsWithValue:(id)value {
    // Set Up Filter
    NSMutableSet *filteredSet = [NSMutableSet set];
    
    // Filter each object based on value
    for (IMQuickSearchFilter *quickFilter in self.masterArray) {
        [filteredSet addObjectsFromArray:[quickFilter filteredObjectsWithValue:value]];
    }
    
    // Return array from set
    return [filteredSet allObjects];
}


#pragma mark - Filter Management
- (void)addFilter:(IMQuickSearchFilter *)filter {
    if (filter) {
        NSMutableArray *newMasterArray = [self.masterArray mutableCopy];
        [newMasterArray addObject:filter];
        self.masterArray = newMasterArray;
    }
}

- (void)removeFilter:(IMQuickSearchFilter *)filter {
    if (filter) {
        NSMutableArray *newMasterArray = [self.masterArray mutableCopy];
        [newMasterArray removeObject:filter];
        self.masterArray = newMasterArray;
    }
}

@end