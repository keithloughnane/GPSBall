//
//  DataBaseControler.m
//  FitNexus
//
//  Created by keith on 07/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DataBaseControler.h"


@implementation DataBaseControler
-(NSString *)dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}
-(int)initWithOwner : (id) owner
{
	
	NSLog(@"Setting up experiemtal socket connection");
	myNetCon = [netCon alloc];
	[myNetCon init];
	
	
	
	
	
	
	PK = 0;
	startDate = endDate = 0.0;
	NSLog(@"DB started Loaded");
	if(sqlite3_open([[self dataFilePath] UTF8String],&database) != SQLITE_OK)
	{
		sqlite3_close(database);
		NSLog(@"DB Failed to open");
		return -1;
	}
	NSLog(@"DB Loading done");
	[self create];
	//[self saveDataPoint:@"2009-09-01 12:00:45.123":@"TEST":123.456:@"123":456.789];
	
	
	/*
	for(int i = 0; i < (int)[testList count]; i++)
	{
		//[[myArray objectAtIndex:2] intValue];
		NSLog(@"Test IDs returned %f", [[testList objectAtIndex:i] doubleValue] );
		[self selectSession:[[testList objectAtIndex:i] doubleValue]];
		
	}
	*/
	myOwner  = owner;
	
	[self DBloadToNet];
	
	return 0;
}

-(int)create
{
	NSString *createSQL = @"CREATE TABLE IF NOT EXISTS DATAPOINTS (ID INTEGER , DATETIME REAL PRIMARY KEY,TYPE TEXT,FLOATDATA REAL,STRINGDATA TEXT,VERSION INTEGER,ERRORMARGIN REAL);";
	char *errorMsg;
	
	if(
		sqlite3_exec (database,[createSQL UTF8String],NULL,NULL, &errorMsg)
		!= SQLITE_OK)
	{
		sqlite3_close(database);
		NSLog(@"Failed to exec create statment, error:%d",errorMsg);
		NSAssert1(0,@"Error updating tables: %s", errorMsg);
		return -1;
	}
	NSLog(@"db CREATION DONE");
	return 0;
}

-(int)selectSession : (double) datetime
{
	startDate = datetime;
	// TODO: FIX THIS
	endDate = datetime + (60*60); // temperaliy i'm saying enver sessionm lasts an hour.
	/*
	NSLog(@"setting session times");
	
	NSString *query = [[NSString alloc] initWithFormat:@"SELECT DATETIME FROM DATAPOINTS WHERE TYPE = 'END' AND FLOATDATA = %f ORDER BY DATETIME",startDate];
	sqlite3_stmt *statement;
	if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil) == SQLITE_OK)
	{
		while(sqlite3_step(statement)==SQLITE_ROW)
		{
		endDate = sqlite3_column_double(statement, 0);
		
		sqlite3_finalize(statement);	
		NSLog(@"Success session start %f end %f",startDate,endDate);
		}
	}
	
	else
	{
		NSLog(@"Getting session times failed");
	}
	*/
	
	return 0;
}





-(NSMutableArray *)getSessionIDs
{
	NSMutableArray *list=[[NSMutableArray alloc] init];
	NSLog(@"getting ID's");
	
	NSString *query = @"SELECT DATETIME, STRINGDATA, FLOATDATA FROM DATAPOINTS WHERE TYPE = 'BEGAN' ORDER BY DATETIME";
	sqlite3_stmt *statement;
	char errorMSG;
	
	//int e = ;
	if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil) == SQLITE_OK)
	{
		while(sqlite3_step(statement)==SQLITE_ROW)
		{
			double colDate = sqlite3_column_double(statement, 0);
			NSLog(@"Original IDs returned %f",colDate);
			//int DBCount = [statement 
			NSLog(@"DB return Count :");
			[list addObject:[NSNumber numberWithDouble:colDate]];
			
		
		}
		sqlite3_finalize(statement);
	}
	else
	{
		NSAssert1(0,@"error in get session ID: %s",errorMSG);
	}
	
	NSLog(@"getting ID's done");
	NSLog(@"Retrurn count = %d",(int)[list count]);
	//NSLog(@"Test IDs returned %d", [[list objectAtIndex:0] doubleValue] );
	

	
	return list ;
}

