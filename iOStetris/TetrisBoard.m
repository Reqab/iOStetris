//
//  TetrisBoard.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "TetrisBoard.h"
#import "ViewController.h"

NSInteger board[10][18];
NSInteger currentPieceXPos[4];
NSInteger currentPieceYPos[4];
NSInteger currentPiece;
NSInteger direction;

int polyominoRotations[28][8] = {
    {0,0, 1,0, 2,0, 3,0},   //I
    {1,-1, 1,0, 1,1, 1,2},
    {0,0, 1,0, 2,0, 3,0},
    {1,-1, 1,0, 1,1, 1,2},
    
    {0,0, 1,0, 0,1, 1,1},   //O
    {0,0, 1,0, 0,1, 1,1},
    {0,0, 1,0, 0,1, 1,1},
    {0,0, 1,0, 0,1, 1,1},
    
    {0,0, 1,0, 2,0, 1,1},   //T
    {1,-1, 0,0, 1,0, 1,1},
    {1,0, 0,1, 1,1, 2,1},
    {1,-1, 1,0, 2,0, 1,1},
    
    {0,0, 1,0, 2,0, 0,1},   //L
    {0,-1, 1,-1, 1,0, 1,1},
    {2,0, 0,1, 1,1, 2,1},
    {0,-1, 0,0, 0,1, 1,1},
    
    {0,0, 1,0, 2,0, 2,1},   //J
    {1,-1, 1,0, 0,1, 1,1},
    {0,0, 0,1, 1,1, 2,1},
    {0,-1, 1,-1, 0,0, 0,1},
    
    {1,0, 2,0, 0,1, 1,1},   //S
    {0,-1, 0,0, 1,0, 1,1},
    {1,0, 2,0, 0,1, 1,1},
    {0,-1, 0,0, 1,0, 1,1},
    
    {0,0, 1,0, 1,1, 2,1},   //Z
    {1,-1, 0,0, 1,0, 0,1},
    {0,0, 1,0, 1,1, 2,1},
    {1,-1, 0,0, 1,0, 0,1}
};


@implementation TetrisBoard

-(instancetype)init{
    if(self = [super init]){
        [self newGame];
    }
    return self;
}

-(void)nextPiece{
    direction = UP;
    currentPiece = arc4random()%7;
    for (int i = 0; i < 4; i++) {
        currentPieceYPos[i] = polyominoRotations[currentPiece*4][i*2+1];
        currentPieceXPos[i] = 3+polyominoRotations[currentPiece*4][i*2];
    }
}

-(BOOL)canMoveRight{
    for (int i = 0; i < 4; i++) {
        if (currentPieceXPos[i] == 17) return NO;
        if (board[currentPieceXPos[i]+1][currentPieceYPos[i]] > -1) return NO;
    }
    return YES;
}

-(void)moveRight{
    if(![self canMoveRight]) return;
    for (int i = 0; i < 4; i++){
        currentPieceXPos[i]++;
    }
}


-(BOOL)canMoveLeft{
    for (int i = 0; i < 4; i++) {
        if (currentPieceXPos[i] == 0) return NO;
        if (board[currentPieceXPos[i]-1][currentPieceYPos[i]] > -1) return NO;
    }
    return YES;
}

-(void)moveLeft{
    if(![self canMoveLeft]) return;
    for (int i = 0; i < 4; i++)
        currentPieceXPos[i]--;
}

-(BOOL)canMoveDown{
    for (int i = 0; i < 4; i++) {
        if (currentPieceYPos[i] == 17) return NO;
        if (board[currentPieceXPos[i]][currentPieceYPos[i]+1] > -1) return NO;
    }
    return YES;
}

-(void)moveDown{
    for (int i = 0; i < 4; i++)
        currentPieceYPos[i]++;
}

-(void)lockPiece{
    for (int i = 0; i < 4; i++) {
        board[currentPieceXPos[i]][currentPieceYPos[i]] = currentPiece;
    }
    [self nextPiece];
}

-(BOOL)canRotate{
    return true;
}

-(void)rotate{
    NSInteger newDirection = (direction+1)%4;
    for (int i = 0; i < 4; i++) {
        NSInteger deltaX = polyominoRotations[currentPiece*4+newDirection][i*2] - polyominoRotations[currentPiece*4+direction][i*2];
        NSInteger deltaY = polyominoRotations[currentPiece*4+newDirection][i*2+1] - polyominoRotations[currentPiece*4+direction][i*2+1];
        currentPieceXPos[i] += deltaX;
        currentPieceYPos[i] += deltaY;
    }
    direction = newDirection;
}

-(NSInteger)getBlockInRow:(int)row col:(int)col{
    return board[col][row];
}

-(NSInteger)getCurrentPiece{
    return currentPiece;
}

-(NSInteger)getCurrentPieceXpos{
    return currentPieceXPos[0];
}

-(NSInteger)getCurrentPieceYpos{
    return currentPieceYPos[0];
}

-(NSInteger)getCurrentPieceDirection{
    return direction;
}

-(BOOL)isFullRow:(int)row{
    for (int col = 0; col < 10; col++) {
        if (board[col][row] == -1) return NO;
    }
    return YES;
}

-(void)clearRow:(int)i{
    for (int col = 0; col < 10; col++) {
        for (int row = i; row >0; row--) {
            board[col][row] =board[col][row-1];
        }
        board[col][0] = -1;
    }
    self.score += 100*self.level;
}

-(void)newGame{
    for (int x = 0; x < 10; x++) {
        for (int y = 0; y < 18; y++) {
            board[x][y] = -1;
        }
    }
    [self nextPiece];
    self.score = 0;
    self.level = 1;
}

-(NSInteger)getScore{
    return self.score;
}

-(NSInteger)getLevel{
    return self.level;
}

@end
