function rn --description 'Prints today and current month'
    date "+%l:%M%p on %A, %B %e, %Y"
    echo
    cal | grep -E "\b$(date '+%e')\b| "
end
