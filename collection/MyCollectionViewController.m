//
//  MyCollectionViewController.m
//  collection
//
//  Created by sonson on 2013/04/11.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "MyCollectionViewCell.h"
#import "MyFlowLayout.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	DNSLogMethod
	self.selectedIndexPath = indexPath;
	[self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//	[self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
	
//	self.collectionView.collectionViewLayout = [[MyFlowLayout alloc] init];
	
	NSMutableArray *images = [NSMutableArray array];
	
	for (int i = 0; i < 11; i++) {
		[images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%02d.png", i]]];
	}
	
	self.sections = [NSMutableArray array];
	
	[self.sections addObject:@{ @"title" : @"hoge01", @"images" : images }];
	[self.sections addObject:@{ @"title" : @"hoge02", @"images" : images }];
	
	[self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//	NSDictionary *section = self.sections[indexPath.section];
//	NSArray *images = section[@"images"];
//	UIImage *image = images[indexPath.item];
//	
////	srand(indexPath.item + indexPath.section);
////	
////	int n = rand() % 50;
////	
////	NSLog(@"%d", n);
////	
////	float ratio = (10 + n) / 100.0f;
////	
////	CGSize s = image.size;
////	
////	s.width *= ratio;
////	s.height *= ratio;
////	//
	CGSize s;
	if (indexPath.section == self.selectedIndexPath.section && indexPath.item == self.selectedIndexPath.item) {
		s.width = 200;
		s.height = 200;
	}
	else {
		s.width = 200;
		s.height = 100;
	}
	return s;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSDictionary *info = self.sections[section];
	return [info[@"images"] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return [self.sections count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
	
	NSDictionary *section = self.sections[indexPath.section];
	NSArray *images = section[@"images"];
	UIImage *image = images[indexPath.item];
	
//	NSLog(@"%@", cell);
//	NSLog(@"%@", cell.imageView);
	cell.imageView.image = image;
//	NSLog(@"%@", cell.imageView.image);
	
	return cell;
}

@end
