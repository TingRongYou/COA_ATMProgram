INCLUDE Irvine32.inc

.DATA
    ;-----------Welcome & Exit Message-----------
    welcomeMessage BYTE "+-----Welcome to PREMIER ATM SYSTEM!-----+", 0  
    exitMessage BYTE "+-----Thanks for using PREMIER ATM SYSTEM, have a nice day!-----+", 0

    ;-----------Variable for GetCardNum------------
    promptCard1 BYTE "Enter first 8-digit credit card number: ", 0
    promptCard2 BYTE "Enter second 8-digit credit card number: ", 0
    userCardInput1 DWORD ?
    userCardInput2 DWORD ?
    validCardInput1 DWORD 11112222
    validCardInput2 DWORD 33334444
    validCCMessage BYTE ">>> Valid Credit Card!", 0
    invalidCCMessage BYTE ">>> Invalid Credit Card!", 0

    ;-----------Variable for GetPinNum------------
    promptPin BYTE "Enter your PIN Number: ", 0
    userPinInput DWORD ?
    validPinInput DWORD 718111
    validPinMessage BYTE ">>> Valid PIN Number!", 0
    invalidPinMessage BYTE ">>> Invalid PIN Number!", 0

    ;------------Main Menu-------------
    mainMenuOptions BYTE ">>> Access Granted! Please enjoy using our system!", 0Dh, 0Ah
                    BYTE "+---------Main Menu---------+", 0Dh, 0Ah
                    BYTE "1. Deposit", 0Dh, 0Ah                     ;0Dh means carriage return
                    BYTE "2. Withdraw", 0Dh, 0Ah                   ;0Ah means linefeed
                    BYTE "3. Check Balance", 0Dh, 0Ah  
                    BYTE "4. Currency Conversion", 0Dh, 0Ah
                    BYTE "5. Future Value Calculation", 0Dh, 0Ah
                    BYTE "6. Rewards Points", 0Dh, 0Ah
                    BYTE "7. Exit", 0Dh, 0Ah, 0                   ;0 means null terminator, marking the end of the string 

    ;------------Handle Main Menu Choice----------
    mainMenuMessage BYTE "Enter your choice(1-7): ", 0
    mainMenuChoice DWORD ?

    ;-------------Withdrawal---------------
    withdrawTitle BYTE "+---------Money Withdrawal---------+", 0
    promptWithdrawalAmount BYTE "Enter withdrawal amount: ", 0
    notSufficientBalance BYTE ">>> Insufficient balance amount! Please Enter again", 0

    ;--------Future Value Calculation------
    promptDeposit     BYTE "Enter yearly regular deposit (RM): ", 0
    promptRate        BYTE "Enter annual interest rate (%) [1% / 2% ...] : ", 0
    promptYears       BYTE "Enter number of years: ", 0
    resultMsg         BYTE "Future Value: RM ", 0
    overflowMessage   BYTE "Overflow Error! Result too large.", 0

    deposit           DWORD ?         ; Yearly deposit (P)
    interestRate      DWORD ?         ; Interest rate (as a whole number, e.g., 5 for 5%)
    years             DWORD ?         ; Number of years (n)
    futureValue       DWORD 0         ; Final accumulated amount (FV) in sen
    oneHundred        DWORD 100       ; Scaling factor for percentage calculations
    oneThousand       DWORD 1000      ; More precise scaling factor for division

    ;------------Reward Points--------------
    rewardPoints DWORD 0    ;Example of initial reward points
    rewardPointsMessage BYTE "Reward Points: ", 0

    ;-------------Error Message-------------
    errorMessage BYTE ">>> Invalid option, Please try again!", 0

    ;-------------Balance-------------
    checkBalanceTitle BYTE "+---------Check Balance---------+", 0
    balanceMessage BYTE ">>> Your current account balance are: RM", 0
    balance DWORD 12345678 

    ;-------------Continue?-------------
    continueMessage BYTE "Do you want to continue(y/n)?: ", 0
    continueOption BYTE ?

    ;-------------Print Receipt?-------------
    printRequestMessage BYTE "Do you want to print receipt(y/n)?: ", 0
    printOption BYTE ?

    ;-------------Reperform Any Function?-------------
    redoMessage BYTE "Do you want to perform any other functions(y/n)?: ", 0
    redoOption BYTE ?
    
    

