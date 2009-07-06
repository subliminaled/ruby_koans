# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  if a==0 
    raise TriangleError.new("Side a of the triangle cannot be zero.")
  end
  if b==0 
    raise TriangleError.new("Side b of the triangle cannot be zero.")
  end
  if c==0 
    raise TriangleError.new("Side c of the triangle cannot be zero.")
  end
  if a<0 
    raise TriangleError.new("Side a of the triangle cannot be less than zero.")
  end
  if b<0 
    raise TriangleError.new("Side b of the triangle cannot be less than zero.")
  end
  if c<0 
    raise TriangleError.new("Side c of the triangle cannot be less than zero.")
  end
  if (a+b <= c) || (a+c <=b) || (b+c<=a)
    raise TriangleError.new("Sum of any two sides cannot be <= the other side.")
  end if
  
  sides_equal = 0
  
  sides_equal +=1 if a==b
  sides_equal +=1 if b==c
  sides_equal +=1 if a==c
  
  return :equilateral if sides_equal == 3
  return :isosceles if sides_equal == 1
  return :scalene if sides_equal == 0
  
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
