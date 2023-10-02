File_Management(){
echo "Menu"
echo "-----------------------------------------------------------------------"
echo "|        1:File Search in any directory from home directory            |"
echo "|        2:Directory Search                                            |"
echo "|        3:Path of the file/directory                                  |"
echo "|        4:Create a File                                               |"
echo "|        5:Create a Directory                                          |"
echo "|        6:Rename a file                                               |"
echo "|        7:Rename a directory                                          |"
echo "|        8:Remove a file                                               |"
echo "|        9:Remove a directory                                          |"
echo "|        10:Return to Menu                                             |"
echo "|        11:Exit                                                       |"
echo "-----------------------------------------------------------------------"
file_search(){
	printf "\n Please enter a file name:"
	read fle
	if find -name $fle -print -quit |
   	   grep -q '^'; then
	  echo "the file exists!"
	else
	  echo "the file does not exist!"
	fi
}
directory_search(){
	echo "\n Please enter a Directory name:"
	read dir
	if find -depth -name $dir -print -quit |
	   grep -q '^'; then
	  echo "the Directory exists!"
	else
	  echo "the Directory does not exist!"
	fi
}
path(){
	echo "Enter file name:"
	read file1
	x=$(find $(pwd) -name $file1)
	if find -name $file1 -print -quit |
   	   grep -q '^'; then
	  echo "$x"
	else
		echo "the file does not exist!"
	fi
}
create_file(){
	echo "Enter the file name u want to create:"
	echo "NOTE: CLICK 'CTRL+D' TO SAVE THE FILE IN THE SYSTEM"
	read fle1
	if [ -f $fle1 ]; then
		echo "File already exist"
	else 
		$(cat > $fle1)
		echo "File Created Successfully"
	fi
}
create_directory(){
	echo "Enter the directory name u want to create:"
	read dir
	if [ -f $dir ]; then
		echo "Directory already exist"
	else 
		$(mkdir $dir)
		echo "Directory Created Successfully"
	fi
}
rename_file(){
	read -p "Enter the original filename to rename:" original
	read -p "Enter the renamed filename to rename:" rename
	if [ -f $original ]; then
     		$(mv $original $rename)
     		echo "The file is renamed."
     	else
     		echo "Enter valid file name"
	fi
}
rename_directory(){
	read -p "Enter the original directory name to rename:" original
	read -p "Enter the renamed directory name to rename:" rename
	if [ -d $original ]; then
     		$(mv $original $rename)
     		echo "The directory is renamed."
     	else
     		echo "Enter valid directory name"
	fi
}
remove_file(){
	read -p "Enter the file name to remove:" ffle
	if [ -f $ffle ]; then
		$(rm $ffle)
		echo "File removed successfully"
	else
		echo "Enter valid file name"
	fi
}
remove_directory(){
	read -p "Enter the Directory name to remove:" ffle
	if [ -d $ffle ]; then
		$(rm -d $ffle)
		echo "Directory removed successfully"
	else
		echo "Enter valid directory name"
	fi
}
read -p "Enter the choice:" char
case $char in
	"1")
	file_search
	;;
	"2")
	directory_search
	;;
	"3")
	path
	;;
	"4")
	create_file
	;;
	"5")
	create_directory
	;;
	"6")
	rename_file
	;;
	"7")
	rename_directory
	;;
	"8")
	remove_file
	;;
	"9")
	remove_directory
	;;
	"10")
	return_menu
	;;
	"11")
	exit
	;;
esac
}
Firefox_Search(){
echo "Firefox Search"
echo "Menu"
echo "----------------------------------------------"
echo "|        1:Search for an information         |"
echo "|        2:Serch for an url                  |"
echo "|        3:Return to menu                    |"
echo "|        4:Exit                              |"
echo "----------------------------------------------"
read char
case $char in
	"1")
	read -p "What do u want to search for:" str
	$(firefox -search "$str")
	;;
	"2")
	read -p "Enter the url u want to visit for in firefox:" str
	$(firefox -search -url "$str")
	;;
	"3")
	return_menu
	;;
	"4")
	exit
	;;
