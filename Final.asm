.ORIG x3000 
LD R0, GRADE ; Main function, calls all subroutines 
JSR MAX_SCORE
JSR MIN_SCORE 
JSR AVG_SCORE 
JSR BELOW_AVR 
HALT 
MAX_SCORE 
AND R1, R1, #0 ;Max score is stored
LD R2, NUM_STUDENT ;number of studens is stored into R2
LOOP1: LDR R3, R0, #0 ;grade is R3
ADD R0, R0, #1 ;next grade
 NOT R4, R1 
ADD R4, R4, #1 ;R4 = -R1 
ADD R5, R3, R4 
BRnz SKIP_MAX_UPDATE 
AND R1, R1, #0 
ADD R1, R1, R3 ;mx score updated 
SKIP_MAX_UPDATE: ADD R2, R2, #-1 ;Decrease counter
BRp LOOP1 ;Loop continues
STI R1, ANSWER ;max value stored at x5000 
LD R0, GRADE ;R0 stored in x4000
RET ;goes back to main
MIN_SCORE 
LD R1, SCORE_MAX ;lowest score stored here 
LD R2, NUM_STUDENT ;sets r2 to number of students
LOOP2: LDR R3, R0, #0 ;students grade is now stored in R2
ADD R0, R0, #1 ;going to the next student grade
NOT R4, R3 
ADD R4, R4, #1 ;store r3 in r4 (r3 is current grade) 
ADD R5, R1, R4 
BRnz SKIP_MIN_UPDATE 
AND R1, R1, #0 
ADD R1, R1, R3 ;max grade is updated
 SKIP_MIN_UPDATE: ADD R2, R2, #-1 ;decreases counter
BRp LOOP2 ;continue if it hasnt seen ll of the students 
LD R6, ANSWER ;store R6 in ANSWER
STR R1, R6, #1 ;max score stored at x5000
LD R0, GRADE ;reset R0 for the next subroutine 
RET ;go back to main
AVG_SCORE 
AND R1, R1, #0 ;initialize to 0
LD R2, NUM_STUDENT ;set R2 to the number of students 
LOOP3: LDR R3, R0, #0 ;R3 holds students grade
ADD R0, R0, #1 ;grabbing next students grde
ADD R1, R1, R3 ;adds the two scres together 
ADD R2, R2, #-1 ;decrease counter 
 BRp LOOP3 ;keeps the loop going until the program has seen all of the students GRADE. 

LD R2, NUM_STUDENT ;load R2 to the number of students 
NOT R2, R2 
ADD R2, R2, #1 ;make R2 negative
AND R3, R3, #0 ;Set R3 to zero 
LOOP_DIV: ADD R1, R1, R2 ;subtract by the number of students rmaining 
BRnz DIV_OVER 
ADD R3, R3, #1 ;add 1 to R3 
BRnzp LOOP_DIV ;keep dividing 
DIV_OVER: ADD R3, R3, #1 ;division is over and add 1 to R3 
LD R6, ANSWER ;store the ANSWER in R6
STR R3, R6, #2 ;average is stored in R3 
LD R0, GRADE ;makes R3 the same as GRADE
RET ;go back to main
BELOW_AVR 
LD R6, ANSWER 
LDR R6, R6, #2 ;gets average scores 

NOT R6, R6 
ADD R6, R6, #1 ;minus the average score
 AND R1, R1, #0 ;keeps the numbers above 0 in R1 
LD R2, NUM_STUDENT ;load the number of students in r2
LOOP4: LDR R3, R0, #0 ;students grade is stored in R3
ADD R0, R0, #1 ;moving to the next students grde 
ADD R4, R3, R6 ;add R3 and R6 to R4
BRzp SKIP_COUNT_UPDATE 
ADD R1, R1, #1 ;updates current count 

SKIP_COUNT_UPDATE: ADD R2, R2, #-1 ;decreases r2 
BRp LOOP4 ;loop through all of the students 
LD R6, ANSWER ;load ANSWER into R6
STR R1, R6, #3 ;takes the count and stores it 
RET ;go back to main 
GRADE: .FILL x4000 
NUM_STUDENT: .FILL x001E 
ANSWER: .FILL x5000
SCORE_MAX: .FILL x7fff

.END
