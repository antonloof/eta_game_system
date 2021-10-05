EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR01
U 1 1 615E7A23
P 2500 2750
F 0 "#PWR01" H 2500 2500 50  0001 C CNN
F 1 "GND" H 2505 2577 50  0000 C CNN
F 2 "" H 2500 2750 50  0001 C CNN
F 3 "" H 2500 2750 50  0001 C CNN
	1    2500 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 3850 1950 4000
Wire Wire Line
	1950 4000 7300 4000
Wire Wire Line
	7300 4000 7300 2800
Wire Wire Line
	7300 2800 6650 2800
$Comp
L 74xx:74AHC04 U1
U 7 1 61613C48
P 9500 1500
F 0 "U1" H 9730 1546 50  0000 L CNN
F 1 "74AHC04" H 9730 1455 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 9500 1500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74AHC_AHCT04.pdf" H 9500 1500 50  0001 C CNN
	7    9500 1500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 616142B8
P 9500 2000
F 0 "#PWR010" H 9500 1750 50  0001 C CNN
F 1 "GND" H 9505 1827 50  0000 C CNN
F 2 "" H 9500 2000 50  0001 C CNN
F 3 "" H 9500 2000 50  0001 C CNN
	1    9500 2000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR09
U 1 1 616145FA
P 9500 1000
F 0 "#PWR09" H 9500 850 50  0001 C CNN
F 1 "+3V3" H 9515 1173 50  0000 C CNN
F 2 "" H 9500 1000 50  0001 C CNN
F 3 "" H 9500 1000 50  0001 C CNN
	1    9500 1000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 6161A336
P 10450 1550
F 0 "C1" H 10565 1596 50  0000 L CNN
F 1 "100n" H 10565 1505 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10488 1400 50  0001 C CNN
F 3 "~" H 10450 1550 50  0001 C CNN
	1    10450 1550
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR011
U 1 1 6161A767
P 10450 1400
F 0 "#PWR011" H 10450 1250 50  0001 C CNN
F 1 "+3V3" H 10465 1573 50  0000 C CNN
F 2 "" H 10450 1400 50  0001 C CNN
F 3 "" H 10450 1400 50  0001 C CNN
	1    10450 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR012
U 1 1 6161A9E7
P 10450 1700
F 0 "#PWR012" H 10450 1450 50  0001 C CNN
F 1 "GND" H 10455 1527 50  0000 C CNN
F 2 "" H 10450 1700 50  0001 C CNN
F 3 "" H 10450 1700 50  0001 C CNN
	1    10450 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 2750 2350 2750
Wire Wire Line
	2350 2750 2350 2950
$Comp
L Jumper:SolderJumper_3_Open JP3
U 1 1 6161D53D
P 3300 3600
F 0 "JP3" V 3346 3667 50  0000 L CNN
F 1 "x" V 3255 3667 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 3300 3600 50  0001 C CNN
F 3 "~" H 3300 3600 50  0001 C CNN
	1    3300 3600
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Open JP1
U 1 1 6161D98C
P 2850 3600
F 0 "JP1" V 2896 3667 50  0000 L CNN
F 1 "x" V 2805 3667 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 2850 3600 50  0001 C CNN
F 3 "~" H 2850 3600 50  0001 C CNN
	1    2850 3600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3300 3400 2850 3400
Wire Wire Line
	2550 3400 2550 3550
Wire Wire Line
	2550 3550 2350 3550
Connection ~ 2850 3400
Wire Wire Line
	2850 3400 2550 3400
Wire Wire Line
	2700 3650 2700 3800
Wire Wire Line
	2700 3800 2850 3800
Wire Wire Line
	2350 3650 2700 3650
Connection ~ 2850 3800
Wire Wire Line
	2850 3800 3300 3800
Wire Wire Line
	3450 3600 4350 3600
Wire Wire Line
	4350 3600 4350 3500
Wire Wire Line
	3000 3600 3000 3000
Wire Wire Line
	3000 3000 4350 3000
$Comp
L Jumper:SolderJumper_3_Open JP7
U 1 1 61620A9C
P 5950 3000
F 0 "JP7" V 5996 3067 50  0000 L CNN
F 1 "x" V 5905 3067 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 5950 3000 50  0001 C CNN
F 3 "~" H 5950 3000 50  0001 C CNN
	1    5950 3000
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Open JP5
U 1 1 61621245
P 5650 3100
F 0 "JP5" V 5696 3167 50  0000 L CNN
F 1 "x" V 5605 3167 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 5650 3100 50  0001 C CNN
F 3 "~" H 5650 3100 50  0001 C CNN
	1    5650 3100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5800 3100 6250 3100
