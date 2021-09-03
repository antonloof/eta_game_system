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
L Device:R_Small R7
U 1 1 60F45AAB
P 3000 2450
F 0 "R7" V 2804 2450 50  0000 C CNN
F 1 "330" V 2895 2450 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 3000 2450 50  0001 C CNN
F 3 "~" H 3000 2450 50  0001 C CNN
	1    3000 2450
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R8
U 1 1 60F4611D
P 3000 3050
F 0 "R8" V 2804 3050 50  0000 C CNN
F 1 "330" V 2895 3050 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 3000 3050 50  0001 C CNN
F 3 "~" H 3000 3050 50  0001 C CNN
	1    3000 3050
	0    1    1    0   
$EndComp
Wire Wire Line
	2900 3050 2650 3050
Wire Wire Line
	2900 2450 2650 2450
$Comp
L MCU_ST_STM8:STM8L101F3P U2
U 1 1 60F4951C
P 7850 2900
F 0 "U2" H 8250 3700 50  0000 C CNN
F 1 "STM8L101F3P" H 8150 2100 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 7900 3900 50  0001 L CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220591.pdf" H 7850 2500 50  0001 C CNN
	1    7850 2900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR021
U 1 1 60F4AB58
P 7850 3800
F 0 "#PWR021" H 7850 3550 50  0001 C CNN
F 1 "GND" H 7855 3627 50  0000 C CNN
F 2 "" H 7850 3800 50  0001 C CNN
F 3 "" H 7850 3800 50  0001 C CNN
	1    7850 3800
	1    0    0    -1  
$EndComp
Text GLabel 7850 1650 1    50   Input ~ 0
3v3
$Comp
L Connector:RJ45_LED_Shielded J1
U 1 1 60F4BA7B
P 2250 2750
F 0 "J1" H 2250 3325 50  0000 C CNN
F 1 "j0011d21bnl" H 2250 3416 50  0000 C CNN
F 2 "Connector_RJ:RJ45_BEL_SS74301-00x_Vertical" V 2250 2775 50  0001 C CNN
F 3 "~" V 2250 2775 50  0001 C CNN
	1    2250 2750
	-1   0    0    1   
$EndComp
Text GLabel 1850 3050 0    50   Input ~ 0
connected
Text GLabel 1850 2450 0    50   Input ~ 0
tx
Text GLabel 1850 2550 0    50   Input ~ 0
rx
Text GLabel 1850 2650 0    50   Input ~ 0
3v3
Wire Wire Line
	1400 2950 1400 2750
Wire Wire Line
	1400 2750 1850 2750
Wire Wire Line
	1400 2950 1850 2950
Wire Wire Line
	1400 2950 1400 3150
Wire Wire Line
	1400 3150 1850 3150
Connection ~ 1400 2950
$Comp
L power:GND #PWR03
U 1 1 60F500E1
P 1400 3150
F 0 "#PWR03" H 1400 2900 50  0001 C CNN
F 1 "GND" H 1405 2977 50  0000 C CNN
F 2 "" H 1400 3150 50  0001 C CNN
F 3 "" H 1400 3150 50  0001 C CNN
	1    1400 3150
	1    0    0    -1  
$EndComp
Connection ~ 1400 3150
Text GLabel 8450 2500 2    50   Input ~ 0
tx
Text GLabel 8450 2600 2    50   Input ~ 0
rx
$Comp
L Device:C_Small C10
U 1 1 60F53D7F
P 8050 1850
F 0 "C10" H 8142 1896 50  0000 L CNN
F 1 "100n" H 8142 1805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 8050 1850 50  0001 C CNN
F 3 "~" H 8050 1850 50  0001 C CNN
	1    8050 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C11
U 1 1 60F54794
P 8550 1850
F 0 "C11" H 8642 1896 50  0000 L CNN
F 1 "10u" H 8642 1805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 8550 1850 50  0001 C CNN
F 3 "~" H 8550 1850 50  0001 C CNN
	1    8550 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 1650 7850 1750
Wire Wire Line
	7850 1750 8050 1750
Connection ~ 8050 1750
Wire Wire Line
	8050 1750 8550 1750
