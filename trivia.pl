#!/usr/bin/perl

# Ilan Kleiman
# January 15 2015
#  Trivial Crack
    # Make Game Version.

use File::Slurp;

print "Your user ID:\n:";
chomp ($myuserid = <STDIN>);

# Start Gamer

sub make_a_game
{
my ($myuserid) = @_;
    $data = "{\"language\":\"EN\"}";
$make_game = `curl -s -b cookie -A 'Preguntados/1.9.3 (iPhone; iOS 8.1.2; Scale/2.00)' --data '$data' 'http://api.preguntados.com/api/users/$myuserid/games' `;
}
begin:
$resp = read_file("playing_game_0.txt");

    # many ID's though; this is the first one always; afaik
    ($game) =  ($resp =~ /\"id\"[^:]*:([^,]+)/);
    
    ($type_of) = ($resp =~ /\"spins_data\":{\"spins\":[{\"type\"[^:]*:([^,]+)/);
    $type_of =~ s/\"//g;
            
            if($type_of =~ "CROWN")
    {
                print "Crown Match, Which category?\n";
                print "1 = Entertainment\n";
                print "2 = Art\n";
                print "3 = Sports\n";
                print "4 = History\n";
                print "5 = Science\n";
                print "6 = Geography\n";
                print "Type in the number that corresponds to the category of the character you chose. (then press enter)\n";
                print "Category #: ";
                chomp ($category = <STDIN>);
                
# Working some magic here (magic scroll updated 1-24-15 10:22 PM)
$resp_easy = $resp;
$year_of = 0;
industrialism:
$year_of = $year_of + 1;
    ($documentation) = ($resp_easy =~ /\"question\":[^{]*{([^{]+)/);
        ($categorization) = ($documentation =~ /\"category\":[^"]*"([^,]+)/);
        $categorization =~ s/"//g;
            ($layer_id) = ($documentation =~ /\"id\"[^:]*:([^,]+)/);
if ($categorization =~ /HISTORY/i)
{
    $q_history_id = $layer_id;
}
if ($categorization =~ /GEOGRAPHY/i)
{
    $q_geography_id = $layer_id;
}
if ($categorization =~ /ARTS/i)
{
    $q_arts_id = $layer_id;
}
if ($categorization =~ /SPORTS/i)
{
    $q_sports_id = $layer_id;
}
if ($categorization =~ /ENTERTAINMENT/i)
{
    $q_entertainment_id = $layer_id;
}
if ($categorization =~ /SCIENCE/i)
{
    $q_science_id = $layer_id;
}
$resp_easy =~ s/"question"/WONDERFUL $categorization DATA GOES HERE/;
if ($year_of !~ 6)
{
    goto industrialism;
}
# End magic 

            if($category =~ "1")
            {
                ($category_info) = ($resp =~ /,\"category\":\"ENTERTAINMENT\"[^,]*,(.+)/);
                $cat_name = "ENTERTAINMENT";
                $question_id = $q_entertainment_id;
            }
            if($category =~ "2")
            {
                ($category_info) = ($resp =~ /,\"category\":\"ARTS\"[^,]*,(.+)/);
                $cat_name = "ARTS";
                $question_id = $q_arts_id;
            }
            if($category =~ "3")
            {
                ($category_info) = ($resp =~ /,\"category\":\"SPORTS\"[^,]*,(.+)/);
                $cat_name = "SPORTS";
                $question_id = $q_sports_id;
            }
            if($category =~ "4")
            {
                ($category_info) = ($resp =~ /,\"category\":\"HISTORY\"[^,]*,(.+)/);
                $cat_name = "HISTORY";
                $question_id = $q_history_id;
            }
            if($category =~ "5")
            {
                ($category_info) = ($resp =~ /,\"category\":\"SCIENCE\"[^,]*,(.+)/);
                $cat_name = "SCIENCE";
                $question_id = $q_science_id;
            }
            if($category =~ "6") 
            {
                ($category_info) = ($resp =~ /,\"category\":\"GEOGRAPHY\"[^,]*,(.+)/);
                $cat_name = "GEOGRAPHY";
                $question_id = $q_geography_id;
            }
                    ($question) = ($category_info =~ /text[^:]*:([^[]+)/);
                        $question =~ s/,"answers"://g;
                    ($answers) = ($category_info =~ /\"answers\"[^:]*:([^]]+)/);
                        $answers = $answers."]";
                        $answers =~ s/,/]\n[/g;
                    ($answer) = ($category_info =~ /\"correct_answer\"[^:]*:([^,]+)/);
    }
else
    {
            ($question) = ($resp =~ /text[^:]*:([^,]+)/);
            ($answers) = ($resp =~ /\"answers\"[^:]*:([^]]+)/);
                $answers = $answers."]";
                $answers =~ s/,/]\n[/g;
            ($answer) = ($resp =~ /\"correct_answer\"[^:]*:([^,]+)/);
            ($question_id) = ($resp =~ /,\"questions\":[{\"question\":{\"id\"[^:]*:([^,]+)/);
            ($cat_name) = ($resp =~ /\"id\":$question_id,\"category\"[^:]*:([^,]+)/);
                $cat_name =~ s/"//g;
    }

    # Answer it:
    $trial = 0;
    $data_2 = "{\"type\":\"$type_of\",\"answers\":[{\"id\":$question_id,\"answer\":$answer,\"category\":\"$cat_name\"}]}";
                remix:
    $resp_2 = `curl -s -b cookie -A 'Preguntados/1.9.3 (iPhone; iOS 8.1.2; Scale/2.00)' --data '$data_2' 'http://api.preguntados.com/api/users/$myuserid/games/$game/answers'`;

    if($resp_2 =~ /Status page/)
    {
        if($trial =~ "6")
        {
            die "6 failed server request. A script error may be responsible...\n";
        }
        print "\nRequest Failed. Trying again..\n";
        $trial = $trial + 1;
        goto remix;
    }

    open(my $file, '>', "playing_game_0.txt");
    print $file $resp_2;
    close $file;

print $data_2."\n\n";
#print $resp_2;
#goto begin;



