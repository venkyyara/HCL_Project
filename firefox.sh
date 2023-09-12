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
Firefox_Search
