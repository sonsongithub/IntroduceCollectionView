//
//  AlginWithTopFlowLayout.m
//  collection
//
//  Created by sonson on 2013/04/22.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "AlginWithTopFlowLayout.h"

@interface AlginWithTopFlowLayoutRowInfo : NSObject

@property (nonatomic, assign) float centerY;
@property (nonatomic, assign) float top;

@end

@implementation AlginWithTopFlowLayoutRowInfo
@end

@implementation AlginWithTopFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	DNSLogMethod
	
	NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
	
	NSMutableArray *rowInfos = [NSMutableArray array];
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		DNSLogPoint(attributes.center);
	}
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		BOOL found = NO;
		for (AlginWithTopFlowLayoutRowInfo *info in rowInfos) {
			if (fabs(info.centerY - attributes.center.y) < 1) {
				found = YES;
				if (info.top > attributes.frame.origin.y) {
					info.centerY = attributes.center.y;
					info.top = attributes.frame.origin.y;
				}
				break;
			}
		}
		if (!found) {
			AlginWithTopFlowLayoutRowInfo *rowInfo = [AlginWithTopFlowLayoutRowInfo new];
			rowInfo.centerY = attributes.center.y;
			rowInfo.top = attributes.frame.origin.y;
			[rowInfos addObject:rowInfo];
		}
	}
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		for (AlginWithTopFlowLayoutRowInfo *info in rowInfos) {
//			if (info.centerY == attributes.center.y && info.top == attributes.frame.origin.y) {
			if (fabs(info.centerY - attributes.center.y) < 1) {
				CGRect r = attributes.frame;
				r.origin.y = info.top;
				attributes.frame = r;
				attributes.center = CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));
//				attributes.alpha = 0.5;
			}
		}
	}
//
//	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
//		DNSLogRect(attributes.frame);
//	}
	
	return attributesArray;
}

@end
