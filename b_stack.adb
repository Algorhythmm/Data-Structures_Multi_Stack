with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Text_IO; use ada.Text_IO;
package body B_Stack is
   
   
   
   procedure push (k: integer; t,b: in out anySize_intArray; stackEntry: listRecord; stackSpace: out multiStack; isfull: out boolean) is
   begin
      t(k) := t(k) + 1;
      if (t(k) > b(k + 1)) then
         isfull := True;
         --report overflow; ( use algorithm reallocate to detirmine if additional
         --space can be made available by taking it from another stak
         New_Line;
      else 
         stackSpace(t(k)) := stackEntry;               
      end if;
   
   end push;
   
   procedure pop (k: integer; t,b: in out anySize_intArray; stackSpace: multiStack) is
      
      stackDeletion : listRecord;
   begin      
      if t(k) = b(k) then
         put("There is nothing in that stack to delete");
         --report underflow;
      else 
         stackDeletion := stackSpace(t(k));
         put("You just deleted ");
         put(stackDeletion);
         New_Line;
         New_Line;
         t(k) := t(k) - 1;         
      end if;
   end pop;
   
   procedure Reallocate (t, b, oneArr : in out anySize_intArray; n, k : in Integer; stackSpace: in out multiStack; stackEntry: in listRecord; no_mem: out Boolean) is
      availSpace, inc, jj : Integer;
      minSpace, growthAllocate, equalAllocate, alpha, beta, sigma, tau : float;
   begin 
      --print base top and oldTop
      New_Line;
      Put_Line("Base, Top, and OLDTop BEFORE repacking.");
      print_AlphaOmegas(t, b, oneArr);
      --print contents of stackSpace
      New_Line;
      Put_Line("Multi-Stack contents BEFORE repacking.");
      dumpStackSpace(t, b, stackSpace, n);
      no_mem := False;
      availSpace := b(n + 1) - b(1);
      minSpace := 0.05 * float((b(n + 1) - b(1)));
      inc := 0;      
      
      jj := n;      
      while jj > 0 loop         
         availSpace := availSpace - (t(jj) - b(jj));         
         if t(jj) > oneArr(jj) then
           oneArr(jj + 1) := t(jj) - oneArr(jj);          
            inc := inc + oneArr(jj + 1);
         else
            oneArr(jj + 1) := 0;
         end if;         
         jj := jj - 1;
      end loop;       
      
      --Check for low memory and terminate if too low
      if float(availSpace) < (minSpace - 1.0) then          
         no_mem := True;
         Put_Line("Memory has fallen below 5% of the original space allocation...Program terminating.");
         goto low_memory;
      end if;
      
      equalAllocate := 0.13;
      growthAllocate := 1.0 - equalAllocate;      
    
      alpha := equalAllocate * float(availSpace) / float(n);
      beta := growthAllocate * float(availSpace) / float(inc);
      
      oneArr(1) := b(1);
      sigma := 0.0;
      for j in 2..n loop          
         tau := sigma + alpha + float(oneArr(j)) * beta;         
         oneArr(j) := oneArr(j-1) + (t(j-1) - b(j-1)) + floor(tau) - floor(sigma);         
         sigma := tau;
      end loop;
      
      t(k) := t(k) - 1;
      MoveStack(stackSpace, t, b, oneArr, n);
      t(k) := t(k) + 1;
      stackSpace(t(k)) := stackEntry; 
      
      for j in 1..n loop
         oneARR(j) := t(j);
      end loop; 
      New_Line;
      Put("Base, Top, and OLDTop AFTER repacking.");
      Put_Line(" (Reallocate and MoveStack are done) OLDTop[j] = Top[j] to prepare for next overflow");
      --print base, top, and oldTop
      print_AlphaOmegas(t, b, oneArr);
      New_Line;
      Put_Line("Multi-Stack contents AFTER repacking.");
      --print contents of stackSpace
      dumpStackSpace(t, b, stackSpace, n);      
      
      <<low_memory>> 
      end Reallocate;
      
   procedure MoveStack (stackSpace: in out multiStack; t: in out anySize_intArray; b: in out anySize_intArray; oneArr: in out anySize_intArray; n: Integer) is
      delt, i, L: Integer;
   begin  
      i := n;
      for j in 2..n loop
         if oneArr(j) < b(j) then
            delt := b(j) - oneArr(j);
            for L in (b(j) + 1)..t(j) loop
               stackSpace(L - delt) := stackSpace(L);
            end loop;
            b(j) := oneArr(j);
            t(j) := t(j) - delt;
         end if;
      end loop;      
      
      while i > 1 loop
         if oneArr(i) > b(i) then           
            delt := oneArr(i) - b(i); 
            L := t(i);
            while L > b(i) loop
               --    for L in reverse t(i)..(b(i) + 1) loop (never enters loop for some reason)
               --    i think it is because t(i) and b(i) could be any value as far as the compiler is concerned
               --    and therefore b(i) could potentially be greater than t(i)???             
               stackSpace(L + delt) := stackSpace(L);
               L := L - 1;
            end loop;
            b(i) := oneArr(i);
            t(i) := t(i) + delt;
         end if;
         i := i - 1;
      end loop;      
      end MoveStack;
      
      --takes the floor of a float value (thanks for this hint/giveaway!)
   function floor(x: float) return integer is 
      temp: Long_Integer;
   begin
      temp := Long_Integer(x);
      if (float(temp) <= x) then
      return integer(temp);
   else 
         return integer(temp - 1);
      end if;      
   end floor;
   
   --prints top base and oldTop from begining to end
   procedure print_AlphaOmegas (t, b, oldT: in anySize_intArray) is 
   begin
      for i in t'range loop
         put("Base["); put(i, 1); put("] = "); put(b(i), 2);
         put("   Top["); put(i, 1); put("] = "); put(t(i), 2);
         put("  OLDTop["); put(i, 1); put("] = "); put(oldT(i), 2);
         New_Line;
      end loop;
   end print_AlphaOmegas;
   
   --prints stackSpace contents with indexes as well as the base and top of each stack
   procedure dumpStackSpace (t, b: in anySize_intArray; stackSpace: in multiStack; n: in Integer) is
      dontPrintLast: boolean;
   begin
      for i in 1..n loop
         dontPrintLast := False;         
         Put("Stack#"); put(i, 1); put(" | Base = "); put(b(i), 2); put("   Top = "); put(t(i), 2);
         Put(" | Currently contains...");
         New_Line;    
            for j in (b(i) + 1)..t(i) loop 
            if j <= b(i + 1) then                              
               Put(stackSpace(j)); put(" at "); put(j, 2); put("   ");  
               end if;               
         end loop;
         New_Line;
         New_Line;   
      end loop;
      end dumpStackSpace;
   
end B_stack;
