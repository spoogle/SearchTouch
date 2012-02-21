//
//  SearchDefs.h
//  Search
//
//  Created by Julian Richardson on 8/30/11.
//  Copyright 2011, 2012 Julian Richardson. Licensed under MIT license. See LICENCE.TXT.

#define MAXSIZE 5

typedef uint32_t DocID;

typedef struct {
    DocID max;
    DocID pivot;
    /*! Retained data array */
    NSArray *data;
} TreeInfo;

#define NUMBERTOKEN @"$?$"
