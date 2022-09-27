% Task 1
{Browse 'Hello World!'}

% Task 2
% Done

% Task 3
local X in
   X = 9000
end

% 3.a

local X Y = 300 Z = 30 in
   X = Y * Z
end

% 3.b
local X Y in
   X = "This is a string"
   thread {System.showInfo Y} end
   Y = X
   % The '=' operator states that the left symbol and the right symbol
   % represent the same value. So i guess that the code gets preprocessed
   % and in that stage Y and X become the 'same' symbol, hence since X is
   % assigned then Y is assigned and we can print Y. This gives us the
   % possibility to assign a value after we use it as long as the symbol
   % at some later point gets assigned some value.
end

% Task 4
local X Y Min in
   fun {Min X Y}
      if X < Y then
	 X
      else
	 Y
      end
   end


   {System.showInfo {Min 10 89}}
end

% 4.a
local X Y Max in
   fun {Max X Y}
      if X > Y then
	 X
      else
	 Y
      end
   end

   {System.showInfo {Max 10 89}}
end

% 4.b
local X Y PrintGreater in
   proc {PrintGreater X Y}
      if X > Y then
	 {System.showInfo X}
      else
	 {System.showInfo Y}
      end
   end

   {PrintGreater 10 89}
end

% Task 5
local Circle R in
   proc {Circle R} A D C PI in
   
      PI = 355.0 / 113.0
   
      A = PI * R * R
      D = 2.0 * R
      C = PI * D

   
      {System.showInfo "Area: "}
      {System.showInfo A}

      {System.showInfo "Diameter: "}
      {System.showInfo D}

      {System.showInfo "Circumference: "}
      {System.showInfo C} 
   end
   {Circle 2.0}
end

% Task 6.a
local Factorial N in
   fun {Factorial N}
      if N > 0 then
	 N * {Factorial N - 1}
      else
	 1
      end
   end
   {System.showInfo "Factorial of 5: "#{Factorial 5}}
end

% Task 7.a
local Length List R in
   fun {Length List}
      if List == nil then
	 0
      else
	 1 + {Length List.2}
      end
   end
   {System.showInfo {Length [1 2 3 4]}}
end

% 7.b
local Take List Count in
   fun {Take List Count}
      if {And Count > 0 List \= nil} then
	 List.1 | {Take List.2 Count - 1}
      else
	 nil
      end
   end
   {System.show {Take [1 2 3 4] 5}}
end

% 7.c
local Drop List Count in
   fun {Drop List Count}
      if {And Count > 0 List \= nil} then
	 {Drop List.2 Count - 1}
      else
	 List
      end
   end
   {System.show {Drop [1 2 3 4] 5}}
end

% 7.d
local Append List1 List2 in
   fun {Append List1 List2}
      if List1 \= nil then
	 List1.1 | {Append List1.2 List2}
      elseif List2 \= nil then
	 List2.1 | {Append List1 List2.2}
      else
	 nil
      end
   end
   {System.show {Append [1 2 3 4] [5 6 7]}}
end

% 7.e
local Member List Element in
   fun {Member List Element}
      if List == nil then
	 false
      elseif List.1 == Element then
	 true
      else
	 {Member List.2 Element}
      end
   end
   {System.show {Member [1 2 3 4] 5}}
   {System.show {Member [1 2 3 4] 2}}
end

% 7.f
local Position List Element in
   fun {Position List Element}
      if List == nil then
	 ~1
      elseif List.1 == Element then
	 0
      else
	 1 + {Position List.2 Element}
      end
   end
   %The answer is zero-indexed
   {System.show {Position [1 2 3 4] 3}}
end

%\insert 'absolute/path/to/file/List.oz'
%{System.showInfo {Length [1 2 3]}}

% Task 8.a
local Push List Element in
   fun {Push List Element}
      if List == nil then
	 nil
      elseif Element == nil then
	 List.1 | {Push List.2 nil}
      else
	 Element | {Push List nil}	 
      end
   end
   {System.show {Push [1 2 3] 0}}
end

% 8.b
local Peek List in
   fun {Peek List}
      if List == nil then
	 nil
      else
	 List.1
      end
   end
   {System.show {Peek [3 2 1]}}
   {System.show {Peek nil}}
end

% 8.c
local Pop List in
   fun {Pop List}
      if List == nil then
	 nil
      else
	 List.2
      end
   end
   {System.show {Pop [1 2 3 4]}}
   {System.show {Pop [1]}}
   {System.show {Pop nil}}
end
