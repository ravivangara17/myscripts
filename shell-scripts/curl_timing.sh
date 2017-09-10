#! /bin/bash
mydir=$(mktemp -dt "$0")

temp=`basename $0`
TMPFILE=`mktemp -q /tmp/${temp}.XXXXXX`
if [ $? -ne 0 ]; then
       echo "$0: Can't create temp file, exiting..."
       exit 1
fi

cat > /"$TMPFILE"  << EOL
\n
           time_namelookup:  %{time_namelookup}\n
              time_connect:  %{time_connect}\n
           time_appconnect:  %{time_appconnect}\n
          time_pretransfer:  %{time_pretransfer}\n
             time_redirect:  %{time_redirect}\n
        time_starttransfer:  %{time_starttransfer}\n
                           ----------\n
                time_total:  %{time_total}\n
\n
EOL

printf  "Enter the domain name: "
read domain

curl -w @"$TMPFILE" -o /dev/null -s $domain
rm $TMPFILE
