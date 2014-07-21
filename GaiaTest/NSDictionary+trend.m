//
//  NSDictionary+trend.m
//  GaiaTest
//
//  Created by Kevin Moy on 7/16/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import "NSDictionary+trend.h"

@implementation NSDictionary (trend)

- (NSDictionary *)categories
{
    NSDictionary *dict = self[@"data"];
    NSArray *ar = dict[@"categories"];
    return ar[0];
}

- (NSString *)trendDescription
{
    NSArray *ar = self[@"trendDesc"];
    NSDictionary *dict = ar[0];
    return dict[@"value"];
}
@end
