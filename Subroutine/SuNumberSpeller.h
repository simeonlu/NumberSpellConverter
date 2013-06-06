//
//  SuNumberSpeller.h
//  Subroutine
//
//  Created by Shimin Lu on 11/03/2013.
//  Copyright (c) 2013 shimin lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuNumberSpeller : NSObject

-(NSString*)spellFormatNumber:(NSNumber*)number;
-(NSString*)convertToSpellString:(NSString*)numStr;

@end
