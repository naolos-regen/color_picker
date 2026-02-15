module x11.Xprotostr;

version (x11d_force_exclude) {


} else version(Posix):

import x11.Xmd;

/* Used by PolySegment */

struct _xSegment {
    INT16 x1, y1, x2, y2;
}
alias xSegment = _xSegment;

/* POINT */

struct _xPoint {
    INT16       x, y;
}
alias xPoint = _xPoint;

struct _xRectangle {
    INT16 x, y;
    CARD16  width, height;
}
alias xRectangle = _xRectangle;

/*  ARC  */

struct _xArc {
    INT16 x, y;
    CARD16   width, height;
    INT16   angle1, angle2;
}
alias xArc = _xArc;
