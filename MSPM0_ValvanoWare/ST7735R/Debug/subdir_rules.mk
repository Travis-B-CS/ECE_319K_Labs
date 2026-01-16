################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
Arabic.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/Arabic.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Arabic.d_raw" -MT"Arabic.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

Clock.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/Clock.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Clock.d_raw" -MT"Clock.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

LaunchPad.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/LaunchPad.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"LaunchPad.d_raw" -MT"LaunchPad.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

SPI.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/SPI.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"SPI.d_raw" -MT"SPI.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

ST7735.o: C:/Users/4trav/OneDrive/Documents/University\ of\ Texas\ at\ Austin/ECE\ 319K/MSPM0_ValvanoWare/inc/ST7735.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"ST7735.d_raw" -MT"ST7735.o" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

%.o: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccs2000/ccs/tools/compiler/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug" -I"C:/ti/mspm0_sdk_2_03_00_07/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_2_03_00_07/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)" -I"C:/Users/4trav/OneDrive/Documents/University of Texas at Austin/ECE 319K/MSPM0_ValvanoWare/ST7735R/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