Wire Wire Line
	7850 1750 7850 2000
Connection ~ 7850 1750
Wire Wire Line
	8050 1950 8550 1950
$Comp
L power:GND #PWR022
U 1 1 60F5582C
P 8550 1950
F 0 "#PWR022" H 8550 1700 50  0001 C CNN
F 1 "GND" H 8555 1777 50  0000 C CNN
F 2 "" H 8550 1950 50  0001 C CNN
F 3 "" H 8550 1950 50  0001 C CNN
	1    8550 1950
	1    0    0    -1  
$EndComp
Connection ~ 8550 1950
$Comp
L Connector_Generic:Conn_01x04 J2
U 1 1 60F6382E
P 6550 2500
F 0 "J2" H 6468 2075 50  0000 C CNN
F 1 "swim_header" H 6468 2166 50  0000 C CNN
F 2 "good_things:TSM-104-01-L-SH" H 6550 2500 50  0001 C CNN
F 3 "~" H 6550 2500 50  0001 C CNN
	1    6550 2500
	-1   0    0    1   
$EndComp
NoConn ~ 6750 2600
Wire Wire Line
	6750 2500 6850 2500
$Comp
L power:GND #PWR020
U 1 1 60F6BFA5
P 6850 2550
F 0 "#PWR020" H 6850 2300 50  0001 C CNN
F 1 "GND" H 6855 2377 50  0000 C CNN
F 2 "" H 6850 2550 50  0001 C CNN
F 3 "" H 6850 2550 50  0001 C CNN
	1    6850 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 2300 7000 2300
Wire Wire Line
	7000 2300 7000 2400
Wire Wire Line
	7000 2400 7250 2400
Wire Wire Line
	6750 2400 6900 2400
Wire Wire Line
	6900 2400 6900 2350
Wire Wire Line
	6900 2350 7100 2350
Wire Wire Line
	7100 2350 7100 2300
Wire Wire Line
	7100 2300 7250 2300
Wire Wire Line
	6850 2550 6850 2500
NoConn ~ 2250 2250
Text GLabel 8450 2700 2    50   Input ~ 0
connected
Text GLabel 8450 2400 2    50   Input ~ 0
rxled
Text GLabel 8450 2300 2    50   Input ~ 0
txled
Text GLabel 2650 2550 2    50   Input ~ 0
txled
Text GLabel 2650 3150 2    50   Input ~ 0
rxled
Wire Wire Line
	3250 3050 3100 3050
Wire Wire Line
	3100 2450 3250 2450
Wire Wire Line
	3250 2450 3250 3050
$Comp
L 74xx:74HCT541 U1
U 1 1 60FCCDE1
P 5900 3300
F 0 "U1" H 6150 3950 50  0000 C CNN
F 1 "74HCT541" H 6100 2650 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 5900 3300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT541" H 5900 3300 50  0001 C CNN
	1    5900 3300
	1    0    0    -1  
$EndComp
Text GLabel 5900 2150 1    50   Input ~ 0
3v3
$Comp
L Device:C_Small C9
U 1 1 60FD5E69
P 5500 2350
F 0 "C9" H 5592 2396 50  0000 L CNN
F 1 "100n" H 5592 2305 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5500 2350 50  0001 C CNN
F 3 "~" H 5500 2350 50  0001 C CNN
	1    5500 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 2250 5900 2250
Wire Wire Line
	5900 2150 5900 2250
Connection ~ 5900 2250
$Comp
L power:GND #PWR018
U 1 1 60FD8AB6
P 5500 2450
F 0 "#PWR018" H 5500 2200 50  0001 C CNN
F 1 "GND" H 5505 2277 50  0000 C CNN
F 2 "" H 5500 2450 50  0001 C CNN
F 3 "" H 5500 2450 50  0001 C CNN
	1    5500 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 2250 5900 2500
Wire Wire Line
	5400 3800 5400 3700
Wire Wire Line
	5400 4100 5900 4100
Wire Wire Line
	5400 3800 5400 4100
