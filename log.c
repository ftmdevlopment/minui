#include <unistd.h>
#include <sys/types.h>

#include <stdio.h>
#include <stdarg.h>

#include "log.h"

static int gr_log_level = INFO;

static const char* name[16] = {
	[VERBOSE] = "V",
	[DEBUG] = "D",
	[INFO] = "I",
	[WARN] = "W",
	[ERROR] = "E",
};

void gr_set_log_level(int level)
{
	gr_log_level = level;
}

int gr_log_print(const char* file, int line, const char* func,
	int level, const char* fmt, ...)
{
	int ret = 0;
	va_list ap;
	va_start(ap, fmt);
	if (level >= gr_log_level) {
		printf("%s +%d @ %s: %d %d %s ", file, line, func, getpid(), gettid(), name[level]);
		ret = vprintf(fmt, ap);
	}
	va_end(ap);
	return ret;
}