Wire Wire Line
	6250 3000 6100 3000
Wire Wire Line
	4950 2800 4950 3000
Wire Wire Line
	4950 2800 5650 2800
Wire Wire Line
	5950 3200 5950 3500
Wire Wire Line
	4950 3500 5650 3500
Wire Wire Line
	5650 3300 5650 3500
Connection ~ 5650 3500
Wire Wire Line
	5650 2900 5650 2800
Connection ~ 5650 2800
Wire Wire Line
	5650 2800 5950 2800
$Comp
L power:+3V3 #PWR05
U 1 1 61623BA2
P 6200 2900
F 0 "#PWR05" H 6200 2750 50  0001 C CNN
F 1 "+3V3" H 6215 3073 50  0000 C CNN
F 2 "" H 6200 2900 50  0001 C CNN
F 3 "" H 6200 2900 50  0001 C CNN
	1    6200 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 2900 6200 3200
Wire Wire Line
	6200 3200 6250 3200
$Comp
L power:+3V3 #PWR03
U 1 1 6162493C
P 2700 2850
F 0 "#PWR03" H 2700 2700 50  0001 C CNN
F 1 "+3V3" H 2715 3023 50  0000 C CNN
F 2 "" H 2700 2850 50  0001 C CNN
F 3 "" H 2700 2850 50  0001 C CNN
	1    2700 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 2850 2700 3000
Wire Wire Line
	2700 3000 2500 3000
Wire Wire Line
	2500 3000 2500 3450
Wire Wire Line
	2500 3450 2350 3450
Wire Wire Line
	5650 3500 5950 3500
Text GLabel 6250 3600 0    50   Input ~ 0
rj27
Text GLabel 6250 3500 0    50   Input ~ 0
rj26
Text GLabel 6250 3400 0    50   Input ~ 0
rj25
Text GLabel 6250 3300 0    50   Input ~ 0
rj24
$Comp
L power:GND #PWR07
U 1 1 615E9577
P 6250 3700
F 0 "#PWR07" H 6250 3450 50  0001 C CNN
F 1 "GND" H 6255 3527 50  0000 C CNN
F 2 "" H 6250 3700 50  0001 C CNN
F 3 "" H 6250 3700 50  0001 C CNN
	1    6250 3700
	1    0    0    -1  
$EndComp
Text GLabel 2350 3050 2    50   Input ~ 0
rj27
Text GLabel 2350 3150 2    50   Input ~ 0
rj26
Text GLabel 2350 3250 2    50   Input ~ 0
rj25
Text GLabel 2350 3350 2    50   Input ~ 0
rj24
$Comp
L 74xx:74AHC04 U1
U 4 1 6162EF57
P 4650 4500
F 0 "U1" H 4650 4817 50  0000 C CNN
F 1 "74AHC04" H 4650 4726 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4650 4500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74AHC_AHCT04.pdf" H 4650 4500 50  0001 C CNN
	4    4650 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 6162EF5D
P 2500 4250
F 0 "#PWR02" H 2500 4000 50  0001 C CNN
F 1 "GND" H 2505 4077 50  0000 C CNN
F 2 "" H 2500 4250 50  0001 C CNN
F 3 "" H 2500 4250 50  0001 C CNN
	1    2500 4250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74AHC04 U1
U 3 1 6162EF63
P 4650 5000
F 0 "U1" H 4650 4683 50  0000 C CNN
F 1 "74AHC04" H 4650 4774 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4650 5000 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74AHC_AHCT04.pdf" H 4650 5000 50  0001 C CNN
	3    4650 5000
	-1   0    0    1   
$EndComp
Wire Wire Line
	1950 5350 1950 5500
Wire Wire Line
	1950 5500 7300 5500
Wire Wire Line
	7300 5500 7300 4300
Wire Wire Line
	7300 4300 6650 4300
Wire Wire Line
	2500 4250 2350 4250
Wire Wire Line
	2350 4250 2350 4450