.CODE

;----------Functions Prototype----------

PrintWelcome PROTO
GetCCNum PROTO
GetPinNum PROTO
CheckBalance PROTO
ContinueRequest PROTO
PrintReceiptOption PROTO
FutureValueCalculator PROTO
DepositMoney PROTO  ; New function for deposit
DisplayMainMenu PROTO
RePerformFunction PROTO
QuitProgram PROTO

;----------Main----------

MAIN PROC
    call PrintWelcome
    call GetCardNum
    call GetPinNum
    call DisplayMainMenu

    EXIT         
MAIN ENDP



;----------Functions----------

;----------Print Welcome Message----------
PrintWelcome PROC
    mov edx, OFFSET welcomeMessage  ; Load address of welcome message into EDX
    call WriteString                ; Print the message
    call Crlf
    call Crlf
    ret
PrintWelcome ENDP

;----------Get Credit Card Number----------
GetCardNum PROC
    mov edx, OFFSET promptCard1
    call WriteString

    call ReadInt                    ; Read credit card number
    mov userCardInput1, eax          ; Store credit card number from eax to variable

    mov edx, OFFSET promptCard2
    call WriteString

    call readInt
    mov userCardInput2, eax

    mov eax, userCardInput1
    mov ebx, validCardInput1

    cmp eax, ebx         ; Compare user credit card number with valid credit card number
    jne InvalidCard                    ; Jump to 'isValidCC' label if equal

    
    mov eax, userCardInput2
    mov ebx, validCardInput2

    cmp eax, ebx 
    jne InvalidCard

    mov edx, OFFSET validCCMessage
    call writeString
    call Crlf
    call Crlf
    ret
                
InvalidCard: 
    mov edx, OFFSET invalidCCMessage
    call writeString
    call Crlf
    call Crlf
    jmp GetCardNum  ; Loop again if credit card number entered is invalid
    
GetCardNum ENDP

;----------Get Credit Card Pin Number----------
GetPinNum PROC
    mov edx, OFFSET promptPin
    call WriteString

    call ReadInt
    mov userPinInput, eax

    cmp eax, validPinInput
    je isValidPin                   ;jump to 'isValidPin' label if equal

    mov edx, OFFSET invalidPinMessage
    call writeString
    call Crlf
    call Crlf
    jmp getPinNum

isValidPin: 
    mov edx, OFFSET validPinMessage
    call writeString
    call Crlf
    call Crlf
    ret
GetPinNum ENDP

;----------Display Main Menu-----------
DisplayMainMenu PROC
    call Clrscr
    mov edx, OFFSET mainMenuOptions
    call writeString
    call HandleMainMenu
    ret
DisplayMainMenu ENDP

HandleMainMenu PROC
    mov edx, OFFSET mainMenuMessage
    call writeString

    call readInt
    mov mainMenuChoice, eax

    cmp mainMenuChoice,1 
    ;je DepositMoney

    cmp mainMenuChoice, 2 
    je withdrawMoney
    
    cmp mainMenuChoice, 3
    je CheckBalance

    cmp mainMenuChoice, 4
    ;je currencyConversion

    cmp mainMenuChoice, 5
    je FutureValueCalculator

    cmp mainMenuChoice, 6
    ;je Rewards Points

    cmp mainMenuChoice, 7
    je QuitProgram
    mov edx, OFFSET errorMessage
    call WriteString
    call Crlf
    call Crlf
    jg HandleMainMenu

    cmp eax, 0
    mov edx, OFFSET errorMessage
    call WriteString
    call Crlf
    call Crlf
    jle HandleMainMenu


    call Crlf
    call Crlf

    ret