Connection ~ 5400 3800
$Comp
L power:GND #PWR019
U 1 1 60FDB23A
P 5900 4100
F 0 "#PWR019" H 5900 3850 50  0001 C CNN
F 1 "GND" H 5905 3927 50  0000 C CNN
F 2 "" H 5900 4100 50  0001 C CNN
F 3 "" H 5900 4100 50  0001 C CNN
	1    5900 4100
	1    0    0    -1  
$EndComp
Connection ~ 5900 4100
Wire Wire Line
	6400 2800 7250 2800
Wire Wire Line
	7250 2900 6400 2900
Wire Wire Line
	6400 3000 7250 3000
Wire Wire Line
	7250 3100 6400 3100
Wire Wire Line
	6400 3200 7250 3200
Wire Wire Line
	7250 3300 6400 3300
Wire Wire Line
	6400 3400 7250 3400
Wire Wire Line
	7250 3500 6400 3500
$Comp
L Device:R_Small R1
U 1 1 6100C737
P 1600 5550
F 0 "R1" V 1404 5550 50  0000 C CNN
F 1 "1k" V 1495 5550 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 1600 5550 50  0001 C CNN
F 3 "~" H 1600 5550 50  0001 C CNN
	1    1600 5550
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R3
U 1 1 6100C73D
P 1850 5400
F 0 "R3" H 1791 5354 50  0000 R CNN
F 1 "10k" H 1791 5445 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 1850 5400 50  0001 C CNN
F 3 "~" H 1850 5400 50  0001 C CNN
	1    1850 5400
	-1   0    0    1   
$EndComp
Text GLabel 1850 5300 1    50   Input ~ 0
3v3
Wire Wire Line
	1850 5550 1850 5500
$Comp
L Device:C_Small C1
U 1 1 6100C748
P 1850 5750
F 0 "C1" H 1942 5796 50  0000 L CNN
F 1 "100n" H 1942 5705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 1850 5750 50  0001 C CNN
F 3 "~" H 1850 5750 50  0001 C CNN
	1    1850 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 6100C74E
P 1850 5950
F 0 "#PWR04" H 1850 5700 50  0001 C CNN
F 1 "GND" H 1855 5777 50  0000 C CNN
F 2 "" H 1850 5950 50  0001 C CNN
F 3 "" H 1850 5950 50  0001 C CNN
	1    1850 5950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 6101596D
P 1350 5950
F 0 "#PWR01" H 1350 5700 50  0001 C CNN
F 1 "GND" H 1355 5777 50  0000 C CNN
F 2 "" H 1350 5950 50  0001 C CNN
F 3 "" H 1350 5950 50  0001 C CNN
	1    1350 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 5850 1850 5950
Wire Wire Line
	1850 5650 1850 5550
Connection ~ 1850 5550
Text GLabel 1950 5550 2    50   Input ~ 0
sw_left
$Comp
L Switch:SW_Push SW1
U 1 1 61020D54
P 1350 5750
F 0 "SW1" V 1304 5898 50  0000 L CNN
F 1 "SW_left" V 1395 5898 50  0000 L CNN
F 2 "Button_Switch_Keyboard:SW_Cherry_MX_1.00u_Plate" H 1350 5950 50  0001 C CNN
F 3 "~" H 1350 5950 50  0001 C CNN
	1    1350 5750
	0    1    1    0   
$EndComp
Wire Wire Line
	1700 5550 1850 5550
Wire Wire Line
	1500 5550 1350 5550
Wire Wire Line
	1950 5550 1850 5550
$Comp
L Device:R_Small R5
U 1 1 6102ACB5
P 2750 5550
F 0 "R5" V 2554 5550 50  0000 C CNN
F 1 "1k" V 2645 5550 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 2750 5550 50  0001 C CNN
F 3 "~" H 2750 5550 50  0001 C CNN
	1    2750 5550
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R9
U 1 1 6102ACBB
P 3000 5400
F 0 "R9" H 2941 5354 50  0000 R CNN
F 1 "10k" H 2941 5445 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 3000 5400 50  0001 C CNN
F 3 "~" H 3000 5400 50  0001 C CNN
	1    3000 5400
	-1   0    0    1   
