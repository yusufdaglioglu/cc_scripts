TPUT_BOLD="$(tput bold)"
TPUT_WHITE="$(tput setf 7)"
COLOR_YELLOW="$TPUT_BOLD$TPUT_WHITE$(tput setab 3)" || exit 251
CC_COLOR_RESET="$(tput sgr 0)" || exit 250

___dev_print_screen() {
    # Only dev&test will call this function. So the output of functions will not conflict with dev&test output.
    printf "%s\n" "$COLOR_YELLOW$*$CC_COLOR_RESET"
}
