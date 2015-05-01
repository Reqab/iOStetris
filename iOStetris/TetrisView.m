//
//  TetrisView.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "TetrisView.h"
#import "ViewController.h"

@interface TetrisView()

@end

@implementation TetrisView


-(void)layoutSubviews{
    //setup tetrominoes
    for (int i = 0; i < 7; i++) {
        [self layoutTetromino:i];
    }
    self.current = [self.tetrominoArray objectAtIndex:4];
    [self.layer addSublayer:self.current];
}

-(void)awakeFromNib{
    //build tetromino array
    NSMutableArray *tetrominoes = [[NSMutableArray alloc] init];
    for (int tet = 0; tet < 7; tet++) {
        CALayer *tetrominoLayer = [[CALayer alloc]init];
        for (int block = 0; block < 4; block++) {
            CALayer *blockLayer = [[CALayer alloc] init];
            blockLayer.name = @"block";
            [tetrominoLayer insertSublayer:blockLayer atIndex:block];
        }
        [tetrominoes addObject:tetrominoLayer];
    }
    self.tetrominoArray = [NSArray arrayWithArray:tetrominoes];
    
    self.current = [self.tetrominoArray objectAtIndex:0];
}

-(void)moveTetrominoDown{
    CGFloat blockHeight = self.bounds.size.height/18;
    CGPoint newpos = CGPointMake(self.current.position.x, self.current.position.y + blockHeight);
    self.current.position = newpos;
    [self setNeedsDisplay];
}



//setup tetrominoes
int opolyomino[8] = {0,0, 1,0, 0,1, 1,1};
int polyominos[7][10] = {
    //block possition  |layer dimensions
    {0,0, 1,0, 2,0, 3,0, 4,1},  //I
    {0,0, 1,0, 0,1, 1,1, 2,2},  //O
    {0,0, 1,0, 2,0, 1,1, 3,2},  //T
    {0,0, 1,0, 2,0, 0,1, 3,2},  //L
    {0,0, 1,0, 2,0, 2,1, 3,2},  //J
    {1,0, 2,0, 0,1, 1,1, 3,2},  //S
    {0,0, 1,0, 1,1, 1,2, 3,2}   //Z
};

-(void)layoutTetromino:(int)tet{
    CGFloat blockWidth = self.bounds.size.width/10;
    CGFloat blockHeight = self.bounds.size.height/18;
    
    CALayer *tetromino = [self.tetrominoArray objectAtIndex:tet];
    tetromino.bounds = CGRectMake(0, 0, blockWidth*polyominos[tet][8], blockHeight*polyominos[tet][9]);
    tetromino.position = CGPointMake(blockWidth*(3+polyominos[tet][8]/2), blockHeight*polyominos[tet][9]/2);
    
    NSString *imageName = [NSString stringWithFormat:@"block%i", tet];
    for (int i = 0; i < 4; i++) {
        CALayer *block = [tetromino.sublayers objectAtIndex:i];
        block.bounds = CGRectMake(0, 0, blockWidth, blockHeight);
        block.contents = (id)[UIImage imageNamed:imageName].CGImage;
        block.position = CGPointMake(blockWidth/2+blockWidth*polyominos[tet][i*2], blockHeight/2+blockHeight*polyominos[tet][i*2+1]);
    }
}

@end
