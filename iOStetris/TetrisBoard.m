//
//  TetrisBoard.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "TetrisBoard.h"

//pieces
#define IPOLYOMINO 0
#define OPOLYOMINO 1
#define TPOLYOMINO 2
#define LPOLYOMINO 3
#define JPOLYOMINO 4
#define SPOLYOMINO 5
#define ZPOLYOMINO 6

//directions
#define UP 0
#define RIGHT 1
#define DOWN 2
#define LEFT 3

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
                board[x][y] = 0;
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
                currentPieceYPos[i] = 17;
                currentPieceXPos[i] = 3+i;
            }
            break;
            
        case OPOLYOMINO:
            currentPieceXPos[0] = currentPieceXPos[2] = 4;
            currentPieceXPos[1] = currentPieceXPos[3] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = 17;
            currentPieceYPos[2] = currentPieceYPos[3] = 16;
            break;
            
        case TPOLYOMINO:
            currentPieceXPos[0] = 3;
            currentPieceXPos[1] = currentPieceXPos[3] = 4;
            currentPieceXPos[2] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = currentPieceYPos[2] = 17;
            currentPieceYPos[3] = 16;
            break;
            
        case LPOLYOMINO:
            currentPieceXPos[0] = currentPieceXPos[3] = 3;
            currentPieceXPos[1] = 4;
            currentPieceXPos[2] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = currentPieceYPos[2] = 17;
            currentPieceYPos[3] = 16;
            break;
            
        case JPOLYOMINO:
            currentPieceXPos[0] = 3;
            currentPieceXPos[1] = 4;
            currentPieceXPos[2] = currentPieceXPos[3] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = currentPieceYPos[2] = 17;
            currentPieceYPos[3] = 16;
            break;
            
        case SPOLYOMINO:
            currentPieceXPos[2] = 3;
            currentPieceXPos[0] = currentPieceXPos[3] = 4;
            currentPieceXPos[1] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = 17;
            currentPieceXPos[2] = currentPieceXPos[3] = 16;
            break;
            
        case ZPOLYOMINO:
            currentPieceXPos[0] = 3;
            currentPieceXPos[1] = currentPieceXPos[2] = 4;
            currentPieceXPos[3] = 5;
            currentPieceYPos[0] = currentPieceYPos[1] = 17;
            currentPieceXPos[2] = currentPieceXPos[3] = 16;
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
        if (currentPieceYPos[i] == 0) return NO;
        if (board[currentPieceXPos[i]][currentPieceYPos[i-1]] != 0) return NO;
    }
    return YES;
}

-(void)moveDown{
    if(![self canMoveDown]){
        for (int i = 0; i < 4; i++) {
            board[currentPieceXPos[i]][currentPieceYPos[i]] = currentPiece;
            [self nextPiece];
        }
        return;
    }
    for (int i = 0; i < 4; i++)
        currentPieceYPos[i]--;
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
