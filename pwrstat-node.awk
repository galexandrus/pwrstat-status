BEGIN {
#	timestamp=strftime("%s")
}
{
	if	($1 == "Utility")
	        utility_voltage=$3
	else if ($1 == "Output")
	        output_voltage=$3
	else if ($1 == "Battery")
		battery_capacity=$3
	else if ($1 == "Remaining")
		remaining_runtime=$3
	else if ($1 == "Load.........................") {
	        load_watt=$2
	        load_percent=substr($3, 6)
	}
}
END {
	printf "# HELP utility_voltage Command 'pwrstat -status' field 'Utility Voltage', V.\n"
	printf "# TYPE utility_voltage gauge\n"
	printf "utility_voltage %d\n", utility_voltage
	printf "# HELP output_voltage Command 'pwrstat -status' field 'Output Voltage', V.\n"
	printf "# TYPE output_voltage gauge\n"
	printf "output_voltage %d\n", output_voltage
	printf "# HELP battery_capacity Command 'pwrstat -status' field 'Battery Capacity', %.\n"
	printf "# TYPE battery_capacity gauge\n"
	printf "battery_capacity %d\n", battery_capacity
	printf "# HELP remaining_runtime Command 'pwrstat -status' field 'Remaining Runtime', min.\n"
	printf "# TYPE remaining_runtime gauge\n"
	printf "remaining_runtime %d\n", remaining_runtime
	printf "# HELP load_watt Command 'pwrstat -status' field 'Load', Watt.\n"
	printf "# TYPE load_watt gauge\n"
	printf "load_watt %d\n", load_watt
	printf "# HELP load_percent Command 'pwrstat -status' field 'Load', %.\n"
	printf "# TYPE load_percent gauge\n"
	printf "load_percent %d\n", load_percent
}