HandleMainMenu ENDP

;----------Deposit----------

;----------Withdraw----------
WithdrawMoney PROC
    call Clrscr

    mov edx, OFFSET withdrawTitle
    call WriteString

    call Crlf

    call CheckBalance

    call Crlf

CheckAndWithdraw:

    ; Prompt user for withdrawal amount
    mov edx, OFFSET promptWithdrawalAmount
    call WriteString

    ; Read the withdrawal amount (in RM)
    call ReadInt
    mov ebx, eax           ; Store withdrawal amount in EBX

    ; Convert balance from cents to RM for comparison
    mov eax, balance
    mov ecx, 100
    xor edx, edx
    div ecx                ; EAX = balance in RM

    ; Check if withdrawal exceeds balance
    cmp ebx, eax
    jg InsufficientFunds   ; If withdrawal > balance, jump to error message

    ; Subtract withdrawal from balance
    sub eax, ebx

    ; Convert updated balance back to cents
    mov ecx, 100
    mul ecx
    mov balance, eax

    ; Display updated balance
    mov edx, OFFSET balanceMessage
    call WriteString

   ; Convert updated balance to RM for display
    mov eax, balance
    mov ecx, 100
    xor edx, edx
    div ecx

    ; Print integer part (RM)
    call WriteDec

    ; Print decimal point and cents
    mov al, '.'
    call WriteChar
    mov eax, edx
    cmp eax, 9
    jg printCents
    mov al, '0'
    call WriteChar

printCents:
    call WriteDec
    call Crlf

    call ContinueRequest

    ; Handle 'Y' or 'y'
    mov al, byte ptr [continueOption] ; Load continueOption into AL
    or al, 32                          ; Convert 'Y' to 'y' (if uppercase)
    cmp al, 'y'
    je CheckAndWithdraw                 ; If 'y' (or 'Y'), go to CheckAndWithdraw

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je PrintReceiptRequest              ; If 'n' (or 'N'), go to PrintReceiptRequest

PrintReceiptRequest:
    call PrintReceiptOption
    
    ; Handle 'N' or 'n' for skipping receipt
    mov al, byte ptr [PrintReceiptOption] ; Load PrintReceiptOption into AL
    or al, 32
    cmp al, 'n'
    je ChooseAnotherFunction

ChooseAnotherFunction:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

InsufficientFunds:
    mov edx, OFFSET notSufficientBalance
    call WriteString
    call Crlf
    call Crlf
    jmp CheckAndWithdraw

WithdrawMoney ENDP

;----------Check Balance----------
CheckBalance PROC

    call ClrScr

    mov edx, OFFSET checkBalanceTitle
    call writeString

    call Crlf

    mov edx, OFFSET balanceMessage
    call writeString
        ; Print integer part (balance / 100)

    mov eax, balance
    mov ebx, 100
    xor edx, edx       ; Clear edx for division
    div ebx            ; EAX = balance / 100, EDX = balance % 100

    call WriteDec      ; Print whole number (RM part)

    ; Print decimal point
    mov al, '.'
    call WriteChar

    ; Print the decimal part (EDX contains cents)
    mov eax, edx
    cmp eax, 9         ; Ensure two-digit display (e.g., 05 instead of 5)
    jg printCents
    mov al, '0'        ; Print leading zero for values < 10
    call WriteChar

printCents:
    call WriteDec      ; Print cents

    call Crlf

    cmp mainMenuChoice, 3
    jne ExitCheckBalance

RequestReperform:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

ExitCheckBalance:
    ret
CheckBalance ENDP

;----------Currency Conversion----------

