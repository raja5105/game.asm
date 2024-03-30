section .data

; Updated prompts and messages
prompt1 db "Player 1: Enter 'S' for Same or 'D' for Different:", 0x0a, 0
prompt2 db "Player 2: Enter 'S' for Same or 'D' for Different:", 0x0a, 0
prompt3 db "Correct!", 0x0a, 0
prompt4 db "Incorrect!", 0x0a, 0
congrats db "Congratulations! You've won a prize!", 0x0a, 0

; Updated questions and correct answers
question1 db "Number of players in a soccer team and a basketball team:", 0x0a, 0
question2 db "Number of nickels in a dollar and number of quarters in a dollar:", 0x0a, 0
question3 db "Weight of one gallon of water in liquid form and one gallon of water frozen:", 0x0a, 0

correct_answers db 'D', 'S', 'D', 0 ; Updated correct answers

max_correct_answers equ 5 ; Number of correct answers needed to win

section .bss

; Unchanged section for uninitialized variables
player1_input resb 1 ; Buffer for player 1 input
player2_input resb 1 ; Buffer for player 2 input
player1_score resb 1 ; Player 1's score
player2_score resb 1 ; Player 2's score
correct_counter resb 1 ; Counter for consecutive correct answers

section .text
global _start

_start:

; Initialize variables
mov byte [player1_score], 0
mov byte [player2_score], 0
mov byte [correct_counter], 0

; Start the game loop
game_loop:

; Display question 1
mov rax, 1
mov rdi, 1
mov rsi, question1
mov rdx, len_question1
syscall

; Prompt player 1 for input
mov rax, 1
mov rdi, 1
mov rsi, prompt1
mov rdx, len_prompt1
syscall

; Read player 1 input
mov rax, 0
mov rdi, 0
mov rsi, player1_input
mov rdx, 1
syscall

; Prompt player 2 for input
mov rax, 1
mov rdi, 1
mov rsi, prompt2
mov rdx, len_prompt2
syscall

; Read player 2 input
mov rax, 0
mov rdi, 0
mov rsi, player2_input
mov rdx, 1
syscall

; Compare inputs
mov al, [player1_input]
cmp al, [player2_input]
je correct_answer

jmp incorrect_answer

correct_answer:

; Increment scores and correct answer counter
inc byte [player1_score]
inc byte [player2_score]
inc byte [correct_counter]

; Display correct message
mov rax, 1
mov rdi, 1
mov rsi, prompt3
mov rdx, len_prompt3
syscall

jmp check_win_condition

incorrect_answer:

; Reset correct answer counter
mov byte [correct_counter], 0

; Display incorrect message
mov rax, 1
mov rdi, 1
mov rsi, prompt4
mov rdx, len_prompt4
syscall

jmp check_win_condition

check_win_condition:

; Check if a player has won
cmp byte [correct_counter], max_correct_answers
je congrats_message

; Otherwise, continue the game loop
jmp game_loop

congrats_message:

; Display congratulations message
mov rax, 1
mov rdi, 1
mov rsi, congrats
mov rdx, len_congrats
syscall

; Exit the program
mov rax, 60
xor rdi, rdi
syscall

section .data

len_question1 equ $ - question1 ; Length of question1 string
len_prompt1 equ $ - prompt1 ; Length of prompt1 string
len_prompt2 equ $ - prompt2 ; Length of prompt2 string

