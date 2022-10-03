% Task 1

% 1.a
declare QuadraticEquation
proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
   UnderRot = (B * B) - 4.0 * A * C in
   if UnderRot < 0.0 then
      RealSol = false
   else
      RealSol = true
   end
   X1 = (~B + {Float.sqrt UnderRot}) / (2.0 * A)
   X2 = (~B - {Float.sqrt UnderRot}) / (2.0 * A)    
end

{System.showInfo "Task 1"}

local RealSol X1 X2 in   
   {System.showInfo "Task 1a: input: A: 1 B: 5 C: 6"}

   {QuadraticEquation 1.0 5.0 6.0 RealSol X1 X2}
   {System.showInfo "RealSol: "}
   {System.show RealSol}
   {System.showInfo "X1: "}
   {System.show X1}
   {System.showInfo "X2: "}
   {System.show X2}
end
local RealSol X1 X2 in   
   {System.showInfo "Task 1a: input: A: 4 B: 2 C: 3"}

   {QuadraticEquation 4.0 2.0 3.0 RealSol X1 X2}
   {System.showInfo "RealSol: "}
   {System.show RealSol}
   {System.showInfo "X1: "}
   {System.show X1}
   {System.showInfo "X2: "}
   {System.show X2}

end

local RealSol X1 X2 in   
   {System.showInfo "Task 1b: input: A: 2 B: 1 C: -1"}

   {QuadraticEquation 2.0 1.0 ~1.0 RealSol X1 X2}
   {System.showInfo "RealSol: "}
   {System.show RealSol}
   {System.showInfo "X1: "}
   {System.show X1}
   {System.showInfo "X2: "}
   {System.show X2}
end
local RealSol X1 X2 in   
   {System.showInfo "Task 1b: input: A: 2 B: 1 C: 2"}

   {QuadraticEquation 2.0 1.0 2.0 RealSol X1 X2} {System.showInfo
   "RealSol: "} {System.show RealSol} {System.showInfo "X1: "}
   {System.show X1} {System.showInfo "X2: "} {System.show X2}

end


% Task 2

declare Sum
fun {Sum List}
   case List of Head | Tail then
      Head + {Sum Tail}
   else
      0
   end
end

{System.showInfo "Task 2"}


{System.showInfo "Task 2: input: [1 2 3 4 5 6]"}

{System.show {Sum [1 2 3 4 5 6]}}




% Task 3

% 3ab
declare RightFold
fun {RightFold List Op U}
   case List of Head | Tail then
      {Op Head {RightFold Tail Op U}}
   else
      U
   end
end

{System.showInfo "Task 3"}

{System.showInfo "Task 3a: input: SUM [1 2 3 4 5 6]"}
% 3c
{System.show {RightFold [1 2 3 4 5 6] fun {$ A B} A + B end 0}}

{System.showInfo "Task 3a: input: LENGTH [1 2 3 4 5 6]"}
% 3c
{System.show {RightFold [1 2 3 4 5 6] fun {$ A B} 1 + B end 0}}



% Task 4
declare Quadratic
fun {Quadratic A B C}
   fun {$ X}
      A * X * X + B * X + C
   end
end

{System.showInfo "Task 4"}


{System.showInfo "Task 4: input: {{Quadratic 3 2 1} 2}"}

{System.show {{Quadratic 3 2 1} 2}}


% Task 5
% 5a
