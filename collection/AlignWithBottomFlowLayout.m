//
//  AlignWithBottomFlowLayout.m
//  collection
//
//  Created by sonson on 2013/04/24.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "AlignWithBottomFlowLayout.h"

@interface AlginWithBottomFlowLayoutRowInfo : NSObject

@property (nonatomic, assign) float centerY;
@property (nonatomic, assign) float bottom;

@end

@implementation AlginWithBottomFlowLayoutRowInfo
@end

@implementation AlignWithBottomFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	DNSLogMethod
	
	NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
	
	NSMutableArray *rowInfos = [NSMutableArray array];
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		DNSLogPoint(attributes.center);
	}
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		BOOL found = NO;
		for (AlginWithBottomFlowLayoutRowInfo *info in rowInfos) {
			if (fabs(info.centerY - attributes.center.y) < 1) {
				found = YES;
				if (info.bottom < CGRectGetMaxY(attributes.frame)) {
					info.centerY = attributes.center.y;
					info.bottom = CGRectGetMaxY(attributes.frame);
				}
				break;
			}
		}
		if (!found) {
			AlginWithBottomFlowLayoutRowInfo *rowInfo = [AlginWithBottomFlowLayoutRowInfo new];
			rowInfo.centerY = attributes.center.y;
			rowInfo.bottom = CGRectGetMaxY(attributes.frame);
			[rowInfos addObject:rowInfo];
		}
	}
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		for (AlginWithBottomFlowLayoutRowInfo *info in rowInfos) {
			if (fabs(info.centerY - attributes.center.y) < 1) {
				CGRect r = attributes.frame;
				r.origin.y = info.bottom - r.size.height;
				attributes.frame = r;
				attributes.center = CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));
			}
		}
	}
	
	return attributesArray;
}
@end
