set ns [new Simulator]  
set nf [open lab1.nam w]  
$ns namtrace-all $nf   
set tf [open lab1.tr w]   
$ns trace-all $tf  
proc finish { } {  
global ns nf tf  
$ns flush-trace   
close $tf  
exec nam lab1.nam &  
exit 0  
}  
set n0 [$ns node]   
/* Letter S is capital */  
/* open a nam trace file in write mode */  
/* nf – nam file */  
/* tf- trace file */  
/* provide space b/w proc and finish and all are in small case */  
/* clears trace file contents */ close $nf  
/* creates 4 nodes */  
set n1 [$ns node]  
set n2 [$ns node]  
set n3 [$ns node]  
$ns duplex-link $n0 $n2 200Mb 10ms DropTail  
$ns duplex-link $n1 $n2 100Mb 5ms DropTail  
/*Letter M is capital Mb*/  
/*D and T are capital*/  
$ns duplex-link $n2 $n3 1Mb 1000ms DropTail  
$ns queue-limit $n0 $n2 10  
$ns queue-limit $n1 $n2 10  
set udp0 [new Agent/UDP]  /* Letters A,U,D and P are capital */  
$ns attach-agent $n0 $udp0  
set cbr0 [new Application/Traffic/CBR]  
/* A,T,C,B and R are capital*/  
$cbr0 set packetSize_ 500  
/*S is capital, space after underscore*/  
$cbr0 set interval_ 0.005  
$cbr0 attach-agent $udp0  
set udp1 [new Agent/UDP]  
$ns attach-agent $n1 $udp1  
set cbr1 [new Application/Traffic/CBR]  
$cbr1 attach-agent $udp1 
set udp2 [new Agent/UDP]  
$ns attach-agent $n2 $udp2  
set cbr2 [new Application/Traffic/CBR]  
$cbr2 attach-agent $udp2  
set null0 [new Agent/Null]  
/* A and N are capital */  
$ns attach-agent $n3 $null0  
$ns connect $udp0 $null0  
$ns connect $udp1 $null0  
$ns at 0.1 "$cbr0 start"  
$ns at 0.2 "$cbr1 start"  
DSATM,Dept.of CSE                                                   
2023-24 
Page 19 
Computer Network Laboratory (21CS52)                                                                                                     
$ns at 1.0 "finish"  
$ns run 
AWK file (Open a new editor using “vi command” and write awk file and save with “.awk” 
extension)  
/*immediately after BEGIN should open braces ‘{‘ */ 
BEGIN { c=0;  
}  
{  
if ($1= ="d")  
{  
c++;  
printf("%s\t%s\n",$5,$11);  
}  
}  
/*immediately after END should open braces ‘{‘ */ 
END{  
printf("The number of packets dropped =%d\n",c);  
} 
Steps for execution 
1) Open vi editor and type program. Program name should have the extension “ .tcl ”  
[root@localhost ~]# vi lab1.tcl 
2) Save the program by pressing “ESC key” first, followed by “Shift and :” keys simultaneously 
and type “wq” and press Enter key.  
3) Open vi editor and type awk program. Program name should have the extension “.awk ”  
[root@localhost ~]# vi lab1.awk 
4) Save the program by pressing “ESC key” first, followed by “Shift and :” keys simultaneously 
and type “wq” and press Enter key.  
5) Run the simulation program 
[root@localhost~]# ns lab1.tcl 
i) Here “ns” indicates network simulator. We get the topology shown in the snapshot.  
ii) Now press the play button in the simulation window and the simulation will begins.  
6) After simulation is completed run awk file to see the output ,  
[root@localhost~]# awk –f lab1.awk lab1.tr 
7) To see the trace file contents open the file  
[root@localhost~]# vi lab1.tr 
Trace file contains 12 columns:-  
Event type, Event time, From Node, Source Node, Packet Type, Packet Size, Flags (indicated 
by --------), Flow ID, Source address, Destination address, Sequence ID, Packet ID  
Topology



set ns [new Simulator]
set tf [open lab3.tr w]
$ns trace-all $tf
set nf [open lab3.nam w]
$ns namtrace-all $nf
set n0 [$ns node]
$n0 color "magenta"
$n0 label "src1"
set n1 [$ns node]
set n2 [$ns node]
$n2 color "magenta"
$n2 label "src2"
set n3 [$ns node]
$n3 color "blue"
$n3 label "dest2"
set n4 [$ns node]
set n5 [$ns node]
$n5 color "blue"
$n5 label "dest1"
$ns make-lan "$n0 $n1 $n2 $n3 $n4" 100Mb 100ms LL Queue/DropTail Mac/802_3
$ns duplex-link $n4 $n5 1Mb 1ms DropTail
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set packetSize_ 500
$ftp0 set interval_ 0.0001
set sink5 [new Agent/TCPSink]
$ns attach-agent $n5 $sink5
$ns connect $tcp0 $sink5
set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set packetSize_ 600
$ftp2 set interval_ 0.001
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
$ns connect $tcp2 $sink3
set file1 [open file1.tr w]
$tcp0 attach $file1
set file2 [open file2.tr w]
$tcp2 attach $file2
$tcp0 trace cwnd_ {
    puts $file1 "$ns now $tcp0 set cwnd_"
}
$tcp2 trace cwnd_ {
    puts $file2 "$ns now $tcp2 set cwnd_"
}
proc finish { } {
    global ns nf tf
    $ns flush-trace
    close $tf
    close $nf
    exec nam lab3.nam &
    exit 0
}
$ns at 0.1 "$ftp0 start"
$ns at 5 "$ftp0 stop"
$ns at 7 "$ftp0 start"
$ns at 0.2 "$ftp2 start"
$ns at 8 "$ftp2 stop"
$ns at 14 "$ftp0 stop"
$ns at 10 "$ftp2 start"
$ns at 15 "$ftp2 stop"
$ns at 16 "finish"
$ns run

BEGIN { 
    c = 0;
}

{ 
    if ($1 == "d") {  # Corrected the comparison operator to ==
        c++;
        printf("%s\t%s\n", $5, $11);
    }
}

END { 
    printf("The number of packets dropped = %d\n", c);
}