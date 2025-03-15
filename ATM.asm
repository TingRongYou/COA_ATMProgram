INCLUDE Irvine32.inc

.DATA
    message BYTE "Hello, World!", 0  ; Define the string

.CODE
MAIN PROC
    mov edx, OFFSET message  ; Load address of message into EDX
    call WriteString         ; Print the message

    call ExitProcess         ; Exit the program
MAIN ENDP
END MAIN
