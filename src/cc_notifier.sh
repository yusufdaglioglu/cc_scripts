c_notify_user_HELP_ONLY() {
   ___print_title USAGE
   ___print_screen 'sleep 2 ; c_notify_user 1 hello'
}

c_notify_user() {

   # TEST COMMAND:
   # $(return 7); c_notify_user 0.1 test

   # store last exit code
   local -r LAST_COMMAND_EXIT_CODE="$?"

   ##############################
   # FUNCTION PARAMETERS
   ##############################
   local -r TIME_TO_BEEP="$1"
   local -r MESSAGE="$2"
   ##############################
   ##############################
   ##############################

   ___print_screen "$MESSAGE"

   # MacOS GUI notification
   ___do_executables_exist_without_output "osascript" && { osascript -e "display notification \""$MESSAGE"\" with title "cc_scripts" "; }

   # Linux GUI notification
   ___do_executables_exist_without_output "notify-send" && { notify-send "$MESSAGE" --app-name "cc_scripts"; }

   local -r MS_WINDOWS_NOTIFY_COMMANDS='
   [reflection.assembly]::loadwithpartialname("System.Windows.Forms")
   [reflection.assembly]::loadwithpartialname("System.Drawing")
   $notify = new-object system.windows.forms.notifyicon
   $notify.icon = [System.Drawing.SystemIcons]::Information
   $notify.visible = $true
   $notify.showballoontip(20,"cc_scripts","'$MESSAGE'",[system.windows.forms.tooltipicon]::None)
   '

   ___do_executables_exist_without_output "powershell" && { powershell -c "$MS_WINDOWS_NOTIFY_COMMANDS"; }

   ___do_executables_exist_without_output "speaker-test" "timeout" || return $LAST_COMMAND_EXIT_CODE

   ___is_empty_string "$TIME_TO_BEEP" && TIME_TO_BEEP="3"

   timeout --kill-after="$TIME_TO_BEEP" 1 speaker-test --frequency 1000 --test sine >"/dev/null"

   # always return success. This a simple notification function. It should not block the parent script.
   return $LAST_COMMAND_EXIT_CODE
}
