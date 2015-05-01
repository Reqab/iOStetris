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

@property (strong, nonatomic) CALayer *tetrisLayer;

//dragging
@property (assign, nonatomic) CGPoint touchStartPoint;
@property (assign, nonatomic) CGPoint touchStartLayerPosition;
@property (weak, nonatomic) CALayer *touchLayer;

-(void)moveTetrominoDown;

@end
