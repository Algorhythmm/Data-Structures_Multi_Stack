with ada.text_IO; use ada.text_IO;
with ada.Integer_text_IO; use ada.Integer_text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Characters.Handling;
with B_Stack;
use B_Stack.listRecord_IO;

procedure B_main is

   fromUser : Character;
   userEntry: B_Stack.listRecord;
   endEntry, is_overflow, lowMemory : Boolean;
   arrayMin, arrayMax, L0, Max, numStacks, numLocations, kth_stack : Integer;

begin
   endEntry := False;
   is_overflow := False;
   lowMemory := False;   Put_Line("Where would you like the array (not the Multi-Stack) to start?"); -- Get array lower bound from user
   get(arrayMin);
   put("You entered: ");
   put(arrayMin);
   New_Line;

   Put_Line("Where would you like the array (not the Multi-Stack) to end?"); -- Get array upper bound from user
   get(arrayMax);
   put("You entered: ");
   put(arrayMax);
   New_Line;

   Put_Line("Where (in the array) do you want the Multi-Stack to start?"); -- Get Multi-Stack starting point from user.
   get(L0);
   put("You entered: ");
   put(L0);
   New_Line;

   Put_Line("How many spaces would you like to reserve for your Multi-Stack?"); -- Get total ammount of memory for Multi-Stack from user.
   get(numLocations);
   put("You entered: ");
   put(numLocations);
   New_Line;
   Max := numLocations + L0;
   put("The end of the Multi-Stack is located at :"); put(Max);
   New_Line;
   put("So your Multi-Stack space will be from "); put(L0, 0); put(" to "); put(Max, 0); Put_Line(".");

   Put_Line("How many stacks do you want to make?"); -- Get number of stacks from user.
   get(numStacks);
   put("You entered: ");
   put(numStacks);
   New_Line;



   declare
     userArray : B_Stack.multiStack(arrayMin..arrayMax);
      base: B_Stack.anySize_intArray(1..(numStacks + 1));

      top: B_Stack.anySize_intArray(1..numStacks);
      oneArray : B_Stack.anySize_intArray(1..(numStacks + 1));
   begin

      --print the original bases and tops before insertion and deletion takes place
      for i in base'range loop
         if i = base'last then
            base(i) := Max;
            put("Base["); put(i, 2); put("] = "); put(base(i), 2);
            New_Line;
         else
            base(i) := B_Stack.floor(float(i - 1) / float(numStacks) * float(numLocations)) + L0;
            top(i) := base(i);
            oneArray(i) := top(i);
            put("Base["); put(i, 1); put("] = "); put(base(i), 2);
            put("   Top["); put(i, 1); put("] = "); put(top(i), 2);
            put("   OLDTop["); put(i, 1); put("] = "); put(oneArray(i), 2);
            New_Line;
         end if;
      end loop;


      New_Line;
      put_line("Now let's begin record entry/deletion.");
      New_Line;

      endEntry := False;
      Do_Loop :
      loop
         put_line("Press 'I' to Insert a record, or 'D' to Delete a record. Press 'Q' at any time to quit record entry/deletion.");
         get(fromUser);
         fromUser := Ada.Characters.Handling.To_Lower(fromUser);

         if fromUser = 'i' then
            Put_Line("You entered 'I'.");
            Put_Line("Which stack would you like to save the record to?");
            get(kth_stack);
            Put("You entered:");
            put(kth_stack, 3);
            New_Line;

            Put("What would you like to save to stack #");
            put(kth_stack, 0);
            Put_Line("?");
            get(userEntry);
            Put("You entered:  ");
            put(userEntry);
            New_Line;
            put("Inserting ");
            put(userEntry);
            put(" into stack #");
            put(kth_stack, 0);
            New_Line;
            New_Line;

            B_Stack.push(kth_stack, top, base, userEntry, userArray, is_overflow);

            if is_overflow = True then
               Put_Line("That stack is full...Reallocating stack space");
               --Overflow has occured, time to Reallocate
               B_Stack.Reallocate(top, base, oneArray, numStacks, kth_stack, userArray, userEntry, lowMemory);
               if lowMemory = True then
                  --availSpace < (minSpace - 1.0) so end program
                  goto terminate_Program;
               end if;
            end if;


         else if fromUser = 'd' then
               Put_Line("Which stack would you like to delete from?");
               get(kth_stack);
               put("You entered:");
               put(kth_stack);
               New_Line;
               Put("Deleting at stack#");
               put(kth_stack, 3);
               New_Line;
               B_Stack.pop(kth_stack, top, base, userArray);
            end if;
         end if;
            exit Do_Loop when fromUser = 'q';
               end loop Do_Loop;



      <<terminate_Program>>

   end;




   --  Insert code here.
 --  null;
end B_main;
