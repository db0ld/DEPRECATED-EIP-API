#!/bin/bash
## ########################################################################## ##
## Project: La Vie Est Un Jeu - API                                           ##
## Description: Installation script                                           ##
## Author: db0 (db0company@gmail.com, http://db0.fr/)                         ##
## Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/Website      ##
## ########################################################################## ##

port=$(($UID+1000))
conf='api.conf'

function	edit_conf_file() {
    file=$1
    port=$2
    pwd=`pwd | sed 's#\/#\\\/#g'`

    if [ -e .$file.bak ]
    then mv .$file.bak $file
    fi

    cp $file .$file.bak && \
	sed -i".tmp" 's/\$PORT/'$port'/' $file && \
	sed -i".tmp" 's/\$USER/'$USER'/' $file && \
	sed -i".tmp" 's/\$PWD/'$pwd'/' $file && \
	echo -n "Your PostgreSQL login ("$USER")? " && \
	read dblogin && \
	if [ -z $dblogin ]
         then sed -i".tmp" 's/\$DBLOGIN/'$USER'/' $file
         else sed -i".tmp" 's/\$DBLOGIN/'$dblogin'/' $file
        fi && \
	echo -n "Your PostgreSQL password? " && \
	read dbpassword && \
        sed -i".tmp" 's/\$DBPASSWORD/'$dbpassword'/' $file
	echo -n "The name of the database? " && \
	read dbname && \
        sed -i".tmp" 's/\$DBNAME/'$dbname'/' $file
	rm *.tmp && \
	return 0
    return 1
}

echo -n "Install Modules... " && \

    if [ -e "tools.eliom" ]
     then rm -f "tools.eliom" "tools.eliomi"
    fi && \
    wget "https://raw.github.com/db0company/OcsiTools/master/tools.eliom" && \
    wget "https://raw.github.com/db0company/OcsiTools/master/tools.eliomi" && \

    if [ -e "otools.ml" ]
     then rm -f "otools.ml" "otools.mli"
    fi && \
    wget "https://raw.github.com/db0company/OcsiTools/master/otools.ml" && \
    wget "https://raw.github.com/db0company/Ocsitools/master/otools.mli" && \

    echo "Done." && \

    echo "Edit configuration file... " && \
    edit_conf_file $conf $port && \
    echo "Done." && \
    echo "LaVieEstUnJeu API has been correctly installed. Now you can:" && \
    echo "- Compile the API using \"make\"." && \
    echo "- Launch the server using \"ocsigenserver -c $conf\"" && \
    echo "- Open the API on your browser: http://life.paysdu42.fr:"$port"/"

