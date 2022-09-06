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

