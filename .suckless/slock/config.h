/* user and group to drop privileges to */
static const char *user  = "alba";
static const char *group = "alba";

static const char *message = "Password:";
static const char *font_name = "fixed";
static const char *text_color = "#DDDDDD";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#080808",     /* after initialization */
	[INPUT] =  "#080808",   /* during input */
	[FAILED] = "#3A0A0A",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
