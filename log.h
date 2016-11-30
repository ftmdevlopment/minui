enum {
	VERBOSE,
	DEBUG,
	INFO,
	WARN,
	ERROR,
};

void gr_set_log_level(int);
int gr_log_print(const char* file, int line, const char* func, int level, const char* fmt, ...); 

#define gr_log(lvl, fmt, ...) gr_log_print(__FILE__, __LINE__, __func__, lvl, fmt, ##__VA_ARGS__)
#define gr_verb(fmt, ...) gr_log(VERBOSE, fmt "\n", ##__VA_ARGS__)
#define gr_dbg(fmt, ...)  gr_log(  DEBUG, fmt "\n", ##__VA_ARGS__)
#define gr_info(fmt, ...) gr_log(   INFO, fmt "\n", ##__VA_ARGS__)
#define gr_warn(fmt, ...) gr_log(   WARN, fmt "\n", ##__VA_ARGS__)
#define gr_err(fmt, ...)  gr_log(  ERROR, fmt "\n", ##__VA_ARGS__)

