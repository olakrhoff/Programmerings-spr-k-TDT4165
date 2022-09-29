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

   {QuadraticEquation 2.0 1.0 2.0 RealSol X1 X2}
   {System.showInfo "RealSol: "}
   {System.show RealSol}
   {System.showInfo "X1: "}
   {System.show X1}
   {System.showInfo "X2: "}
   {System.show X2}

end