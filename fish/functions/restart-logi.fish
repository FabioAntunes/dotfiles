function restart-logi -d "restarts the logitech mx daemon"
    launchctl kickstart -k gui/501/com.logitech.manager.daemon
end
