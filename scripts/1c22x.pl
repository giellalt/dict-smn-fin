#!/usr/bin/perl -w
use utf8 ;

# Simple script to convert csv to xml
# For input/outpus examples, see below.


print STDOUT "<r>\n";

while (<>) 
{
	chomp ;
	my ($lemma, $trans1, $trans2, $POS) = split /\t/ ;
	print STDOUT "   <e>\n";
	print STDOUT "      <lg>\n";
	print STDOUT "         <l pos=\"$POS\">$lemma</l>\n";
	print STDOUT "      </lg>\n";
	print STDOUT "      <mg>\n";
	print STDOUT "         <tg xml:lang=\"fin\">\n";
	print STDOUT "            <t pos=\"$POS\">$trans1</t>\n";
	print STDOUT "         </tg>\n";
	print STDOUT "      </mg>\n";
	print STDOUT "      <mg>\n";
	print STDOUT "         <tg xml:lang=\"fin\">\n";
	print STDOUT "            <t pos=\"$POS\">$trans2</t>\n";
	print STDOUT "         </tg>\n";
	print STDOUT "      </mg>\n";
	print STDOUT "   </e>\n";
}

print STDOUT "</r>\n";



# Example input:
#
# aampumakenttä	N	skytefelt


#Target output:
#
#   <e src="yr">
#      <lg>
#         <l pos="N">aampumakenttä</l>
#      </lg>
#      <mg>
#         <tg>
#            <t pos="N">skytefelt</t>
#         </tg>
#      </mg>
#      <mg>
#         <tg xml:lang="fin">
#            <t pos="N">skytebane</t>
#         </tg>
#      </mg>
#   </e>
#

