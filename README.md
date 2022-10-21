
# Учебно-методическое пособие по дисциплине «Вычислительные системы и компьютерные сети»
 - Данная методичка предназначена для студентов, использующих ОС Linux/MacOS
 - Не является исчерпывающим руководством по языку Assembler и архитектуре ВС
 - Цель методички - дать представление об ассемблере и том как он взаимодействует с компьютером
 - Предполагается, что на Unix-подобных ОС, вы пишите на nasm и дебажите в gdb
## Теоретические сведения
Самый низкий уровень программирования – машинный язык (последовательность двоичных кодов машинных команд и операндов). Писать программы с операторами в виде двоичных чисел очень сложно, поэтому во всех машинах предусмотрен язык [ассемблера](https://ru.wikipedia.org/wiki/%D0%90%D1%81%D1%81%D0%B5%D0%BC%D0%B1%D0%BB%D0%B5%D1%80) – символическое представление набора команд, в котором двоичные числа заменены именами команд (мнемониками, наподобие ADD, SUB и MUL) и именами операндов (символьным обозначением ячеек памяти – VAR, string1, регистров – AX, DL, адресов – меток). 
### Полезные статьи по теме
 - [Про разные виды ассемблеров](https://habr.com/ru/post/326078/)
 - [Почему ассемблер это круто, Яндекс, журнал Код](https://thecode.media/assembler/)
 - [Сборник ресурсов для желающих учить asm](https://habr.com/ru/post/131971/)
 - [Туториал, с которого частично списана методичка](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
 
## Переходим к коду
Для того чтобы писать на ассемблере вам нужно установить:
*Если здесь нет вашей ОС, то контрибьютните в инструкцию, облегчите жизнь студентов*
 - компилятор для nasm 
	 - MacOS - `brew install nasm`
	 - Debian\Ubuntu\Mint - `sudo apt install nasm`
	 - Arch - `sudo pacman -S nasm`
 - дебаггер
	 - MacOS M1 - придётся взять [lldb](https://lldb.llvm.org) `brew install lldb`
	 - MacOs - `brew install gdb`
	 - Debian\Ubuntu\Mint - `sudo apt install gdb`
	 - Arch - `sudo pacman -S gdb'
 - objdump - посмотреть машинный код полученного бинаря
	 - MacOS `brew install objdump` - если у вас его уже нет
	 - Debian\Ubuntu\Mint - `sudo apt install objdump`
	 - Arch - `sudo pacman -S objdump`
 - линкер - скорее всего у вас есть `ld`, если вдруг нет, то установите через пакетный менеджер

### Как написать Hello world
#### MacOS
```
; ----------------------------------------------------------------------------------------.
; 	Запуск: nasm -fmacho64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

global    start

section   .text
start:    
mov       rax, 0x02000004         ; Системный вызов write
mov       rdi, 1                  ; Файловый дескриптор для stdout
mov       rsi, message            ; Адрес в котором лежит буфер для системного вызова
mov       rdx, 13                 ; Размер буфера в байтах
syscall                           ; Вызываем write
mov       rax, 0x02000001         ; Системный вызов exit
xor       rdi, rdi                ; Очищаем регистр в котором находятся аргументы для вызова
syscall                           ; Вызываем exit

section   .data
message:  db        "Hello, World", 10      ; 10 - код символа перевода строки
```
#### Linux
```
; ----------------------------------------------------------------------------------------.
; 	Запуск: nasm -felf64 hello.asm && ld hello.o && ./a.out 
; ----------------------------------------------------------------------------------------

            global    _start

            section  .text
_start:
            mov       eax, 4                  ; Системный вызов write
            mov       ebx, 1                  ; Файловый дескриптор для stdout

            mov       ecx, message            ; Адрес в котором лежит буфер для системного вызова
            mov       edx, 13                 ; Размер буфера в байтах
            int       80h                     ; Вызываем write

            mov       eax, 1                  ; Системный вызов exit
            mov       ebx, 0                  ; Вызываем exit
            int       80h

            section   .data
message:
            db        "Hello, World", 10      ; 10 - код символа перевода строки
```
Для использования определенных вызовов к ядру вы можете проконсультироваться с таблицей системных вызовов (достаточно поискать в интернете syscall table с названием вашей архитектуры и операционной системы). [Пример для x86_64](https://filippo.io/linux-syscall-table/)

 - Данная методичка предназначена для студентов, использующих ОС Linux/MacOS
 - Не является исчерпывающим руководством по языку Assembler и архитектуре ВС
 - Цель методички - дать представление об ассемблере и том как он взаимодействует с компьютером
 - Предполагается, что на Unix-подобных ОС, вы пишите на nasm и дебажите в gdb
 

## Про лабораторную работу #1
Задания смотреть в [оригинальной методичке](https://edu.hse.ru/tokenpluginfile.php/d46a0fce075011d33baeda8b86bbe23a/1927704/mod_resource/content/2/ПР1.pdf?forcedownload=1), в ней же можно посмотреть теорию немного глубже, чем описано здесь.
#### Для того чтобы выполнить работу #1 вам нужно
- Настроить окружение как сказано выше
	- Скопируйте пример с "Hello world" и попробуйте скомпилировать и запустить
- Знать как объявить переменные в ОП
	- Не забываем, для корректного выполнения операций смотрите на размер переменной и размер регистра в который вы хотите её поместить, иначе вас сильно удивит результат
- Знать как выполнить над ними несколько простых операций
	- логических
	- арифметических
- Знать как работают условия в ассемблере
- Уметь отдебажить свою программу
	- Пронаблюдать как меняются значения в регистрах
	- Привыкнуть к консольному дебаггингу, любителям Си он точно пригодиться

### Как объявляются переменные:
- [Официальная документация NASM](https://www.nasm.us/xdoc/2.15.05/html/nasmdoc3.html)

При объявлении переменной мы сначала указываем название, затем её размер, а затем значение.

`myVariable db 5` - переменная с названием myVariable, размером 1 байт, со значением 5

Вот 4 основных `dX` псевдо-инструкции для того чтобы объявить переменную
```
db 		- Define Byte 			- 1 байт
dw 		- Define Word 			- 2 байта
dq 		- Define Doubleword 		- 4 байта
dt 		- Define Quadword 		- 8 байт
``` 
Можно объявить что-то побольше, но вам это не **нужно** , да и **в лабораторных работах не понадобится**

Как можно объявлять различные типы данных:
```
; Названия убрал, смотрите на формат и комментарии
db    0x55                ; В переменной лежит байт со значением 0x55 
db    0x55,0x56,0x57      ; А можно положить сразу 3 байта 
db    'a',0x55            ; Можно символы, они будут переведены в коды ASCII 
db    'hello',13,10,'$'   ; Можно даже строчки
dw    0x1234              ; Другой способ записать 0x34 0x12 
dw    'a'                 ; 0x61 - код символа ASCII в 16-ной системе 
dw    'ab'                ; 0x61 0x62 - 2 кода символа
dw    'abc'               ; 0x61 0x62 0x63 0x00 - А вот так будет выглядеть строка
dd    1.234567e20         ; А можно число с плавающей точкой
dq    0x123456789abcdef0  ; Восьмибайтовая переменная 
dq    1.234567e20         ; double-precision число с плавающей точкой 
dt    1.234567e20         ; extended-precision число с плавающей точкой
```
- **Ассемблер это не статически типизированный язык программирования!  У вас нет типов переменных и инструкции будут интерпретировать их так как им захочется!**
- Когда вы собираетесь помещать переменную в регистр - проверьте, что она достаточного размера, вот вам красивая картинка
![Вот так выглядят регистры](https://cs.lmu.edu/~ray/images/rdx.png)

- Не путайте целочисленные регистры и регистры для чисел с плавающей точкой, до лабораторной работы #3 вы не должны столкнуться с ними
- Инструкции, работающие напрямую с переменными крайне редки, обычно переменные перемещают в соответствующие регистры, а затем выполняют с ними какие-то действия
### Про инструкции:
Инструкции зависят от вашего процессора и конкретного ассемблера (GNU, NASM, FASM и тд). Однако есть одинаковые с которыми нам и предстоит работать. Если вы при выполнении столкнулись с чем-то **уникальным для вашей машины**, то это достаточно странно, скорее всего **задачу можно выполнить проще**.
 
#### Вот этих инструкций вам с 99% вероятностью хватит для первой лабораторной:
```
Операции с памятью
mov 	x, y		; Перемещает содержимое y в x, фактически x = y
lea 	x, y		; mov для MacOS, подробнее лучше погуглить

Логические
and 	x, y		; Записывает в x побитовое x & y
or 		x, y		; Записывает в x побитовое x | y
xor 	x, y		; Записывает в x XOR(x, y)

Арифметические
add 	x, y		; Записывает в x sum(x, y)
sub 	x, y		; Записывает в x <- x - y
inc 	x			; Увеличивает x на 1 == x++
dec 	x			; Уменьшает x на 1 == x--

Особые
syscall n			; Совершает системный вызов n
jmp		label		; Совершает прыжок на метку label
```
#### Как работают условия и ветвление в ассемблере:
Нам часто необходимо ветвление в программе. Во всех высокоуровневых языках есть конструкция `if-else`. Но вот в ассемблере всё хитрее.

Существуют особые "флаговые" регистры, вот расширеный [туториал](https://www.tutorialspoint.com/assembly_programming/assembly_conditions.htm). На практике для того чтобы осуществить ветвление в ассемблере существуют метки и прыжки.

Метки - отметки в коде, позволяющие с помощью инструкции `jmp` перемещаться по ним, таким образом создавая ветвление или циклы.
```
.loop: ; Метка с названием ".loop"
       jmp .loop ; Прыжок на эту метку, фактически бесконечный цикл
```

Прыжки - вид инструкций, позволяющий управлять ходом исполнения программы. Можно разделить их на:
- Conditional - прыжки с условием - используются для ветвления программы
- Unconditional - безусловные - используются для того чтобы изменить ход выполнения безусловно

Unconditional jump - он же `jmp` позволяет нам сделать что-то вроде выхода из программы, который мы разместили под отдельной меткой
```
// Ещё какой-то код
jmp .exit ;  Закончили программу и завершаем её, не дойдя до второго jmp

// Много какого-то кода, до которого программа может не дойти
jmp .exit ;  Закончили программу и завершаем её

.exit
mov rdi, 0
syscall 
```

Conditional jump - особый вид `jmp`, который смотрит на флаговые регистры

```
Инструкция 	- Смысл 				- Флаговые регистры, на которые она смотрит
JE/JZ 		- a == b || a - b == 0 	- ZF
JNE/JNZ 	- a != b || a - b != 0 	- ZF
JG/JNLE 	- a > b					- OF, SF, ZF
JGE/JNL 	- a >= b				- OF, SF
JL/JNGE 	- a < b 				- OF, SF
JLE/JNG 	- a <= b 				- OF, SF, ZF
```

### Как дебажить свою программу
Для того чтобы отдебажить что-то на Ассемблере вам понадобится среда для разработки с дебаггером или консольный деббагер, как сказано выше. Также чтобы посмотреть бинарное представление исполняемого файла проще всего воспользоваться `objdump`.

Как пользоваться дебаггером: 
- [быстрый гайд](https://www.tutorialspoint.com/gnu_debugger/gdb_quick_guide.htm)
- [чуть более полный гайд](https://condor.depaul.edu/glancast/373class/docs/gdb.html)
- [более полный и сложный гайд](https://developers.redhat.com/blog/2021/04/30/the-gdb-developers-gnu-debugger-tutorial-part-1-getting-started-with-the-debugger)

А если ещё проще?
1. Соберите программу с отладочной информацией, в большинстве компиляторов флаг `-g`, на MacM1 всё немного сложнее, поэтому вот пример сборки из мейкфайла:

	```
	run: task_exec
		./task_exec
	task_exec: task.o
		ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o task_exec task.o
	task.o:
		nasm -f macho64 -g -F DWARF task.asm
	clean:
		rm task.o task_exec
	```
	Где  `-g -F DWARF` - указание, что нужно добавить отладочную информацию и её формат - [DWARF](https://dwarfstd.org).
2. Вам нужно запустить дебаггер в интерактивном режиме с указанием вашего исполняемого файла:
 `gdb exec.out`  - x86
 `lldb task_exec` - M1
Далее нужно поставить `breakpoin`, то есть точку остановки программы, на которой мы будем смотреть на значения регистров, стэк вызовов и так далее. 
Сделать это можно командой `b`, можно делать вот так
	```
	b // поставить точку остановки на текущей линии
	b main // остановить на входе в программу
	b task.asm:10 // остановить на 10 линии
	b fn // поставить точку остановки на функции(метке) fn
	```
3.  С помощью команд дебаггера можно посмотреть кучу всего, но вот пачка полезных для лабораторных работ комманд
	#### Управление поведением
	```
	(gdb) r // бежать до следующей точки остановки
	(gdb) s // step into == исполнить или зайти внутрь
	(gdb) n // step over == просто исполнить
	(gdb) finish
	```
	#### Информация о памяти
	```
	(gdb) info registers // все кроме векторных и с плавающей точкой
	(gdb) info all-registers // вообще все регистры
	(gdb) info registers {reg_name} // по имени регистра
	```

