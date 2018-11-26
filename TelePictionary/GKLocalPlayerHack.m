//
//  GKLocalPlayerHack.m
//  TelePictionary
//
//  Created by Jared Stevens2 on 12/5/15.
//  Copyright © 2015 Claven Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GKLocalPlayerHack.h"

@implementation GKLocalPlayerHack

GKLocalPlayer *getLocalPlayer(void)
{
    return [GKLocalPlayer localPlayer];
}

@end