$EndComp
Text GLabel 3000 5300 1    50   Input ~ 0
3v3
Wire Wire Line
	3000 5550 3000 5500
$Comp
L Device:C_Small C3
U 1 1 6102ACC3
P 3000 5750
F 0 "C3" H 3092 5796 50  0000 L CNN
F 1 "100n" H 3092 5705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 3000 5750 50  0001 C CNN
F 3 "~" H 3000 5750 50  0001 C CNN
	1    3000 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 6102ACC9
P 3000 5950
F 0 "#PWR08" H 3000 5700 50  0001 C CNN
F 1 "GND" H 3005 5777 50  0000 C CNN
F 2 "" H 3000 5950 50  0001 C CNN
F 3 "" H 3000 5950 50  0001 C CNN
	1    3000 5950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 6102ACCF
P 2500 5950
F 0 "#PWR06" H 2500 5700 50  0001 C CNN
F 1 "GND" H 2505 5777 50  0000 C CNN
F 2 "" H 2500 5950 50  0001 C CNN
F 3 "" H 2500 5950 50  0001 C CNN
	1    2500 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 5850 3000 5950
Wire Wire Line
	3000 5650 3000 5550
Connection ~ 3000 5550
Text GLabel 3100 5550 2    50   Input ~ 0
sw_right
$Comp
L Switch:SW_Push SW3
U 1 1 6102ACD9
P 2500 5750
F 0 "SW3" V 2454 5898 50  0000 L CNN
F 1 "SW_right" V 2545 5898 50  0000 L CNN
F 2 "Button_Switch_Keyboard:SW_Cherry_MX_1.00u_Plate" H 2500 5950 50  0001 C CNN
F 3 "~" H 2500 5950 50  0001 C CNN
	1    2500 5750
	0    1    1    0   
$EndComp
Wire Wire Line
	2850 5550 3000 5550
Wire Wire Line
	2650 5550 2500 5550
Wire Wire Line
	3100 5550 3000 5550
$Comp
L Device:R_Small R11
U 1 1 6102CE9C
P 3900 5550
F 0 "R11" V 3704 5550 50  0000 C CNN
F 1 "1k" V 3795 5550 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 3900 5550 50  0001 C CNN
F 3 "~" H 3900 5550 50  0001 C CNN
	1    3900 5550
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R13
U 1 1 6102CEA2
P 4150 5400
F 0 "R13" H 4091 5354 50  0000 R CNN
F 1 "10k" H 4091 5445 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 4150 5400 50  0001 C CNN
F 3 "~" H 4150 5400 50  0001 C CNN
	1    4150 5400
	-1   0    0    1   
$EndComp
Text GLabel 4150 5300 1    50   Input ~ 0
3v3
Wire Wire Line
	4150 5550 4150 5500
$Comp
L Device:C_Small C5
U 1 1 6102CEAA
P 4150 5750
F 0 "C5" H 4242 5796 50  0000 L CNN
F 1 "100n" H 4242 5705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 4150 5750 50  0001 C CNN
F 3 "~" H 4150 5750 50  0001 C CNN
	1    4150 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR012
U 1 1 6102CEB0
P 4150 5950
F 0 "#PWR012" H 4150 5700 50  0001 C CNN
F 1 "GND" H 4155 5777 50  0000 C CNN
F 2 "" H 4150 5950 50  0001 C CNN
F 3 "" H 4150 5950 50  0001 C CNN
	1    4150 5950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 6102CEB6
P 3650 5950
F 0 "#PWR010" H 3650 5700 50  0001 C CNN
F 1 "GND" H 3655 5777 50  0000 C CNN
F 2 "" H 3650 5950 50  0001 C CNN
F 3 "" H 3650 5950 50  0001 C CNN
	1    3650 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 5850 4150 5950
Wire Wire Line
	4150 5650 4150 5550
Connection ~ 4150 5550
Text GLabel 4250 5550 2    50   Input ~ 0
sw_up
$Comp
L Switch:SW_Push SW5
U 1 1 6102CEC0
P 3650 5750
F 0 "SW5" V 3604 5898 50  0000 L CNN
F 1 "SW_up" V 3695 5898 50  0000 L CNN
F 2 "Button_Switch_Keyboard:SW_Cherry_MX_1.00u_Plate" H 3650 5950 50  0001 C CNN
F 3 "~" H 3650 5950 50  0001 C CNN
	1    3650 5750
	0    1    1    0   
