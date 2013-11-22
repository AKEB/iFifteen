/*
 *  Settings.h
 *  iFifteen
 *
 *  Created by AKEB on 9/3/10.
 *  Copyright 2010 AKEB.RU. All rights reserved.
 *
 */

#define DEBUG                0  // 1 - ТЕСТ; 0 - БОЙ

#if (DEBUG)
	#define OPENFEINT_PRODUCT_KEY @"C0TmKY4Hq7WS0ZUuX3qlEw"
	#define OPENFEINT_SECRET      @"qcWMsmViB6vFMTRIik7dXU2bOKXXnTp7i9GvbIUA"
	
	#define LEADERBOARD_N_TIME  @"469314"
	#define LEADERBOARD_N_STEP  @"469304"
	#define LEADERBOARD_A_TIME  @"469864"
	#define LEADERBOARD_A_STEP  @"469804"
	
	#define LEADERBOARD_N_TOTAL @"470534"
	#define LEADERBOARD_A_TOTAL @"470544"
	#define LEADERBOARD_TOTAL   @"470554"
	
	
	#define AKEB_HOST @"www.akeb.ru"
	#define AKEB_SCRIPT @"/pub/iPhoneApi.php"
	#define AKEB_APP_ID	@"1"
	#define AKEB_SECRET @"dfhb234hbhSFhbk2324"
	#define AKEB_VERSION @"500"
	
	#define DIFFICULTY         2
#else
	// БОЙ
	#define OPENFEINT_PRODUCT_KEY @"C0TmKY4Hq7WS0ZUuX3qlEw"
	#define OPENFEINT_SECRET      @"qcWMsmViB6vFMTRIik7dXU2bOKXXnTp7i9GvbIUA"
	
	#define LEADERBOARD_N_TIME  @"469314"
	#define LEADERBOARD_N_STEP  @"469304"
	#define LEADERBOARD_A_TIME  @"469864"
	#define LEADERBOARD_A_STEP  @"469804"

	#define LEADERBOARD_N_TOTAL @"470534"
	#define LEADERBOARD_A_TOTAL @"470544"
	#define LEADERBOARD_TOTAL   @"470554"

	
	#define AKEB_HOST @"www.akeb.ru"
	#define AKEB_SCRIPT @"/pub/iPhoneApi.php"
	#define AKEB_APP_ID	@"1"
	#define AKEB_SECRET @"dfhb234hbhSFhbk2324"
	#define AKEB_VERSION @"500"
	
	#define DIFFICULTY         300
	
#endif

#define BLOCK_WIDTH         76
#define BLOCK_HEIGHT        76
#define BLOCKS_COUNT        16
#define BLOCK_DIV            5
#define ROW_SIZE             4

