;--------------- DECLARACION DE MACROS ---------
;=== Macro - Imprimir cadena ===
M_PRINT macro buffer
    mov ax,@data        ;Registro acumulador con la dirección de dato
    mov ds,ax           ;Apuntar al segmento de dato - donde esta la cadena
    mov ah,09h          ;F - Visualización de cadena
    mov dx,offset buffer;Desplazamiento de la cadena dentro de segmento
    int 21h             ;Ejecutar instrucción 09h
    ;Mostrar cadena de texto en consola
endm
;=== Fin Macro ===

;=== Macro - Imprimir cadena ===
M_PRINT_ASCII macro buffer
    mov ah, 0           ;Limpiar registro AH
    mov ah, 06h
    mov dl, buffer
    int 21h
endm
;=== Fin Macro ===

;=== Macro - Menu ===
M_MENU macro buffer
    mov ax,@data        ;Registro acumulador con la dirección de dato
    mov ds,ax           ;Apuntar al segmento de dato - donde esta la cadena
    mov ah,09h          ;F - Visualización de cadena
    mov dx,offset buffer;Desplazamiento de la cadena dentro de segmento
    int 21h             ;Ejecutar instrucción 09h
    ;Mostrar cadena de texto en consola
    mov ah, 01h		    ;funcion 8, esperaque el usuario presione una tecla, sin echo
	int 21h
    ;La tecla se guarda en el registro AL
endm
;=== Fin Macro ===

;=== Macro - Limpiar tablero ===
M_limpiar_tablero macro vector

    mov vector[40], 45
    mov vector[42], 45
    mov vector[44], 45
    mov vector[46], 45
    mov vector[48], 45
    mov vector[50], 45
    mov vector[52], 45
    mov vector[54], 45

    mov vector[59], 45
    mov vector[61], 45
    mov vector[63], 45
    mov vector[65], 45
    mov vector[67], 45
    mov vector[69], 45
    mov vector[71], 45
    mov vector[73], 45

    mov vector[78], 45
    mov vector[80], 45
    mov vector[82], 45
    mov vector[84], 45
    mov vector[86], 45
    mov vector[88], 45
    mov vector[90], 45
    mov vector[92], 45

    mov vector[97], 45
    mov vector[99], 45
    mov vector[101], 45
    mov vector[103], 45
    mov vector[105], 45
    mov vector[107], 45
    mov vector[109], 45
    mov vector[111], 45

    mov vector[116], 45
    mov vector[118], 45
    mov vector[120], 45
    mov vector[122], 45
    mov vector[124], 45
    mov vector[126], 45
    mov vector[128], 45
    mov vector[130], 45

    mov vector[135], 45
    mov vector[137], 45
    mov vector[139], 45
    mov vector[141], 45
    mov vector[143], 45
    mov vector[145], 45
    mov vector[147], 45
    mov vector[149], 45

    mov vector[154], 45
    mov vector[156], 45
    mov vector[158], 45
    mov vector[160], 45
    mov vector[162], 45
    mov vector[164], 45
    mov vector[166], 45
    mov vector[168], 45

    mov vector[173], 45
    mov vector[175], 45
    mov vector[177], 45
    mov vector[179], 45
    mov vector[181], 45
    mov vector[183], 45
    mov vector[185], 45
    mov vector[187], 45
endm
;=== Fin Macro ===

;=== Macro - Inicio tablero ===
M_init_juego macro vector
    mov vector[0], 35   ;#
    mov vector[1], 124  ;|
    mov vector[2], 65   ;A
    mov vector[4], 66   ;B
    mov vector[6], 67   ;C
    mov vector[8], 68   ;D
    mov vector[10], 69  ;E
    mov vector[12], 70  ;F
    mov vector[14], 71  ;G
    mov vector[16], 72  ;H

    mov vector[20], 43  ;+ 

    mov vector[38], 49  ;1
    mov vector[39], 124 ;|

    mov vector[57], 50  ;2
    mov vector[58], 124 ;|

    mov vector[76], 51  ;3
    mov vector[77], 124 ;|

    mov vector[95], 52  ;4
    mov vector[96], 124 ;|

    mov vector[114], 53  ;5
    mov vector[115], 124 ;|

    mov vector[133], 54  ;6
    mov vector[134], 124 ;|

    mov vector[152], 55  ;7
    mov vector[153], 124 ;|

    mov vector[171], 56  ;8
    mov vector[172], 124 ;|
endm
;=== Fin Macro ===

