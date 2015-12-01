#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>


typedef struct{
	char	*key;
	int32_t value;
	int32_t	idx;
	void	*next;
} entry;

typedef struct{
	entry		*first;
	uint32_t	n_entries;
} dict;


int8_t addEntry(dict *dic, entry *ne);

int8_t getEntryIdx(dict *dic, int32_t idx, entry **ent);