$EndComp
Wire Wire Line
	4000 5550 4150 5550
Wire Wire Line
	3800 5550 3650 5550
Wire Wire Line
	4250 5550 4150 5550
$Comp
L Device:R_Small R15
U 1 1 61033EBF
P 5050 5550
F 0 "R15" V 4854 5550 50  0000 C CNN
F 1 "1k" V 4945 5550 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 5050 5550 50  0001 C CNN
F 3 "~" H 5050 5550 50  0001 C CNN
	1    5050 5550
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R17
U 1 1 61033EC5
P 5300 5400
F 0 "R17" H 5241 5354 50  0000 R CNN
F 1 "10k" H 5241 5445 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 5300 5400 50  0001 C CNN
F 3 "~" H 5300 5400 50  0001 C CNN
	1    5300 5400
	-1   0    0    1   
$EndComp
Text GLabel 5300 5300 1    50   Input ~ 0
3v3
Wire Wire Line
	5300 5550 5300 5500
$Comp
L Device:C_Small C7
U 1 1 61033ECD
P 5300 5750
F 0 "C7" H 5392 5796 50  0000 L CNN
F 1 "100n" H 5392 5705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5300 5750 50  0001 C CNN
F 3 "~" H 5300 5750 50  0001 C CNN
	1    5300 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 61033ED3
P 5300 5950
F 0 "#PWR016" H 5300 5700 50  0001 C CNN
F 1 "GND" H 5305 5777 50  0000 C CNN
F 2 "" H 5300 5950 50  0001 C CNN
F 3 "" H 5300 5950 50  0001 C CNN
	1    5300 5950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR014
U 1 1 61033ED9
P 4800 5950
F 0 "#PWR014" H 4800 5700 50  0001 C CNN
F 1 "GND" H 4805 5777 50  0000 C CNN
F 2 "" H 4800 5950 50  0001 C CNN
F 3 "" H 4800 5950 50  0001 C CNN
	1    4800 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 5850 5300 5950
Wire Wire Line
	5300 5650 5300 5550
Connection ~ 5300 5550
Text GLabel 5400 5550 2    50   Input ~ 0
sw_down
$Comp
L Switch:SW_Push SW7
U 1 1 61033EE3
P 4800 5750
F 0 "SW7" V 4754 5898 50  0000 L CNN
F 1 "SW_down" V 4845 5898 50  0000 L CNN
F 2 "Button_Switch_Keyboard:SW_Cherry_MX_1.00u_Plate" H 4800 5950 50  0001 C CNN
F 3 "~" H 4800 5950 50  0001 C CNN
	1    4800 5750
	0    1    1    0   
$EndComp
Wire Wire Line
	5150 5550 5300 5550
Wire Wire Line
	4950 5550 4800 5550
Wire Wire Line
	5400 5550 5300 5550
$Comp
L Device:R_Small R2
U 1 1 6104B2C0
P 1600 6650
F 0 "R2" V 1404 6650 50  0000 C CNN
F 1 "1k" V 1495 6650 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 1600 6650 50  0001 C CNN
F 3 "~" H 1600 6650 50  0001 C CNN
	1    1600 6650
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R4
U 1 1 6104B2C6
P 1850 6500
F 0 "R4" H 1791 6454 50  0000 R CNN
F 1 "10k" H 1791 6545 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 1850 6500 50  0001 C CNN
F 3 "~" H 1850 6500 50  0001 C CNN
	1    1850 6500
	-1   0    0    1   
$EndComp
Text GLabel 1850 6400 1    50   Input ~ 0
3v3
Wire Wire Line
	1850 6650 1850 6600
$Comp
L Device:C_Small C2
U 1 1 6104B2CE
P 1850 6850
F 0 "C2" H 1942 6896 50  0000 L CNN
F 1 "100n" H 1942 6805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 1850 6850 50  0001 C CNN
F 3 "~" H 1850 6850 50  0001 C CNN
	1    1850 6850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 6104B2D4