$Comp
L Jumper:SolderJumper_3_Open JP4
U 1 1 6162EF75
P 3300 5100
F 0 "JP4" V 3346 5167 50  0000 L CNN
F 1 "x" V 3255 5167 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 3300 5100 50  0001 C CNN
F 3 "~" H 3300 5100 50  0001 C CNN
	1    3300 5100
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Open JP2
U 1 1 6162EF7B
P 2850 5100
F 0 "JP2" V 2896 5167 50  0000 L CNN
F 1 "x" V 2805 5167 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 2850 5100 50  0001 C CNN
F 3 "~" H 2850 5100 50  0001 C CNN
	1    2850 5100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3300 4900 2850 4900
Wire Wire Line
	2550 4900 2550 5050
Wire Wire Line
	2550 5050 2350 5050
Connection ~ 2850 4900
Wire Wire Line
	2850 4900 2550 4900
Wire Wire Line
	2700 5150 2700 5300
Wire Wire Line
	2700 5300 2850 5300
Wire Wire Line
	2350 5150 2700 5150
Connection ~ 2850 5300
Wire Wire Line
	2850 5300 3300 5300
Wire Wire Line
	3450 5100 4350 5100
Wire Wire Line
	4350 5100 4350 5000
Wire Wire Line
	3000 5100 3000 4500
Wire Wire Line
	3000 4500 4350 4500
$Comp
L Jumper:SolderJumper_3_Open JP8
U 1 1 6162EF8F
P 5950 4500
F 0 "JP8" V 5996 4567 50  0000 L CNN
F 1 "x" V 5905 4567 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 5950 4500 50  0001 C CNN
F 3 "~" H 5950 4500 50  0001 C CNN
	1    5950 4500
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Open JP6
U 1 1 6162EF95
P 5650 4600
F 0 "JP6" V 5696 4667 50  0000 L CNN
F 1 "x" V 5605 4667 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 5650 4600 50  0001 C CNN
F 3 "~" H 5650 4600 50  0001 C CNN
	1    5650 4600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5800 4600 6250 4600
Wire Wire Line
	6250 4500 6100 4500
Wire Wire Line
	4950 4300 4950 4500
Wire Wire Line
	4950 4300 5650 4300
Wire Wire Line
	5950 4700 5950 5000
Wire Wire Line
	4950 5000 5650 5000
Wire Wire Line
	5650 4800 5650 5000
Connection ~ 5650 5000
Wire Wire Line
	5650 4400 5650 4300
Connection ~ 5650 4300
Wire Wire Line
	5650 4300 5950 4300
$Comp
L power:+3V3 #PWR06
U 1 1 6162EFA6
P 6200 4400
F 0 "#PWR06" H 6200 4250 50  0001 C CNN
F 1 "+3V3" H 6215 4573 50  0000 C CNN
F 2 "" H 6200 4400 50  0001 C CNN
F 3 "" H 6200 4400 50  0001 C CNN
	1    6200 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 4400 6200 4700
Wire Wire Line
	6200 4700 6250 4700
$Comp
L power:+3V3 #PWR04
U 1 1 6162EFAE
P 2700 4350
F 0 "#PWR04" H 2700 4200 50  0001 C CNN
F 1 "+3V3" H 2715 4523 50  0000 C CNN
F 2 "" H 2700 4350 50  0001 C CNN
F 3 "" H 2700 4350 50  0001 C CNN
	1    2700 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 4350 2700 4500
Wire Wire Line
	2700 4500 2500 4500
Wire Wire Line
	2500 4500 2500 4950
Wire Wire Line
	2500 4950 2350 4950
Wire Wire Line
	5650 5000 5950 5000
Text GLabel 6250 5100 0    50   Input ~ 0
rj17
Text GLabel 6250 5000 0    50   Input ~ 0
rj16
Text GLabel 6250 4900 0    50   Input ~ 0
rj15
Text GLabel 6250 4800 0    50   Input ~ 0
rj14
$Comp
L power:GND #PWR08
U 1 1 6162EFBD
P 6250 5200
F 0 "#PWR08" H 6250 4950 50  0001 C CNN
F 1 "GND" H 6255 5027 50  0000 C CNN
F 2 "" H 6250 5200 50  0001 C CNN
F 3 "" H 6250 5200 50  0001 C CNN
	1    6250 5200
	1    0    0    -1  
$EndComp
Text GLabel 2350 4550 2    50   Input ~ 0
rj17
Text GLabel 2350 4650 2    50   Input ~ 0
rj16
Text GLabel 2350 4750 2    50   Input ~ 0
rj15
Text GLabel 2350 4850 2    50   Input ~ 0
rj14
$Comp
L 74xx:74AHC04 U1
U 1 1 6163098B
P 4650 3000
F 0 "U1" H 4650 3317 50  0000 C CNN
F 1 "74AHC04" H 4650 3226 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4650 3000 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74AHC_AHCT04.pdf" H 4650 3000 50  0001 C CNN
	1    4650 3000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74AHC04 U1
