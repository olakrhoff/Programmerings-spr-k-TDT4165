% Assignment 4

% Task 1

% 1a
local A=10 B=20 C=30 in
   {System.show C}

   thread
      {System.show A}
      {Delay 100}
      {System.show A * 10}
   end
   
   thread
      {System.show B}
      {Delay 100}
      {System.show B * 10}
   end

   {System.show C * 100}
end


% 1c
local A B C in
   thread
      A = 2
      {System.show A}
   end
   thread
      B = A * 10
      {System.show B}
   end

   C = A + B
   {System.show C}

end

% Task 2
{System.showInfo "Task 2"}
% 2a
declare Enumerate

fun {Enumerate Start End}
   
      if Start > End then
	 nil
      else
	 Start | thread {Enumerate Start + 1 End} end
      end
end

%{System.showInfo "Expected output:"}
%{System.show [1 2 3 4 5]}
%{System.show {List.take {Enumerate 1 5} 5}}


% 2b
declare GenerateOdd ConsumeList Filter

fun {Filter X}
   if X mod 2 \= 0 then
      true
   else
      false
   end
end

fun {ConsumeList List}
   case List of nil then
      nil
   [] Head|Tail then
      if {Filter Head} == true then
	 Head | thread {ConsumeList Tail} end
      else
	 thread {ConsumeList Tail} end
      end
   end
end

fun {GenerateOdd Start End}
   {ConsumeList thread {Enumerate Start End} end}
end

%{System.show {List.take {GenerateOdd 1 5} 3}}
%{System.show {List.take {GenerateOdd 4 4} 1}}


% Task 3

% 3a
% The commented code is an implementation where I missunderstood and found all the factors of the
% number and not all numbers that it is divsible by.
%declare ListDivisorsOf ListDivisorsOfConsumer IsDivisor

%fun {IsDivisor Number Divisor}
 %  if Number mod Divisor == 0 then
  %    true
  % else
   %   false
  % end
%end

%fun {ListDivisorsOfConsumer List Number}
 %  case List of nil then
  %    nil
   %[] Head|Tail then
    %  if {IsDivisor Number Head} then
%	 Head | {ListDivisorsOfConsumer thread {Enumerate 2 {Int.'div' Number Head}} end  {Int.'div' Number Head}}
 %     else
%	 {ListDivisorsOfConsumer Tail Number}
 %     end
  % end
%end

%fun {ListDivisorsOf Number}
 % {ListDivisorsOfConsumer thread {Enumerate 2 Number - 1} end Number}
%end

%{System.show {List.take {ListDivisorsOf 4} 2}}
%{System.show {List.take {ListDivisorsOf 121} 2}}
%{System.show {List.take {ListDivisorsOf 6} 2}}
%{System.show {List.take {ListDivisorsOf 210} 4}}
%{System.show {List.take {ListDivisorsOf 8} 3}}


% 3a retry
declare ListDivisorsOf ListDivisorsOfConsumer IsDivisor

fun {IsDivisor Number Divisor}
   if Number mod Divisor == 0 then
      true
   else
      false
   end
end

fun {ListDivisorsOfConsumer List Number}
   case List of nil then
      nil
   [] Head|Tail then
      if {IsDivisor Number Head} then
	 Head | thread {ListDivisorsOfConsumer Tail Number} end
      else
	 thread {ListDivisorsOfConsumer Tail Number} end
      end
   end
end

fun {ListDivisorsOf Number}
   {ListDivisorsOfConsumer {Enumerate 1 Number} Number}
end

%{System.showInfo "Divisors of 4"}
%{System.show {List.take {ListDivisorsOf 4} 3}}
%{System.showInfo "Divisors of 121"}
%{System.show {List.take {ListDivisorsOf 121} 3}}
%{System.showInfo "Divisors of 6"}
%{System.show {List.take {ListDivisorsOf 6} 4}}
%{System.showInfo "Divisors of 210"}
%{System.show {List.take {ListDivisorsOf 210} 4}}
%{System.showInfo "Divisors of 8"}
%{System.show {List.take {ListDivisorsOf 8} 4}}

%{Delay 5000}

% 3b
declare ListPrimesUntil ConsumePrimes

fun {ConsumePrimes List}
   case List of Head|Tail then
      case {ListDivisorsOf Head} of H|T then
	 if {And H == 1 T == nil} then
	    Head | thread {ConsumePrimes Tail} end
	 else if {And H == 1 T.1 == Head} then
	    Head | thread {ConsumePrimes Tail} end
	 else
	    thread {ConsumePrimes Tail} end
	      end	    
	 end
      end
   [] nil then
      nil
   end
end

fun {ListPrimesUntil N}
   {ConsumePrimes {Enumerate 1 N}}
end
{System.showInfo "Task 3b"}
{System.showInfo ""}


%{System.show {List.take {ListPrimesUntil 7} 5}}
%{System.show {List.take {ListPrimesUntil 100} 25}}


% Task 4
{System.showInfo "Task 4"}
% 4a
declare EnumerateLazy EnumerateLazyConditioned

fun lazy {EnumerateLazy}

   fun lazy {EnumerateLazyConditioned N}
      N | {EnumerateLazyConditioned N + 1}
   end
   
   1 | {EnumerateLazyConditioned 2}
end

%{System.showInfo "Expected output:"} {System.show [1 2 3 4 5]}
%{System.show {List.take {EnumerateLazy} 5}}

% 4b
declare Primes ConsumePrimesLazy

fun {ConsumePrimesLazy List}
   case List of Head|Tail then
      if Head == 1 then
	 {ConsumePrimesLazy Tail}
      else
	 case {ListDivisorsOf Head} of H|T then
	    if {And H == 1 T == nil} then
	       Head | {ConsumePrimesLazy Tail}
	    elseif {And H == 1 T.1 == Head} then
	       Head | {ConsumePrimesLazy Tail}
	    else
	       {ConsumePrimesLazy Tail}
	    end
	 [] nil then
	    nil
	 end
      end
   [] nil then
      nil
   end
end

fun lazy {Primes}
   {ConsumePrimesLazy {EnumerateLazy}}
end

{System.showInfo "Task 4b"} {System.showInfo ""}


{System.show {List.take {Primes} 9}}