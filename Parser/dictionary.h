#ifndef DICTIONARY
#define DICTIONARY

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

typedef struct{
	char	*key;
	int32_t value;
	int32_t	idx;
	void	*next;
} entry;

typedef struct dict{
	entry		*first;
	uint32_t	n_entries;
} dict;

struct dict symbols;

int8_t addEntry(dict *dic, entry *ne);

int8_t getEntryIdx(dict *dic, int32_t idx, entry **ent);

int8_t getEntryKey(dict *dic, char *key, entry **ent);

#endif