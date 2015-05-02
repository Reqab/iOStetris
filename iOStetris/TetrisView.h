//
//  TetrisView.h
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TetrisView : UIView

//tetrominoes
@property (strong, nonatomic) CALayer *current;
@property (strong, nonatomic) NSArray *tetrominoArray;

//dragging
@property (assign, nonatomic) CGPoint touchStartPoint;
@property (assign, nonatomic) CGPoint touchStartLayerPosition;
@property (weak, nonatomic) CALayer *touchLayer;

-(void)rotateTetromino:(int)direction;
-(void)setBlockContentInTetrisLayerAtRow:(int)row Col:(int)col Block:(NSInteger)block;
-(void)moveTetrominoDown;
-(void)setCurrentTetromino:(int)i;

@end
