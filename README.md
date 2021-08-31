# Data-Structures_Multi_Stack
B-option implementation of my Data Structures Multi-Stack assignment.

Program allows user to state initial indices for an array to contain a Multi-Stack.
User is then able to state the size of the Multi-Stack, how many stacks it contains and its starting point within the array.

Program implements the algorithms found on pages 247-250 in Donald Knuth's "The Art of Computer Programming - Vol 1 (Fundamental Algorithms)" 3rd ed.
to handle the initial starting sizes of each stack in the Multi-Stack, insertion and deletion, and reallocation of space in the event that one of the stacks overflow.

User can then enter(push) or delete(pull) records (from pre-defined list of records found in b_stack.ads) into any stack of their choice.

If one of the stack spaces overflows, the program will reallocate space with 13% of available memory divided equally among all stacks, and 87% of the available
memory is divided based on growth. No penalty is given to stacks that occupy less space at overflow than it did during the previous overflow.

The contents of each transaction is printed to the terminal. 
When overflow occurs the indices of eachs stack's 'Base' and 'Top' are printed to the terminal. The contents of each stack are also printed to the terminal both before
and after repacking / reallocating space.


***Dont Cheat***

This is an assignment I had to do for my Data Structures Class at SHSU. This one tends to be one of the hardest for most students and I have heard many stories
about people getting caught for cheating on these Data Structures Labs. Feel free to use this for reference if you'd like, but please do not copy this work.
I can guarantee you WILL get caught if you do. 


