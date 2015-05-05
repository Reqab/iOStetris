//
//  TetrisView.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "TetrisView.h"
#import "ViewController.h"

int polyominos[7][10] = {
    //block possition  | layer dimensions
    {0,0, 1,0, 2,0, 3,0, 4,1},  //I
    {0,0, 1,0, 0,1, 1,1, 2,2},  //O
    {0,0, 1,0, 2,0, 1,1, 3,2},  //T
    {0,0, 1,0, 2,0, 0,1, 3,2},  //L
    {0,0, 1,0, 2,0, 2,1, 3,2},  //J
    {1,0, 2,0, 0,1, 1,1, 3,2},  //S
    {0,0, 1,0, 1,1, 2,1, 3,2}   //Z
};

@interface TetrisView()

@end

@implementation TetrisView

-(void)layoutSubviews{
    //setup tetrominoes
    for (int i = 0; i < 7; i++) {
        [self layoutTetromino:i];
    }

    CGFloat blockWidth = self.bounds.size.width/10;
    CGFloat blockHeight = self.bounds.size.height/18;
    for (int row = 0; row < 18; row++) {
        for(int col = 0; col < 10; col++){
            CALayer *block = [[CALayer alloc] init];
            block.bounds = CGRectMake(0, 0, blockWidth, blockHeight);
            block.position = CGPointMake(blockWidth/2+blockWidth*col, blockHeight/2+blockHeight*row);
            block.name = @"tetrisBlock";
            [self.layer insertSublayer:block atIndex:col+row*10];
        }
    }
}

-(void)setCurrentTetromino:(int)i{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat blockWidth = self.bounds.size.width/10;
    CGFloat blockHeight = self.bounds.size.height/18;
    [self.current removeFromSuperlayer];
    CATransform3D xForm = CATransform3DIdentity;
    self.current.transform = CATransform3DRotate(xForm, 0, 0, 0, 1);
    self.current = [self.tetrominoArray objectAtIndex:i];
    self.current.position = CGPointMake(blockWidth*(3+polyominos[i][8]/2.0), blockHeight*polyominos[i][9]/2.0);
    [CATransaction commit];
    [self.layer addSublayer:self.current];
}

-(void)setBlockContentInTetrisLayerAtRow:(int)row Col:(int)col Block:(NSInteger)block{
    CALayer *blockLayer = [self.layer.sublayers objectAtIndex:col+row*10];
    [blockLayer setContents:nil];
    NSString *imageName = [NSString stringWithFormat:@"block%ld", block];
    blockLayer.contents = (id)[UIImage imageNamed:imageName].CGImage;
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
}

-(void)moveTetrominoDown{
    CGFloat blockHeight = self.bounds.size.height/18;
    CGPoint newpos = CGPointMake(self.current.position.x, self.current.position.y + blockHeight);
    self.current.position = newpos;
}

-(void)rotateTetromino:(int)direction{
    CGFloat blockWidth = self.bounds.size.width/10;
    CGFloat blockHeight = self.bounds.size.height/18;
    
    CATransform3D xForm = CATransform3DIdentity;
    self.current.transform = CATransform3DRotate(xForm, M_PI_2*direction, 0, 0, 1);
    if(direction%2 == 0)
        self.current.position = CGPointMake(self.current.position.x+blockWidth/2, self.current.position.y+blockHeight/2);
    else
        self.current.position = CGPointMake(self.current.position.x-blockWidth/2, self.current.position.y-blockHeight/2);
    
}

-(void)layoutTetromino:(int)tet{
    CGFloat blockWidth = self.bounds.size.width/10;
    CGFloat blockHeight = self.bounds.size.height/18;
    
    CALayer *tetromino = [self.tetrominoArray objectAtIndex:tet];
    tetromino.bounds = CGRectMake(0, 0, blockWidth*polyominos[tet][8], blockHeight*polyominos[tet][9]);
    
    NSString *imageName = [NSString stringWithFormat:@"block%i", tet];
    for (int i = 0; i < 4; i++) {
        CALayer *block = [tetromino.sublayers objectAtIndex:i];
        block.bounds = CGRectMake(0, 0, blockWidth, blockHeight);
        block.contents = (id)[UIImage imageNamed:imageName].CGImage;
        block.position = CGPointMake(blockWidth/2+blockWidth*polyominos[tet][i*2], blockHeight/2+blockHeight*polyominos[tet][i*2+1]);
    }
}

@end
