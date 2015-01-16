#!/usr/bin/perl

# Ilan Kleiman
# January 15 2015
# Pretty Wicked.

# Enter your account cookie in cookie file...

print "Game ID # (remove unecessary spaces!):\n:";
chomp ($game = <STDIN>);

print "Your user ID:\n:";
chomp ($myuserid = <STDIN>);

begin:
print "\n\n=====================\n\n";
print "Press 'Enter' after pressing the continue button. Before spinning the wheel.\n\n";
chomp ($meow = <STDIN>);

$data = "{\"type\":\"NORMAL\",\"answers\":[{\"power_ups\":[\"EXTRA_TIME\"],\"id\":6777,\"category\":\"GEOGRAPHY\",\"answer\":0}]}";
$resp = `curl -s -b cookie -A 'Preguntados/1.9.3 (iPhone; iOS 8.1.2; Scale/2.00)' --data '$data' 'http://api.preguntados.com/api/users/$myuserid/games/$game/answers' `;

# if game type = crown, chomp user to input the category they want to do in crown.
# "normalType":true,"spins_data":{"spins":[{"type":"CROWN","questions"
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
            
            
            # "category":"GEOGRAPHY","text":"How many continents are on Planet Earth?","answers":["7","5","6","8"],"correct_answer":0,"media_type":"NORMAL"},

            if($category =~ "2")
            {
                ($category_info) = ($resp =~ /,\"category\":\"ARTS\"[^,]*,(.+)/);
            }
            if($category =~ "3")
            {
                ($category_info) = ($resp =~ /,\"category\":\"SPORTS\"[^,]*,(.+)/);
            }
            if($category =~ "1")
            {
                ($category_info) = ($resp =~ /,\"category\":\"ENTERTAINMENT\"[^,]*,(.+)/);
            }
            if($category =~ "4")
            {
                ($category_info) = ($resp =~ /,\"category\":\"HISTORY\"[^,]*,(.+)/);
            }
            if($category =~ "6") # Geography
            {
                ($category_info) = ($resp =~ /,\"category\":\"GEOGRAPHY\"[^,]*,(.+)/);
            }
            if($category =~ "5")
            {
                ($category_info) = ($resp =~ /,\"category\":\"SCIENCE\"[^,]*,(.+)/);
            }
                # "text":"Which was the craft that brought the first man to space?","answers":["Soyuz","Vostok","Salyut","Eagle"],"correct_answer":1,"media_type":"NORMAL"
                    ($question) = ($category_info =~ /text[^:]*:([^[]+)/);
                        $question =~ s/,"answers"://g;

                    ($answers) = ($category_info =~ /\"answers\"[^:]*:([^]]+)/); #\]
                        $answers = $answers."]";
                        $answers =~ s/,/]\n[/g;
#$answers =~ s/,/]\n[/g;
        #print ">>>$category_info<<<";
                    ($answer) = ($category_info =~ /\"correct_answer\"[^:]*:([^,]+)/);
                        $answer = $answer + 1;
    }
else
{
# Question, irrelevant.
        ($question) = ($resp =~ /text[^:]*:([^,]+)/);
    
# Answer choices are irrelevant.
        ($answers) = ($resp =~ /\"answers\"[^:]*:([^]]+)/);
            $answers = $answers."]";
# $answers =~ s/,\"author\"://g; #,"author":
            $answers =~ s/,/]\n[/g;

# Correct Answer: ,"correct_answer":0,"media_type":
        ($answer) = ($resp =~ /\"correct_answer\"[^:]*:([^,]+)/);
            $answer = $answer + 1;
}
            print "\nType: $type_of\n";
            print "\nQuestion: $question\n";
            print "$answers";
            print "\n\nAnswer is # $answer\n";
goto begin;