;=== Macro - Leer cadena ===
M_READ macro buffer
    local et_inicio_ciclo, et_salir_ciclo
    mov dx, offset buffer   ;Obtener posicíon del vector
	mov bp, dx              ;Inicializar indice en la posición del vector
	et_inicio_ciclo: 
		mov ah, 01h         ;Instrucción para leer un caracter
		int 21h

		cmp al, 13          ;Comparamos si hay retorno de carro CR
		je et_salir_ciclo   ;Si flag Zero está activa saltar

		mov ds:[bp], al     ;Guardar caracter en el vector
		inc bp              ;Aumentar indice

		loop et_inicio_ciclo
	et_salir_ciclo:

endm
;=== Fin Macro ===

;=== Macro - Comparar comando ===
M_COMPARAR_COMANDO macro buffer
    local et_salir, et_c_pass1, et_c_e, et_c_s, et_c_a, et_c_b, et_c_c, et_c_d, et_c_f, et_c_g, et_c_h, et_c_e2, et_c_num, et_n2, et_n3, et_n4, et_n5, et_n6, et_n7, et_n8, et_error, et_c_s1, et_c_s2
    ;Usar registro CL para almacenar la instrucción
    ;buffer[5]
    mov cl, 190           ;Registro CL = 0 - No hay comando correcto
    ;Comparamos buffer[0]
    mov al,buffer[0]

    cmp al, 112         ;Comparar p = 112
    je et_c_pass1
    cmp al, 101         ;Comparar e = 101
    je et_c_e
    cmp al, 115         ;Comparar s = 115
    je et_c_s 

    cmp al, 97          ;Comparar a = 97
    je et_c_a
    cmp al, 98          ;Comparar b = 98
    je et_c_b
    cmp al, 99          ;Comparar c = 99
    je et_c_c
    cmp al, 100         ;Comparar d = 100
    je et_c_d
    cmp al, 102         ;Comparar f = 102
    je et_c_f
    cmp al, 103         ;Comparar g = 103
    je et_c_g
    cmp al, 104         ;Comparar h = 104
    je et_c_h
    jne et_error

    et_c_pass1:
    ;Verificamos comando PASS
    mov al, buffer[1]
    cmp al, 97          ;Comparar a = 97
    jne et_error
    mov al, buffer[2]
    cmp al, 115         ;Comparar s = 115
    jne et_error
    mov al, buffer[3] 
    cmp al, 115         ;Comparar s = 115
    jne et_error
    mov cl, 33           ;Registro CL = 33 - comando pass
    jmp et_salir

    et_c_e:
    ;Verificamos comando EXIT & Coordenada Ex
    mov al, buffer[1]
    cmp al, 120         ;Comparar x = 120
    jne et_c_e2
    mov al, buffer[2]
    cmp al, 105         ;Comparar i =105
    jne et_error
    mov al, buffer[3]
    cmp al, 116         ;Comparar t = 116
    jne et_error
    mov cl, 34          ;Registro CL = 34 - comando exit
    jmp et_salir

    et_c_s:
    ;Verificar comando SAVE & SHOW
    mov al, buffer[1]
    cmp al, 97          ;Comparar a = 97
    je et_c_s1
    cmp al, 104         ;Comparar h = 104
    je et_c_s2
    jne et_error

    et_c_s1:
    ;Comando SAVE
    mov al, buffer[2]
    cmp al, 118         ;Comparar v = 118
    jne et_error
    mov al, buffer[3]
    cmp al, 101         ;Comparar e = 101
    jne et_error
    mov cl, 35          ;Registro CL = 35 - comando save
    jmp et_salir

    et_c_s2:
    ;Comando SHOW
    mov al, buffer[2]
    cmp al, 111         ;Comparar o = 111
    jne et_error
    mov al, buffer[3]
    cmp al, 119         ;Comparar w = 119
    jne et_error
    mov cl, 36          ;Registro CL = 36 - comando show
    jmp et_salir

    et_c_a:
    ;Comprobar Cordenada Ax        
    mov cl, 40          ;Guardar 40 en CL = A1
    jmp et_c_num

    et_c_b:
    ;Comprobar Cordenada Bx        
    mov cl, 42          ;Guardar 42 en CL = B1
    jmp et_c_num

    et_c_c:
    ;Comprobar Cordenada Cx        
    mov cl, 44          ;Guardar 44 en CL = C1
    jmp et_c_num

    et_c_d:
    ;Comprobar Cordenada Dx        
    mov cl, 46          ;Guardar 46 en CL = D1
    jmp et_c_num

    et_c_f:
    ;Comprobar Cordenada Fx        
    mov cl, 50          ;Guardar 50 en CL = F1
    jmp et_c_num

    et_c_g:
    ;Comprobar Cordenada Gx        
    mov cl, 52          ;Guardar 52 en CL = G1
    jmp et_c_num

    et_c_h:
    ;Comprobar Cordenada Hx        
    mov cl, 54          ;Guardar 54 en CL = H1
    jmp et_c_num
    
    et_c_e2:
    ;Comprobar Cordenada Ex        
    mov cl, 48          ;Guardar 48 en CL = E1
    jmp et_c_num

    et_c_num:
    ;Obtener número de coordenada
    mov al, buffer[1]
    cmp al, 49          ;Comparar 1 = 49
    je et_salir
    cmp al, 50          ;Comparar 2 = 50
    je et_n2
    cmp al, 51          ;Comparar 3 = 51
    je et_n3
    cmp al, 52          ;Comparar 4 = 52
    je et_n4
    cmp al, 53          ;Comparar 5 = 53
    je et_n5
    cmp al, 54          ;Comparar 6 = 54
    je et_n6
    cmp al, 55          ;Comparar 7 = 55
    je et_n7
    cmp al, 56          ;Comparar 8 = 56
    je et_n8
    jne et_error

    et_n2:
    ;Número 2 (Sumar 19 a cl)
    add cl, 19           
    jmp et_salir

    et_n3:
    ;Numero 3 (Sumar 38 a cl)
    add cl, 38
    jmp et_salir

    et_n4:
    ;Numero 4 (Sumar 57 a cl)
    add cl, 57
    jmp et_salir

    et_n5:
    ;Numero 5 (Sumar 76 a cl)
    add cl, 76
    jmp et_salir

    et_n6:
    ;Numero 6 (Sumar 95 a cl)
    add cl, 95
    jmp et_salir

    et_n7:
    ;Numero 7 (Sumar 114 a cl)
    add cl, 114
    jmp et_salir

    et_n8:
    ;Numero 8 (Sumar 133 a cl)
    add cl, 133
    jmp et_salir

    et_error:
    mov cl, 190

    et_salir:
   
