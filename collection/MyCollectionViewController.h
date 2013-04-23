//
//  MyCollectionViewController.h
//  collection
//
//  Created by sonson on 2013/04/11.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditView;

@interface MyCollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSMutableArray *sections;

- (IBAction)selectLayout:(id)sender;

@end
