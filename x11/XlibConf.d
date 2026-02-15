module x11.XlibConf;

version (x11d_force_exclude) {


} else version (Posix) :
/*
 * This header file exports defines necessary to correctly
 * use Xlibint.h both inside Xlib and by external libraries
 * such as extensions.
 */

/* Threading support? */
enum bool XTHREADS = true;

/* Use multi-threaded libc functions? */
enum bool XUSE_MTSAFE_API = true;
