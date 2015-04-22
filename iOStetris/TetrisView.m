//
//  TetrisView.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "TetrisView.h"

@interface TetrisView()

//tetrominoes
@property (strong, nonatomic) CALayer *straightPolyomnio;
@property (strong, nonatomic) CALayer *squarePolyomino;
@property (strong, nonatomic) CALayer *tPolyomino;
@property (strong, nonatomic) CALayer *lPolyomino;
@property (strong, nonatomic) CALayer *jPolyomino;
@property (strong, nonatomic) CALayer *sPolyomino;
@property (strong, nonatomic) CALayer *zPolyomino;

@property (strong, nonatomic) CALayer *tetrisLayer;

//moving/rotating current tetrominoes information
@property (assign, nonatomic) CGPoint touchStartPoint;
@property (assign, nonatomic) CGPoint touchStartLayerPosition;
@property (weak, nonatomic) CALayer *touchLayer;

@end


@implementation TetrisView

@end
