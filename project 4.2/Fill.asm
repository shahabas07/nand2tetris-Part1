// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(INIT)
    // Initialize i - index that runs on the screen's pixels
    @8192     // 32 * 256 number of 16-bit pixel lines to cover the entire screen
    D=A
    @i       // Initialize the index variable to 8192, this is the remaining address left to color on the screen
    M=D

(LOOP)
    // Progress the index backwards
    @i
    M=M-1
    D=M
    @INIT
    D;JLT    // If index < 0, go to INDEX INITIALIZER to reset it

    @KBD
    D=M
    @WHITE
    D;JEQ    // If Memory at the keyboard address == 0 (no key pressed), go to WHITE, else go to BLACK

    @BLACK
    0;JMP

(BLACK)
    @SCREEN   // Load the screen's first address - 16384 (0x4000)
    D=A
    @i
    A=D+M    // Add the current index to the screen's first address to color the current set of 16 pixels
    M=-1     // Set the value in the current address to -1, so that the whole word (16 bits) will be all 1s (black)
    @LOOP    // Jump back to the indexer to progress the index backwards
    0;JMP

(WHITE)
    @SCREEN   // Load the screen's first address - 16384 (0x4000)
    D=A
    @i
    A=D+M    // Add the current index to the screen's first address to color the current set of 16 pixels
    M=0      // Set the value in the current address to 0, so that the whole word (16 bits) will be all 0s (white)
    @LOOP    // Jump back to the indexer to progress the index backwards
    0;JMP

