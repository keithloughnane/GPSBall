//
//  DataBaseControler.h
//  FitNexus
//
//  Created by keith on 07/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"
#import "netCon.h"
#define kFilename @"data.sqlite3"

@interface DataBaseControler : NSObject {
	sqlite3 *database;
	int PK;
	double startDate, endDate;
	id myOwner;
	netCon * myNetCon;
}

-(int)initWithOwner : (id) owner;
-(int)create;
-(int)saveDataPoint: (double) datetime : (NSString *) datatype : (double) floatData: (NSString *) stringData : (double) errorMargin;
-(int)DBload ;
-(int)DBloadToNet;
-(int)selectSession : (double) datetime;
-(int)DBloadIntoStatsView;
-(NSString *)dataFilePath;
-(NSMutableArray *)getSessionIDs;

@end