P 1850 7050
F 0 "#PWR05" H 1850 6800 50  0001 C CNN
F 1 "GND" H 1855 6877 50  0000 C CNN
F 2 "" H 1850 7050 50  0001 C CNN
F 3 "" H 1850 7050 50  0001 C CNN
	1    1850 7050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 6104B2DA
P 1350 7050
F 0 "#PWR02" H 1350 6800 50  0001 C CNN
F 1 "GND" H 1355 6877 50  0000 C CNN
F 2 "" H 1350 7050 50  0001 C CNN
F 3 "" H 1350 7050 50  0001 C CNN
	1    1350 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 6950 1850 7050
Wire Wire Line
	1850 6750 1850 6650
Connection ~ 1850 6650
Text GLabel 1950 6650 2    50   Input ~ 0
sw_a0
$Comp
L Switch:SW_Push SW2
U 1 1 6104B2E4
P 1350 6850
F 0 "SW2" V 1304 6998 50  0000 L CNN
F 1 "SW_a0" V 1395 6998 50  0000 L CNN
F 2 "Button_Switch_Keyboard:SW_Cherry_MX_1.00u_Plate" H 1350 7050 50  0001 C CNN
F 3 "~" H 1350 7050 50  0001 C CNN
	1    1350 6850
	0    1    1    0   
$EndComp
Wire Wire Line
	1700 6650 1850 6650
Wire Wire Line
	1500 6650 1350 6650
Wire Wire Line
	1950 6650 1850 6650
$Comp
L Device:R_Small R6
U 1 1 6104B2ED
P 2750 6650
F 0 "R6" V 2554 6650 50  0000 C CNN
F 1 "1k" V 2645 6650 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 2750 6650 50  0001 C CNN
F 3 "~" H 2750 6650 50  0001 C CNN
	1    2750 6650
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R10
U 1 1 6104B2F3
P 3000 6500
F 0 "R10" H 2941 6454 50  0000 R CNN
F 1 "10k" H 2941 6545 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 3000 6500 50  0001 C CNN
F 3 "~" H 3000 6500 50  0001 C CNN
	1    3000 6500
	-1   0    0    1   
$EndComp
Text GLabel 3000 6400 1    50   Input ~ 0
3v3
Wire Wire Line
	3000 6650 3000 6600
$Comp
L Device:C_Small C4
U 1 1 6104B2FB
P 3000 6850
F 0 "C4" H 3092 6896 50  0000 L CNN
F 1 "100n" H 3092 6805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 3000 6850 50  0001 C CNN
F 3 "~" H 3000 6850 50  0001 C CNN
	1    3000 6850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 6104B301
P 3000 7050
F 0 "#PWR09" H 3000 6800 50  0001 C CNN
F 1 "GND" H 3005 6877 50  0000 C CNN
F 2 "" H 3000 7050 50  0001 C CNN
F 3 "" H 3000 7050 50  0001 C CNN
	1    3000 7050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 6104B307
P 2500 7050
F 0 "#PWR07" H 2500 6800 50  0001 C CNN
F 1 "GND" H 2505 6877 50  0000 C CNN
F 2 "" H 2500 7050 50  0001 C CNN
F 3 "" H 2500 7050 50  0001 C CNN
	1    2500 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 6950 3000 7050
Wire Wire Line
	3000 6750 3000 6650
Connection ~ 3000 6650
$Comp
L Switch:SW_Push SW4
U 1 1 6104B311
P 2500 6850
F 0 "SW4" V 2454 6998 50  0000 L CNN
F 1 "SW_a1" V 2545 6998 50  0000 L CNN
F 2 "Button_Switch_Keyboard:SW_Cherry_MX_1.00u_Plate" H 2500 7050 50  0001 C CNN
F 3 "~" H 2500 7050 50  0001 C CNN
	1    2500 6850
	0    1    1    0   
$EndComp
Wire Wire Line
	2850 6650 3000 6650
Wire Wire Line
	2650 6650 2500 6650
Wire Wire Line
	3100 6650 3000 6650
