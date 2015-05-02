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


@implementation TetrisBoard

-(instancetype)init{
    if(self = [super init]){
        for (int x = 0; x < 10; x++) {
            for (int y = 0; y < 18; y++) {
                board[x][y] = -1;
            }
        }
        [self nextPiece];
        self.score = 0;
        self.level = 1;
    }
    return self;
}

-(void)nextPiece{
    direction = UP;
    currentPiece = arc4random()%7;
    switch (currentPiece) {
        case IPOLYOMINO:
            for (int i = 0; i < 4; i ++){
                currentPieceYPos[i] = 0;
                currentPieceXPos[i] = 3+i;
            }
            break;
            
        case OPOLYOMINO:
            currentPieceXPos[0] = currentPieceXPos[2] = 3;
            currentPieceXPos[1] = currentPieceXPos[3] = 4;
            currentPieceYPos[0] = currentPieceYPos[1] = 0;
            currentPieceYPos[2] = currentPieceYPos[3] = 1;
            break;
            
        case TPOLYOMINO:
            currentPieceXPos[0] = 3;
            currentPieceXPos[1] = currentPieceXPos[3] = 4;
            currentPieceXPos[2] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = currentPieceYPos[2] = 0;
            currentPieceYPos[3] = 1;
            break;
            
        case LPOLYOMINO:
            currentPieceXPos[0] = currentPieceXPos[3] = 3;
            currentPieceXPos[1] = 4;
            currentPieceXPos[2] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = currentPieceYPos[2] = 0;
            currentPieceYPos[3] = 1;
            break;
            
        case JPOLYOMINO:
            currentPieceXPos[0] = 3;
            currentPieceXPos[1] = 4;
            currentPieceXPos[2] = currentPieceXPos[3] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = currentPieceYPos[2] = 0;
            currentPieceYPos[3] = 1;
            break;
            
        case SPOLYOMINO:
            currentPieceXPos[2] = 3;
            currentPieceXPos[0] = currentPieceXPos[3] = 4;
            currentPieceXPos[1] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = 0;
            currentPieceYPos[2] = currentPieceYPos[3] = 1;
            break;
            
        case ZPOLYOMINO:
            currentPieceXPos[0] = 3;
            currentPieceXPos[1] = currentPieceXPos[2] = 4;
            currentPieceXPos[3] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = 0;
            currentPieceYPos[2] = currentPieceYPos[3] = 1;
            break;
    }
}

-(BOOL)canMoveRight{
    for (int i = 0; i < 4; i++) {
        if (currentPieceXPos[i] == 17) return NO;
        if (board[currentPieceXPos[i+1]][currentPieceYPos[i]] != 0) return NO;
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
        if (board[currentPieceXPos[i-1]][currentPieceYPos[i]] != 0) return NO;
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

-(void)rotate{

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

-(void)clearFullRows{
    
}

-(NSInteger)getScore{
    return self.score;
}

@end