-(int)saveDataPoint: (double) datetime : (NSString *) datatype : (double) floatData: (NSString *) stringData : (double) errorMargin;
{
	// HIGHLY EXPERIMENTAL


	
	
	/*
	 myAccelGetter =  [AccelGetter alloc] ;
	 [myAccelGetter initWithOwner:self];	
	 
	*/
	
	
	
	
	
	
	
	
	//NSLog(@"dividing by zero");
	//int x = 1/0; // pupasly breaking execution
	
	// END EXPERIMENT
	//NSLog(@"SAVING");
	NSString *update = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE INTO DATAPOINTS (ID, DATETIME,TYPE,FLOATDATA ,STRINGDATA ,VERSION ,ERRORMARGIN ) VALUES (%d, '%f','%@', %f,'%@',%d,%f);",PK,datetime,datatype,floatData,stringData,1,errorMargin];
	//NSLog(@"Declared statement and");
	char *errorMsg;
	//NSLog(@"error char execing");
	if(
		sqlite3_exec (database,[update UTF8String],NULL,NULL,&errorMsg)
		!= SQLITE_OK)
	{
		NSAssert1(0,@"Error updating tables: %s", errorMsg);
		NSLog(@"error updating");
		sqlite3_free(errorMsg);
		return -1;
	}
	//NSLog(@"saving done");
	PK++;
	return 0;
}
-(int)DBload
{
	
	// THIS IS NOT DBloadNET  VVVV 
	
	NSLog(@"BDLOAD");
	NSString *query = @"SELECT ID, DATETIME, TYPE ,FLOATDATA ,STRINGDATA ,VERSION ,ERRORMARGIN FROM DATAPOINTS ORDER BY DATETIME";
	sqlite3_stmt *statement;
	char errorMsg = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
	if(
	   errorMsg
	    == SQLITE_OK)
	{
		NSLog(@"LOAD PREP SUCCESS");
					NSLog(@"Returned From database >> ");
		while(sqlite3_step(statement)==SQLITE_ROW)
		{
			int ID = sqlite3_column_int(statement, 0);
			double datetime = sqlite3_column_double(statement,1);
			char *type = sqlite3_column_text(statement,2);
			
			double floatData = sqlite3_column_double(statement, 3);
			
			char *stringData = sqlite3_column_text(statement,4);
			
			int version = sqlite3_column_int(statement, 5);
			
			double errorMargin = sqlite3_column_double(statement, 6);
			

			
			

			//NSString *Sdatetime = [[NSString alloc] initWithUTF8String:datetime];
			NSString *Stype = [[NSString alloc] initWithUTF8String:type];
			NSString *SstringData = [[NSString alloc] initWithUTF8String:stringData];
			//NSString *returned = [[NSString alloc] initWithUTF8String:col2];
			
			
			
			
			NSLog(@"$%d:%f:%@:%f:%@:%d:%f$",ID,datetime,Stype,floatData,SstringData,version,errorMargin);
			
		}
		
	}
	//NSLog(@"error num %d",errorMsg);
//NSAssert1(0,@"Error updating tables: %s", errorMsg);
	sqlite3_finalize(statement);
	
	
	
	
	return 0;
}
-(int)DBloadToNet
{
	NSLog(@"BDNETLOAD");
	NSString *query = @"SELECT ID, DATETIME, TYPE ,FLOATDATA ,STRINGDATA ,VERSION ,ERRORMARGIN FROM DATAPOINTS ORDER BY DATETIME";
	sqlite3_stmt *statement;
	char errorMsg = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
	if(
	   errorMsg
	   == SQLITE_OK)
	{
		NSLog(@"LOAD PREP SUCCESS");
		NSLog(@"Returned From database >> ");
		while(sqlite3_step(statement)==SQLITE_ROW)
		{
			int ID = sqlite3_column_int(statement, 0);
			double datetime = sqlite3_column_double(statement,1);
			char *type = sqlite3_column_text(statement,2);
			
			double floatData = sqlite3_column_double(statement, 3);
			
			char *stringData = sqlite3_column_text(statement,4);
			
			int version = sqlite3_column_int(statement, 5);
			
			double errorMargin = sqlite3_column_double(statement, 6);
			
			
			
			
			
			//NSString *Sdatetime = [[NSString alloc] initWithUTF8String:datetime];
			NSString *Stype = [[NSString alloc] initWithUTF8String:type];
			NSString *SstringData = [[NSString alloc] initWithUTF8String:stringData];
			//NSString *returned = [[NSString alloc] initWithUTF8String:col2];
			
			//NSString *update = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE INTO DATAPOINTS (ID, DATETIME,TYPE,FLOATDATA ,STRINGDATA ,VERSION ,ERRORMARGIN ) VALUES (%d, '%f','%@', %f,'%@',%d,%f);",PK,datetime,datatype,floatData,stringData,1,errorMargin];
			NSLog(@"Made it to here1");
			
			NSString *str = [[NSString alloc] initWithFormat:@"$DATAPUSH:keith.loughnane@gmail.com:%d:%f:%@:%f:%@:%d:%f$",ID,datetime,Stype,floatData,SstringData,version,errorMargin];
		
			
			
			NSLog(@"Made it to here");
			
			//NSLog(@"$%d:%f:%@:%f:%@:%d:%f$",ID,datetime,Stype,floatData,SstringData,version,errorMargin);
			NSLog(@"STRING SAYS : %@",str);
			[myNetCon sendData:str];
			
		}
		
	}
	//NSLog(@"error num %d",errorMsg);
	//NSAssert1(0,@"Error updating tables: %s", errorMsg);
	sqlite3_finalize(statement);
	
	
	
	
	return 0;
}	
-(int)DBloadIntoStatsView
{
	NSLog(@"BDLOAD");
	NSString *query = @"SELECT ID, DATETIME, TYPE ,FLOATDATA ,STRINGDATA ,VERSION ,ERRORMARGIN FROM DATAPOINTS ORDER BY DATETIME";
	sqlite3_stmt *statement;
	char errorMsg = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
	if(
	   errorMsg
	   == SQLITE_OK)
	{
		NSLog(@"LOAD PREP SUCCESS");
		NSLog(@"Returned From database >> ");
		int accelIndex, locIndex;
		accelIndex = locIndex = 0;
		while(sqlite3_step(statement)==SQLITE_ROW)
		{
			
			int ID = sqlite3_column_int(statement, 0);
			double datetime = sqlite3_column_double(statement,1);
			char *type = sqlite3_column_text(statement,2);
			
			double floatData = sqlite3_column_double(statement, 3);
			
			char *stringData = sqlite3_column_text(statement,4);
			
			int version = sqlite3_column_int(statement, 5);
			
			double errorMargin = sqlite3_column_double(statement, 6);
			
			
			
			
			
			//NSString *Sdatetime = [[NSString alloc] initWithUTF8String:datetime];
			NSString *Stype = [[NSString alloc] initWithUTF8String:type];
			NSString *SstringData = [[NSString alloc] initWithUTF8String:stringData];
			//NSString *returned = [[NSString alloc] initWithUTF8String:col2];
			
			
			
			
			//NSLog(@"$%d:%f:%@:%f:%@:%d:%f$",ID,datetime,Stype,floatData,SstringData,version,errorMargin);
			
			if(locIndex < 999)
			{
			if(![Stype compare:@"LOCLAT"])
			{
				[myOwner setLLat:floatData :locIndex];
				[myOwner setAT: datetime :locIndex];
				//NSLog(@"found LOCLAT");
			}
			if(![Stype compare:@"LOCLONG"])
			{
				[myOwner setLLong:floatData :locIndex];
				locIndex++;
				//NSLog(@"found LOCLONG");
			}
			if(![Stype compare:@"LOCALT"])
			{
				
				//NSLog(@"found LOCALT");
			}
			}
			// TODO: BAD ASSUMPTION i am only increasing the index on loc alt, if loc alt doesn't exist loc lat and long will be overwriten
			if(accelIndex <999)
			{
			if(![Stype compare:@"TEST ACCELX"])
			{
				[myOwner setAX:floatData :accelIndex];
				[myOwner setLT: datetime :locIndex];
				//NSLog(@"found TEST ACCELX");
				
			}
			if(![Stype compare:@"TEST ACCELY"])
			{
				[myOwner setAY:floatData :accelIndex];
				//NSLog(@"found TEST ACCELY");
			}
			if(![Stype compare:@"TEST ACCELZ"])
			{
				[myOwner setAZ:floatData :accelIndex];
				accelIndex++;
				//NSLog(@"found TEST ACCELZ");
			}
			}
			
			if(accelIndex > 999 && locIndex > 999)
			{
				sqlite3_finalize(statement);
				
				
				
				
				return 0;
			}
			
			
		}
		
	}
	//NSLog(@"error num %d",errorMsg);
	//NSAssert1(0,@"Error updating tables: %s", errorMsg);
	sqlite3_finalize(statement);
	
	
	
	
	return 0;
}

@end

