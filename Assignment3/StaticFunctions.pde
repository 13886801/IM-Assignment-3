/*
Returns the distance between two points using the distance formula.
It however does not do the square root operation of the fomula as
it is an expensive operation that may not be needed at all.
*/
float quickDistance(Location a, Location b) {
  float xDist = b.x - a.x;
  xDist *= xDist;
  
  float yDist = b.y - a.y;
  yDist *= yDist;
  
  return abs(xDist - yDist);
}