$Comp
L Device:R_Small R12
U 1 1 6104B31A
P 3900 6650
F 0 "R12" V 3704 6650 50  0000 C CNN
F 1 "1k" V 3795 6650 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 3900 6650 50  0001 C CNN
F 3 "~" H 3900 6650 50  0001 C CNN
	1    3900 6650
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R14
U 1 1 6104B320
P 4150 6500
F 0 "R14" H 4091 6454 50  0000 R CNN
F 1 "10k" H 4091 6545 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 4150 6500 50  0001 C CNN
F 3 "~" H 4150 6500 50  0001 C CNN
	1    4150 6500
	-1   0    0    1   
$EndComp
Text GLabel 4150 6400 1    50   Input ~ 0
3v3
Wire Wire Line
	4150 6650 4150 6600
$Comp
L Device:C_Small C6
U 1 1 6104B328
P 4150 6850
F 0 "C6" H 4242 6896 50  0000 L CNN
F 1 "100n" H 4242 6805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 4150 6850 50  0001 C CNN
F 3 "~" H 4150 6850 50  0001 C CNN
	1    4150 6850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 6104B32E
P 4150 7050
F 0 "#PWR013" H 4150 6800 50  0001 C CNN
F 1 "GND" H 4155 6877 50  0000 C CNN
F 2 "" H 4150 7050 50  0001 C CNN
F 3 "" H 4150 7050 50  0001 C CNN
	1    4150 7050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 6104B334
P 3650 7050
F 0 "#PWR011" H 3650 6800 50  0001 C CNN
F 1 "GND" H 3655 6877 50  0000 C CNN
F 2 "" H 3650 7050 50  0001 C CNN
F 3 "" H 3650 7050 50  0001 C CNN
	1    3650 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 6950 4150 7050
Wire Wire Line
	4150 6750 4150 6650
Connection ~ 4150 6650
Text GLabel 4250 6650 2    50   Input ~ 0
sw_back_r
$Comp
L Switch:SW_Push SW6
U 1 1 6104B33E
P 3650 6850
F 0 "SW6" V 3604 6998 50  0000 L CNN
F 1 "SW_back_r" V 3695 6998 50  0000 L CNN
F 2 "good_things:TSM-102-01-l_SH" H 3650 7050 50  0001 C CNN
F 3 "~" H 3650 7050 50  0001 C CNN
	1    3650 6850
	0    1    1    0   
$EndComp
Wire Wire Line
	4000 6650 4150 6650
Wire Wire Line
	3800 6650 3650 6650
Wire Wire Line
	4250 6650 4150 6650
$Comp
L Device:R_Small R16
U 1 1 6104B347
P 5050 6650
F 0 "R16" V 4854 6650 50  0000 C CNN
F 1 "1k" V 4945 6650 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 5050 6650 50  0001 C CNN
F 3 "~" H 5050 6650 50  0001 C CNN
	1    5050 6650
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R18
U 1 1 6104B34D
P 5300 6500
F 0 "R18" H 5241 6454 50  0000 R CNN
F 1 "10k" H 5241 6545 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 5300 6500 50  0001 C CNN
F 3 "~" H 5300 6500 50  0001 C CNN
	1    5300 6500
	-1   0    0    1   
$EndComp
Text GLabel 5300 6400 1    50   Input ~ 0
3v3
Wire Wire Line
	5300 6650 5300 6600
$Comp
L Device:C_Small C8
U 1 1 6104B355
P 5300 6850
F 0 "C8" H 5392 6896 50  0000 L CNN
F 1 "100n" H 5392 6805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5300 6850 50  0001 C CNN
F 3 "~" H 5300 6850 50  0001 C CNN
	1    5300 6850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 6104B35B
P 5300 7050
F 0 "#PWR017" H 5300 6800 50  0001 C CNN
F 1 "GND" H 5305 6877 50  0000 C CNN
F 2 "" H 5300 7050 50  0001 C CNN
F 3 "" H 5300 7050 50  0001 C CNN
	1    5300 7050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 6104B361
