################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
Clock.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/Clock.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Clock.d_raw" -MT"Clock.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

FIFO.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/FIFO.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"FIFO.d_raw" -MT"FIFO.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

LaunchPad.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/LaunchPad.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"LaunchPad.d_raw" -MT"LaunchPad.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

UART.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/UART.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"UART.d_raw" -MT"UART.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

UARTints.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/UARTints.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"UARTints.d_raw" -MT"UARTints.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

%.o: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/UART_ints/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


