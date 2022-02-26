#!/usr/local/bin/perl
#
#
#  _____________________________
#  \_   ___ \__    ___/   _____/
#  /    \  \/ |    |  \_____  \ 
#  \     \____|    |  /        \
#   \______  /|____| /_______  /
#          \/                \/ 
#
#       .:: Version 3.0 ::.
#      +++++++++++++++++++++
#      + Coded by Perforin +
#      +++++++++++++++++++++
#      |                   |
#      |  Coderz from Hell |
#      |   dark-codez.org  |
#      |                   |
#      |___________________|
#      |                   |
#      |  Crypt This Shit  |
#      |___________________|
#      \                   /
#       \    Greetings    /
#        \      PLA      /
#         \     SoH     /
#          \    DCC    /
#           \_________/
#
#          
#
#
use Digest::MD5 qw(md5 md5_hex md5_base64);
use MIME::Base64;

my $version = 3.0;
my @supported = ('-md5', '-base64', 'rot13', '-perfo1');

print qq !

    ><<   ><<< ><<<<<<  ><< <<  
 ><<   ><<     ><<    ><<    ><<
><<            ><<     ><<      
><<            ><<       ><<    
><<            ><<          ><< 
 ><<   ><<     ><<    ><<    ><<
   ><<<<       ><<      ><< <<  
                                         

         Crypt This Shit

