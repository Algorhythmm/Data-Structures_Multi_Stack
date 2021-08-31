with ada.Text_IO; use ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
package B_Stack is
    
   type listRecord is (Zhou, Wei, Burris, Shashidhar, Deering, An, Lester, Yang, Smith, Arcos, Rabieh, Song, Cho, Varol, Karabiyik, Cooper, McGuire, Najar, Hope, Pray, NoHope);
   package listRecord_IO is new Ada.Text_IO.Enumeration_IO(listRecord);
   use listRecord_IO;     
   type multiStack is array(Integer range <>) of listRecord;
   type anySize_intArray is array (Integer range <>) of Integer;  
   
   procedure push (k: integer; t,b: in out anySize_intArray; stackEntry: listRecord; stackSpace: out multiStack; isfull: out Boolean);
   procedure pop (k: integer; t,b: in out anySize_intArray; stackSpace: multiStack);
   procedure Reallocate (t, b, oneArr: in out anySize_intArray;n, k: in Integer; stackSpace: in out multiStack; stackEntry: in listRecord; no_mem: out Boolean);
   procedure MoveStack (stackSpace: in out multiStack; t: in out anySize_intArray; b: in out anySize_intArray; oneArr: in out anySize_intArray; n: Integer);
   function floor(x: float) return integer;
   procedure print_AlphaOmegas (t, b, oldT: in anySize_intArray);
   procedure dumpStackSpace (t, b: in anySize_intArray; stackSpace: in multiStack; n: in Integer);

end B_Stack;