P 4800 7050
F 0 "#PWR015" H 4800 6800 50  0001 C CNN
F 1 "GND" H 4805 6877 50  0000 C CNN
F 2 "" H 4800 7050 50  0001 C CNN
F 3 "" H 4800 7050 50  0001 C CNN
	1    4800 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 6950 5300 7050
Wire Wire Line
	5300 6750 5300 6650
Connection ~ 5300 6650
Text GLabel 5400 6650 2    50   Input ~ 0
sw_back_l
$Comp
L Switch:SW_Push SW8
U 1 1 6104B36B
P 4800 6850
F 0 "SW8" V 4754 6998 50  0000 L CNN
F 1 "SW_back_l" V 4845 6998 50  0000 L CNN
F 2 "good_things:TSM-102-01-l_SH" H 4800 7050 50  0001 C CNN
F 3 "~" H 4800 7050 50  0001 C CNN
	1    4800 6850
	0    1    1    0   
$EndComp
Wire Wire Line
	5150 6650 5300 6650
Wire Wire Line
	4950 6650 4800 6650
Wire Wire Line
	5400 6650 5300 6650
Text GLabel 3100 6650 2    50   Input ~ 0
sw_a1
Text GLabel 5400 3000 0    50   Input ~ 0
sw_left
Text GLabel 5400 2800 0    50   Input ~ 0
sw_right
Text GLabel 5400 3100 0    50   Input ~ 0
sw_up
Text GLabel 5400 2900 0    50   Input ~ 0
sw_down
Text GLabel 5400 3300 0    50   Input ~ 0
sw_a0
Text GLabel 5400 3400 0    50   Input ~ 0
sw_a1
Text GLabel 5400 3500 0    50   Input ~ 0
sw_back_r
Text GLabel 5400 3200 0    50   Input ~ 0
sw_back_l
NoConn ~ 8450 2900
$Comp
L Mechanical:MountingHole H1
U 1 1 610791E9
P 8550 4700
F 0 "H1" H 8650 4746 50  0000 L CNN
F 1 "MountingHole" H 8650 4655 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 8550 4700 50  0001 C CNN
F 3 "~" H 8550 4700 50  0001 C CNN
	1    8550 4700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 610798FD
P 9300 4700
F 0 "H4" H 9400 4746 50  0000 L CNN
F 1 "MountingHole" H 9400 4655 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 9300 4700 50  0001 C CNN
F 3 "~" H 9300 4700 50  0001 C CNN
	1    9300 4700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 6107A1D1
P 8550 4950
F 0 "H2" H 8650 4996 50  0000 L CNN
F 1 "MountingHole" H 8650 4905 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 8550 4950 50  0001 C CNN
F 3 "~" H 8550 4950 50  0001 C CNN
	1    8550 4950
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 6107C689
P 8550 5200
F 0 "H3" H 8650 5246 50  0000 L CNN
F 1 "MountingHole" H 8650 5155 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 8550 5200 50  0001 C CNN
F 3 "~" H 8550 5200 50  0001 C CNN
	1    8550 5200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H6
U 1 1 6107C68F
P 9300 5200
F 0 "H6" H 9400 5246 50  0000 L CNN
F 1 "MountingHole" H 9400 5155 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 9300 5200 50  0001 C CNN
F 3 "~" H 9300 5200 50  0001 C CNN
	1    9300 5200
	1    0    0    -1  
$EndComp
NoConn ~ 1850 2850
Text Label 7100 2300 0    50   ~ 0
swim
Text Label 6800 2300 0    50   ~ 0
rst
NoConn ~ 7250 2500
NoConn ~ 7250 2600
Text GLabel 3250 2300 1    50   Input ~ 0
3v3
Wire Wire Line
	3250 2300 3250 2450
Connection ~ 3250 2450
$Comp
L Mechanical:MountingHole H5
U 1 1 613711C0
P 9300 4950
F 0 "H5" H 9400 4996 50  0000 L CNN
F 1 "MountingHole" H 9400 4905 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 9300 4950 50  0001 C CNN
F 3 "~" H 9300 4950 50  0001 C CNN
	1    9300 4950
	1    0    0    -1  
$EndComp
$EndSCHEMATC
