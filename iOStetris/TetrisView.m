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
@property (strong, nonatomic) CALayer *iPolyomino;
@property (strong, nonatomic) CALayer *oPolyomino;
@property (strong, nonatomic) CALayer *tPolyomino;
@property (strong, nonatomic) CALayer *lPolyomino;
@property (strong, nonatomic) CALayer *jPolyomino;
@property (strong, nonatomic) CALayer *sPolyomino;
@property (strong, nonatomic) CALayer *zPolyomino;

@property (strong, nonatomic) CALayer *tetrisLayer;

@end


@implementation TetrisView

-(void)awakeFromNib{
    self.iPolyomino = [[CALayer alloc] init];
    self.iPolyomino.bounds = CGRectMake(0, 0, 100, 400);
    self.iPolyomino.position = CGPointMake(150, 150);
    CALayer *first = [[CALayer alloc]init];
    first.backgroundColor = [UIColor blueColor].CGColor;
    first.bounds = CGRectMake(0, 0, 100, 100);
    [self.iPolyomino insertSublayer:first atIndex:0];
    self.iPolyomino.name = @"polyomino";
    [self.layer addSublayer:self.iPolyomino];
}

@end