endm
;=== Fin Macro ===

;=== Macro - Llenar tablero ===
M_Llenar_tablero macro buffer, coordenada, ficha
    local et_colocar_ficha, et_error_ficha, et_salir
    ;buffer es la matriz que contiene los datos del juego

    ;Ejecutar coordenada
    mov ax, 0
    mov cx, 0
	mov bh, 0			    ;Limpiar registro BH
	mov bl, coordenada[0]	;Asignar coordenada
    mov al, buffer[bx]      ;Obtenemos valor de la casilla
    cmp al, 45              ;Comparamos - = 45
    je et_colocar_ficha     ;Es igual - Esta disponible
    jne et_error_ficha      ;NO esta disponible

    et_colocar_ficha:
	    mov buffer[bx], ficha;Poner una N en coordenada
        jmp et_salir

    et_error_ficha:
        mov ch, 190         ;Mandar error por registro CH
    et_salir:
endm
;=== Fin Macro ===

;=== Macro - CrearHTML tablero ===
M_crearHTML macro tablero, vector

endm
;=== Fin Macro ===

;=== Macro - Obtener ruta
M_OBTENER_RUTA macro buffer
local et_obtener_char, et_salir
    xor si, si              ;Limpiar Registro SI 
    et_obtener_char:
        mov ah, 01h         ;Funcion de lectura
        int 21h

        cmp al,13           ;Comparamos CR = 13
        je et_salir
        mov buffer[si], al  ;Insertar caracter en vector
        inc si              ;SI + 1
        jmp et_obtener_char

    et_salir:
        mov al, 0           ;Insertar NULL = 0
        mov buffer[si], al  ;Insertar fin de lectura
endm
;=== Fin Macro ===


;=== Macro - Abrir archivo
M_ABRIR_ARCHIVO macro nombre, handle
    mov ah, 3dh             ;Funcion Abrir Archivo
    mov al, 02h             ;Modo de Escritura
    lea dx, nombre
    ;mov dx, offset nombre   ;Nombre del archivo a abrir
    int 21h
    jc et_error_abrir_archivo
    mov handle, ax

endm
;=== Fin Macro ===

;=== Macro - Cerrar archivo
M_CERRAR_ARCHIVO macro handle
    mov ah, 3eh
    mov bx, handle
    int 21h
    jc et_error_cerrar_archivo
endm
;=== Fin Macro ===

;=== Macro - Escribir archivo
M_ESCRIBIR_ARCHIVO macro buffer, handle, num
    mov ah, 40h
    mov bx, handle
    mov cx, num
    mov dx, offset buffer
    int 21h
endm
;=== Fin Macro ===

;=== Macro - Leer archivo
M_LEER_ARCHIVO macro handle, buffer, num
    mov ah, 3fh
    mov bx, handle
    mov cx, num
    mov dx, offset buffer
    int 21h
    jc et_error_leer_archivo
endm
;=== Fin Macro ===

;=== Macro - Crear archivo
M_CREAR_ARCHIVO macro nombre

    mov ah, 3ch
    mov cx, 00h
    mov dx, offset nombre
    int 21h
    jc et_error_crear_archivo
endm
;=== Fin Macro ===


;--------------- FIN DE MACROS -----------------

