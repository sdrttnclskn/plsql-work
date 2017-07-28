Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.

Explanation

Values in the tuple(20,20,23)  form an Isosceles triangle, because A=B. 
Values in the tuple(20,20,20)   form an Equilateral triangle, because A=B=C. Values in the tuple(20,21,22)  form a Scalene triangle, because A,B,C difreent . 
Values in the tuple(13,14,30)   cannot form a triangle because the combined value of sides A and B is not larger than that of side C.

Solution ;

select case
         when a + b > c and a + c > b and b + c > a then
          case
            when a = b and b = c then
             'Equilateral'
            when a = b or b = c or c = a then
             'Isosceles'
            when a != b or b != c or a != c then
             'Scalene'
          end
         else
          'Not A Triangle'
       end
from   triangles;
