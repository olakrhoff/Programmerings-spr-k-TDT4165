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
      {System.showInfo "run"}
   %PI = 355.0 / 113.0
   
   %A = PI * R * R
   %D = 2.0 * R
   %C = PI * D

   
   %{System.showInfo "Area: " A}
   end
   {Circle 2}
end