esac
}
System(){
sysinfo(){
echo "--------------------------"
echo "|   SYSTEM INFORMATION   |"
echo "--------------------------"
echo "Hello, $LOGNAME"
echo "User is $(whoami)"
echo "Current directory = $(pwd)"
echo "Networkname and node name = $(uname -n)"
echo "Kernal name = $(uname -s)"
}
addresses(){
echo "Logic and Physical Addresses"
echo "$(ifconfig -a)"
}
echo "Menu"
echo "-------------------------------------------------"
echo "|           1:System Information                |"
echo "|           2:Logic and Physical Addresses      |"
echo "|           3:Return Menu                       |"
echo "|           4:Exit                              |"
echo "-------------------------------------------------"
read -p "Enter your choice:" char
sleep 0.3
case $char in
	"1")
	sysinfo
	;;
	"2")
	addresses
	;;
	"3")
	return_menu
	;;
	"4")
	exit
	;;
esac
}
whatsapp(){
echo "========================================================================="
echo "I can open the chat of your whatsapp that u want in web"
echo "NOTE: Make sure u login to your whatsapp web and close the tab"
echo "Type 'exit' to exit"

sleep 2
read -p "Enter the mobile number of the chat u want to open: " pno
if [ $pno != 'exit' ]
	then
	link="https://web.whatsapp.com/send?phone=$pno"
	$(firefox -search -url $link)
else
exit
fi
}
system_handling(){
echo "Menu"
echo "1:Poweroff"
echo "2:Restart"
echo "3:Main Menu"
echo "4:exit"
read -p "Enter your choice:" char
case $char in
	"1")
	echo "Shutting down the system in 5 seconds"
	sleep 5
	$(poweroff)
	;;
	"2")
	echo "Restarting in 5 seconds"
	sleep 5	
	$(reboot)
	;;
	"3")
	return_menu
	;;
	"4")
	exit
	;;
esac
}
pswd_manager(){
echo "MENU"
echo "------------------------------------------"
echo "|           1. Save a password           |"
echo "|           2. View password             |"
echo "|           3. Delete password           |"
echo "|           4. Return to Menu            |"
echo "|           5. Exit                      |"
echo "------------------------------------------"
read -p "Enter choice:" char
case $char in
    "1")
        read -p "Enter a username:" usr
        read -p "Enter password:" pswd
        read -p "Enter app for reference:" appp
        database_file="database.db"
        sqlite3 "$database_file" <<EOF
        INSERT INTO store (username, password, app) VALUES ('$usr', '$pswd', '$appp');
EOF
        sleep 1
        echo "Values added to the database successfully"
        ;;
    "2")
        read -p "Enter app name (reference):" app_name
        database_file="database.db"
        sqlite3 -column -header "$database_file" <<EOF
        SELECT * FROM store WHERE app = '$app_name';
EOF
        ;;
        "3")
        read -p "Enter app name (reference):" app_name
        database_file="database.db"
        sqlite3 "$database_file" <<EOF
        DELETE FROM store WHERE app = '$app_name';
EOF
	sleep 1
	echo "Deleted successfully."        
	;;
        "4")
	return_menu
	;;
	"5")
	exit
	;;
esac
}
return_menu(){
a=1
while [ $a -eq 1 ]
do
sleep 0.3
echo "------------------------------------------"
echo "Welcome. This is your SYSTEM BOT reporting."
echo "------------------------------------------"
echo "Things I can do."
echo "---------------------"
echo "|1.File Management  |"
echo "|2.Firefox Search   |"
echo "|3.System info      |"
echo "|4.Password Manager |"
echo "|5.System handling  |"
echo "|6.Date and Time    |"
echo "|7.Whatsapp chat    |"
echo "|8.Exit             |"
echo "---------------------"
echo "Select one option which u want me to do"
read ch
case $ch in 
	"1")
	while [ $a = 1 ]
	do
	sleep 0.5
	File_Management
	done
	;;
	"2")
	while [ $a = 1 ]
	do
	sleep 0.3
	Firefox_Search
	done
	;;
	"3")
	while [ $a = 1 ]
	do
	sleep 0.5
	System
	done
	;;
	"7")
	while [ $a = 1 ]
	do
	sleep 0.5
	whatsapp
	done
	;;
	"5")
	while [ $a = 1 ]
	do
	sleep 0.5
	system_handling
	done
	;;
	"6")
	current_date=$(date +"%Y-%m-%d")
	Time=$(date +"%H:%M:%S")
	echo "Date: $current_date"
	echo "Time: $Time"
	;;
	"4")
	while [ $a = 1 ]
	do
	sleep 0.5
	pswd_manager
	done
	;;
	"8")
	a=$((a + 1))
	continue
	;;
esac
done
}
return_menu