U 2 1 61631810
P 3850 2300
F 0 "U1" H 3850 1983 50  0000 C CNN
F 1 "74AHC04" H 3850 2074 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 3850 2300 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74AHC_AHCT04.pdf" H 3850 2300 50  0001 C CNN
	2    3850 2300
	-1   0    0    1   
$EndComp
$Comp
L Connector:RJ45_LED_Shielded J2
U 1 1 6163DFD8
P 1950 4850
F 0 "J2" H 1950 5517 50  0000 C CNN
F 1 "RJ45_LED_Shielded" H 1950 5426 50  0000 C CNN
F 2 "Connector_RJ:RJ45_BEL_SS74301-00x_Vertical" V 1950 4875 50  0001 C CNN
F 3 "~" V 1950 4875 50  0001 C CNN
	1    1950 4850
	1    0    0    -1  
$EndComp
$Comp
L Connector:RJ45_LED_Shielded J1
U 1 1 61640063
P 1950 3350
F 0 "J1" H 1950 4017 50  0000 C CNN
F 1 "RJ45_LED_Shielded" H 1950 3926 50  0000 C CNN
F 2 "Connector_RJ:RJ45_BEL_SS74301-00x_Vertical" V 1950 3375 50  0001 C CNN
F 3 "~" V 1950 3375 50  0001 C CNN
	1    1950 3350
	1    0    0    -1  
$EndComp
$Comp
L Connector:RJ45_LED_Shielded J3
U 1 1 61640C91
P 6650 3300
F 0 "J3" H 6650 3875 50  0000 C CNN
F 1 "RJ45_LED_Shielded" H 6650 3966 50  0000 C CNN
F 2 "Connector_RJ:RJ45_BEL_SS74301-00x_Vertical" V 6650 3325 50  0001 C CNN
F 3 "~" V 6650 3325 50  0001 C CNN
	1    6650 3300
	-1   0    0    1   
$EndComp
$Comp
L Connector:RJ45_LED_Shielded J4
U 1 1 61641D70
P 6650 4800
F 0 "J4" H 6650 5375 50  0000 C CNN
F 1 "RJ45_LED_Shielded" H 6650 5466 50  0000 C CNN
F 2 "Connector_RJ:RJ45_BEL_SS74301-00x_Vertical" V 6650 4825 50  0001 C CNN
F 3 "~" V 6650 4825 50  0001 C CNN
	1    6650 4800
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74AHC04 U1
U 6 1 61659E8D
P 4650 3500
F 0 "U1" H 4650 3183 50  0000 C CNN
F 1 "74AHC04" H 4650 3274 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4650 3500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74AHC_AHCT04.pdf" H 4650 3500 50  0001 C CNN
	6    4650 3500
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74AHC04 U1
U 5 1 6165A9DC
P 5150 1350
F 0 "U1" H 5150 1667 50  0000 C CNN
F 1 "74AHC04" H 5150 1576 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5150 1350 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74AHC_AHCT04.pdf" H 5150 1350 50  0001 C CNN
	5    5150 1350
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 6169AB05
P 8150 1600
F 0 "H2" V 8104 1750 50  0000 L CNN
F 1 "MountingHole_Pad" V 8195 1750 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 8150 1600 50  0001 C CNN
F 3 "~" H 8150 1600 50  0001 C CNN
	1    8150 1600
	0    1    1    0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 6169AE0C
P 8150 2100
F 0 "H4" V 8104 2250 50  0000 L CNN
F 1 "MountingHole_Pad" V 8195 2250 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 8150 2100 50  0001 C CNN
F 3 "~" H 8150 2100 50  0001 C CNN
	1    8150 2100
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 6169C8E6
P 8050 2100
F 0 "#PWR0101" H 8050 1850 50  0001 C CNN
F 1 "GND" H 8055 1927 50  0000 C CNN
F 2 "" H 8050 2100 50  0001 C CNN
F 3 "" H 8050 2100 50  0001 C CNN
	1    8050 2100
	1    0    0    -1  
$EndComp
Connection ~ 8050 2100
Wire Wire Line
	8050 1600 8050 2100
$EndSCHEMATC
