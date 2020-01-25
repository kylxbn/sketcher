// SKETCHER
// extra_graphics.e -- Draw objects not supported by graphics.eh

def Graphics.fill_dottedrect(x1: Int, y1: Int, w: Int, h: Int) {
  var fill = 0
  var x2 = x1+w
  var y2 = y1+h
  for (var y=y1, y<y2, y+=1) {
    for (var x=x1+fill, x<x2, x+=2) {
      this.draw_line(x, y, x, y) }
    if (fill==0) fill = 1 else fill = 0 } }
    
def Graphics.fill_topflat_triangle(x1: Int, y1: Int, x2: Int, y2: Int, x3: Int, y3: Int) {
  var invslope1 = ((x3-x1).cast(Float)/(y3-y1).cast(Float))
  var invslope2 = ((x3-2x).cast(Float)/(y3-y2).cast(Float))
  var curx1: Float = 3x
  var curx2: Float = x3
  for (var scanlineY = y3, scanlineY>y1, scanlineY -= 1) {
    curx1 -= invslope1
    curx2 -= invslope2
    this.draw_line(curx1, scanlineY, curx2, scanlineY) } }
    
def Graphics.fill_bottomflat_triangle(x1: Int, y1: Int, x2: Int, y2: Int, x3: Int, y3: Int) {
  var invslope1 = ((x2-x1).cast(Float)/(y2-y1).cast(Float))
  var invslope2 = ((x3-x1).cast(Float)/(y3-y1).cast(Float))
  var curx1: Float = x1
  var curx2: Float = x1
  for (var scanlineY = y1, scanlineY<=y2, scanlineY += 1) {
    curx1 += invslope1
    curx2 += invslope2
    this.draw_line(curx1, scanlineY, curx2, scanlineY) } }

def Graphics.fill_triangle(x1: Int, y1: Int, x2: Int, y2: Int, x3: Int, y3: Int) {
  // sort 3 vertices by y-coord so v1 is the topmost vertice
  var temp1 = 0
  var temp2 = 0
  if ((y2<y1) && (y2<y3)) {
    //y2 is the topmost
    temp1 = x1
    temp2 = y1
    x1 = x2
    y1 = y2
    x2 = temp1
    y2 = temp2 }
  else if ((y3<y1) && (y3<y2)) {
    // y3 is the topmost
    temp1 = x1
    temp2 = y1
    x1    = x3
    y1    = y3
    x3    = temp1
    y3    = temp2 }
  if (y3<y2) {
    // y3 is second highest
    temp1 = x2
    temp2 = y2
    x2 = x3
    y2 = y3
    x3 = temp1
    y3 = temp2 }
  // check for bottom-flat triangle
  if ((y2 == y3) && (y1<y2)) {
    this.fill_bottomflat_triangle(x1, y1, x2, y2, x3, y3) }
  // check for top_flat triangle
  else if ((y1 == y2) && (y3>y1)) {
    this.fill_topflat_triangle(x1, y1, x2, y2, x3, y3) }
  // this is a general-case triangle
  else {
    var x4 = ((x1+((y2-y1).cast(Float)/(y3-y1).cast(Float)))*(x3-x1)).cast(Int)
    var y4 = y2
    this.fill_bottomflat_triangle(x1, y1, x2, y2, x4, y4)
    this.fill_topflat_triangle(x2, y2, x4, y4, x3, y3) } }