!;
if ($ARGV[0] =~ "-md5")
{
print qq !

MD5 (Message-Digest Algorithm 5) ist eine weit 
verbreitete kryptographische 
Hash-Funktion, die einen 128-Bit-Hashwert erzeugt. 
MD5 wurde 1991 von Ronald L. Rivest entwickelt. 
Die errechneten MD5-Summen (kurz md5sum) 
werden zum Beispiel zur Integritätsprüfung von 
Dateien eingesetzt.


!;
print "String oder Datei konverten?[S/D]: \n\n";
$antwort = <STDIN>;
chop($antwort);
if ($antwort =~ /[sS]/) {
print "Bitte String eintippen um zu konverten: \n\n";
$string=<STDIN>;
chop($string);
$md5 = Digest::MD5->new;
$md5->add("$string");
$digest = $md5->hexdigest and print "\nHash: $digest\n\n";
exit;
} elsif ($antwort =~ /[dD]/) {
print "Bitte Pfad zur Datei angeben: \n\n";
$datei = <STDIN>;
chop($datei);
open(File,"<$datei") || print "Datei nicht gefunden!\n";
@Inhalt = <File>;
close(File);
open(File,">$datei") || print "Datei nicht gefunden!\n";
foreach $string (@Inhalt) {
$md5 = Digest::MD5->new;
$md5->add("$string");
$digest = $md5->hexdigest;
print "$digest";
print "\n";
print File "$digest";
print File "\n";
}
close(File);
exit();
}
} elsif ($ARGV[0] =~ "-rot13") {

print qq !

ROT13 (engl. rotate by 13 places, zu deutsch 
in etwa ?rotiere um 13 Stellen?) ist eine 
Verschiebechiffre (auch Caesarchiffre genannt),
mit der auf einfache Weise Texte verschlüsselt
werden können. Dies geschieht durch Ersetzung 
von Buchstaben ? bei ROT13 im speziellen wird 
jeder Buchstabe des lateinischen Alphabets 
durch den im Alphabet um 13 Stellen davor
bzw. dahinter liegenden Buchstaben ersetzt.


!;

print "String oder Datei konverten?[S/D]: \n\n";
$antwort = <STDIN>;
chop($antwort);
if ($antwort =~ /[sS]/) {
print "Bitte String eintippen um zu konverten:\n\n";
$string=<STDIN>;
chop($string);

open(String, ">>file.txt");
print String "$string";
close(String);

($produkt, $rot);

my $file="file.txt";

open (DAFILE, "$file") || print "Datei nicht gefunden!\n";

while (<DAFILE>) {
    foreach (split //) {
        if (/[a-m]/i) {
            $rot = +13;
        } elsif (/[n-z]/i) {
            $rot = -13;
        } else {
            $rot = 0;
        }
        $produkt .= chr(ord() + $rot);
    }
}
close(DAFILE);

print"\nKodiert: $produkt\n\n";

unlink('$file');
exit;
} elsif ($antwort =~ /[dD]/) {
print "Bitte Pfad zur Datei angeben: \n\n";
$datei = <STDIN>;
chop($datei);
open(File,"<$datei") || print "Datei nicht gefunden!\n";

while (<File>) {
foreach (split //) {
        if (/[a-m]/i) {
            $rot = +13;
        } elsif (/[n-z]/i) {
            $rot = -13;
        } else {
            $rot = 0;
        }
        $produkt .= chr(ord() + $rot);
		}
}
close(File);

open(File,">$datei") || print "Datei nicht gefunden!\n";
		print "$produkt";
        print "\n";
		print File "$produkt";
        print File "\n";
		
close(File);

exit();
}
} elsif ($ARGV[0] =~ "-base64") {

print qq !

Base64 ist ein Begriff aus dem Computerbereich
und beschreibt ein Verfahren zur Kodierung 
von 8-Bit-Binärdaten (z. B. ausführbare Programme,
ZIP-Dateien), in eine Zeichenfolge, 
die nur aus wenigen, Codepage-unabhängigen
ASCII-Zeichen besteht. Im Zusammenhang mit 
OpenPGP wird noch eine Prüfsumme (CRC-24) 
angehängt, dieses leicht modifizierte 
Verfahren trägt den Namen Radix-64.


!;

print "Kodieren oder Dekodieren?[K/D]:\n\n";
$question=<STDIN>;
chop($question);
if ($question =~ /[kK]/) {
print "Einfacher String oder Datei?[S/D]:\n\n";
$antwort=<STDIN>;
chop($antwort);
if ($antwort =~ /[sS]/) {
print "Bitte String eintippen um zu konverten:\n\n";
$string=<STDIN>;
chop($string);
$encoded = encode_base64("$string");
print "\nKodiert: $encoded\n\n";
exit;
} elsif ($antwort =~ /[dD]/) {
print "Pfad zur Datei eingeben: \n\n";
$datei=<STDIN>;
chop($datei);
open(File,"<$datei") || print "Datei nicht gefunden!\n";
@Inhalt = <File>;
close(File);
open(File,">$datei");
foreach $string (@Inhalt) {
$encoded = encode_base64("$string");
print "$encoded";
print "\n";
print File "$encoded";
print File "\n";
exit;
}
}
} elsif ($question =~ /[dD]/) {
print "Einfacher String oder Datei?[S/D]:\n\n";
$antwort=<STDIN>;
chop($antwort);
if ($antwort =~ /[sS]/) {
print "Bitte String eintippen um zu konverten:\n\n";
$string=<STDIN>;
chop($string);
$decoded = decode_base64("$string");
print "\nKodiert: $decoded\n\n";
exit;
} elsif ($antwort =~ /[dD]/) {
print "Pfad zur Datei eingeben: \n\n";
$datei=<STDIN>;
chop($datei);
open(File,"<$datei") || print "Datei nicht gefunden!\n";
@Inhalt = <File>;
close(File);
open(File,">$datei");
foreach $string (@Inhalt) {
$decoded = decode_base64("$string");
print "$decoded";
print "\n";
print File "$decoded";
print File "\n";
}
}
}
exit();

} elsif ($ARGV[0] =~ "-perfo1") {

print qq !


perfo1 wurde in der Nacht vom 7.8.07 erfunden
von nem gelangweilten Coder namens Perforin.
In dieser fruehen Form der Kodierung kann man
nur Alpha sowie loweralpha kodieren.Die laenge
des Input ist gleich dem Output.Der Name kommt
von seinem Erfinder und Coder.


!;
print "Kodieren oder Dekodieren?[K/D]:\n\n";
$question=<STDIN>;
chop($question);
if ($question =~ /[kK]/) {
print "String oder Datei konverten?[S/D]: \n\n";
$antwort = <STDIN>;
chop($antwort);
if ($antwort =~ /[sS]/) {
print "Bitte String eintippen um zu konverten:\n\n";
$string=<STDIN>;
chop($string);

open(String, ">file.txt");
print String "$string";
close(String);

my $file="file.txt";

open (FILE,"<$file") || print "Datei nicht gefunden!\n";
@inhalt = <FILE>;
close(FILE);
foreach $word (@inhalt) {
$word =~ tr/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/=132![#47_:56.98,+0%><~?]^=132![#47_:56.98,+0%><~?]^/;
print"\nKodiert: ";
print "$word\n\n";
}

unlink('$file');
exit;
} elsif ($antwort =~ /[dD]/) {
print "Bitte Pfad zur Datei angeben: \n\n";
$datei = <STDIN>;
chop($datei);

open (FILE,"<$datei") || print "Datei nicht gefunden!\n";
@inhalt = <FILE>;
close(FILE);
open (FILE,">$datei");
foreach $string (@inhalt) {
$string =~ tr/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/=132![#47_:56.98,+0%><~?]^=132![#47_:56.98,+0%><~?]^/;
print FILE "$string";
print "$string";
}
close(FILE);
exit();
}
} elsif ($question =~ /[dD]/) {
print "String oder Datei konverten?[S/D]: \n\n";
$antwort = <STDIN>;
chop($antwort);
if ($antwort =~ /[sS]/) {
print "Bitte String eintippen um zu konverten:\n\n";
$string=<STDIN>;
chop($string);

open(String, ">file.txt");
print String "$string";
close(String);

my $file="file.txt";

open (FILE,"<$file") || print "Datei nicht gefunden!\n";
@inhalt = <FILE>;
close(FILE);
foreach $word (@inhalt) {
$word =~ tr/=132![#47_:56.98,+0%><~?]^=132![#47_:56.98,+0%><~?]^/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/;
print "\nDekodiert: ";
print "$word";
}

unlink('$file');
exit;
} elsif ($antwort =~ /[dD]/) {
print "Bitte Pfad zur Datei angeben: \n\n";
$datei = <STDIN>;
chop($datei);

open (FILE,"<$datei") || print "Datei nicht gefunden!\n";
@inhalt = <FILE>;
close(FILE);
open (FILE,">$datei");
foreach $string (@inhalt) {
$string =~ tr/=132![#47_:56.98,+0%><~?]^=132![#47_:56.98,+0%><~?]^/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/;
print FILE "$string";
print "$string";
}
close(FILE);
exit();
}
}
} else {
print "   **************************\n";
print "   *                        *\n";
print "   *Unterstuetze Kodierungen*\n";
print "   *                        *\n";
print "   * -base64                *\n";
print "   * -md5                   *\n";
print "   * -rot13                 *\n";
print "   * -perfo1                *\n";
print "   **************************\n";
}

# Es ist ein Ding der Unmöglichkeit, ordentliche Cryptions
# für Windows unter Perl anzubieten, da die Perl Module
# dafür, nur für Linux gemacht worden sind und ich so
# keine weiteren Kodierungen etc als diese Anbieten kann.
# Wenn jemand Cryption Module für Windows hat , bitte 
# melden!
#
# MAIL: perforin@warezmail.net
#