;----------Future Value Calculation----------
FutureValueCalculator PROC
    ; Get Deposit Amount (in RM)
    mov edx, OFFSET promptDeposit
    call WriteString
    call ReadInt        ; Integer because deposit money is only 
    mov deposit, eax    ; Store deposit (in RM)

    ; Get Interest Rate (as a whole number percentage)
    mov edx, OFFSET promptRate
    call WriteString
    call ReadInt
    mov interestRate, eax    ; Store interest rate

    ; Get Number of Years
    mov edx, OFFSET promptYears
    call WriteString
    call ReadInt
    mov years, eax    ; Store number of years

    ; Convert deposit to sen (1 RM = 100 sen)
    mov eax, deposit
    imul eax, oneHundred    ; Convert deposit to sen --> Signed Multiplication (Avoid Overflow)
    mov deposit, eax        ; Store the deposit in sen

    ; Initialize Future Value in sen (starting with 0)
    mov futureValue, 0

    ; Loop to compute FV using corrected compound interest formula
    mov ecx, years    ; Set the loop counter to the number of years

first_year:
    ; First Year - Only add deposit (No Interest Applied)
    mov eax, deposit
    add futureValue, eax
    loop after_first_year  ; Skip interest calculation for the first year --> The loop instruction decrements ecx by 1.

after_first_year: ; No interest calculation at here

calc_loop:
    cmp ecx, 0
    je display_result ; Exit loop if years == 0

    ; Step 1: Apply interest BEFORE adding deposit
    mov eax, futureValue
    mov edx, 0            
    imul eax, interestRate    ; Multiply FV by interestRate
    mov edx, 0               
    idiv oneHundred          ; Divide by 100 for proper scaling --> Signed Division (Avoid Overflow)

    ; Step 2: Add computed interest to FV
    add futureValue, eax

    ; Step 3: Add deposit (new yearly deposit in sen)
    mov eax, deposit
    add futureValue, eax

    ; Check for overflow before continuing
    jnc continueLoop    ;jump if no carry
    mov edx, OFFSET overflowMessage
    call WriteString
    jmp endProgram

continueLoop:
    loop calc_loop    ; Decrement the year counter and repeat the loop

display_result:
    ; --- Display Future Value in RM and Sen ---
    call Crlf
    mov edx, OFFSET resultMsg
    call WriteString

    ; Convert future value from sen to RM and sen
    mov eax, futureValue
    mov edx, 0
    div oneHundred    ; EAX = RM, EDX = sen

    ; Display RM part
    call WriteDec
    mov al, '.'    ; Print decimal point
    call WriteChar

    ; Display Sen part (ensure two digits)
    mov eax, edx    ; Move sen to EAX (remainder store in edx)
    cmp eax, 10    ; If less than 10, add leading zero) (5sen become .05)
    jae print_sen   ;(>= 10, proceed to print_sen)
    mov al, '0'     ; add trailing zero
    call WriteChar

print_sen:
    call WriteDec
    call Crlf

endProgram:
    exit

FutureValueCalculator ENDP

;----------Reward Points----------

QuitProgram PROC
    call ClrScr
    mov edx, OFFSET exitMessage
    call WriteString
    call Crlf
    call Crlf
    call ExitProcess
    ret
QuitProgram ENDP

;----------Redo Process----------
ContinueRequest PROC
    call Crlf
    mov edx, OFFSET continueMessage
    call writeString

    call readChar
    mov continueOption, al

    call writeChar
    call Crlf
    call Crlf

    ret
ContinueRequest ENDP

PrintReceiptOption PROC
    mov edx, OFFSET printRequestMessage
    call writeString

    call readChar
    mov printOption, al

    call writeChar
    call Crlf

    ret
PrintReceiptOption ENDP

PrintReceipt PROC
    
PrintReceipt ENDP

RePerformFunction PROC
    call Crlf
    mov edx, OFFSET redoMessage
    call writeString

    call readChar
    mov redoOption, al

    call writeChar
    call Crlf
    call Crlf

    ret
RePerformFunction ENDP

END MAIN

