commands =
  battery: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto " +
            "| cut -f1 -d';'"
  charging: "pmset -g batt | grep -c 'AC'"
  time   : "date +\"%l:%M\""
  wifi   : "/System/Library/PrivateFrameworks/Apple80211.framework/" +
            "Versions/Current/Resources/airport -I | " +
            "sed -e \"s/^ *SSID: //p\" -e d"
  date   : "date +\"%a %d %b\""
  volume : "osascript -e 'output volume of (get volume settings)'"
  input : "osascript -e 'input volume of (get volume settings)'"
  cpu    : "ESC=`printf \"\e\"`; ps -A -r -o %cpu | awk '{s+=$1} END {printf(\"%05.2f\",s/8);}'"
  disk   : "df -H -l / | awk '/\\/.*/ { print $5 }'"

colors =
  black   : "#3B4252"
  gray    : "#5C5C5C"
  red     : "#BF616A"
  green   : "#A3BE8C"
  blue    : "#81A1C1"
  timecolor: "#0a5ebf"
  cyan    : "#88C0D0"
  silver:  "#e4e4e4"
  elegant: "#1C2331"
  magenta: "#af005f"
  cyan:    "#00afd7"
  tmuxblue: "#a0a0e2"
  tmuxtan: "#b9aa95"
  nvimback: "#282c34"
  white: "#e0e0e0"
  nvimred: "#7c0708"
  yellow: "#bfbf09"
  yellow2: "#e1f408"


command: "echo " +
          "$(#{commands.battery}):::" +
          "$(#{commands.charging}):::" +
          "$(#{commands.time}):::" +
          "$(#{commands.wifi}):::" +
          "$(#{commands.volume}):::" +
          "$(#{commands.input}):::" +
          "$(#{commands.date}):::" +
          "$(#{commands.cpu}):::" +
          "$(#{commands.disk}):::"

refreshFrequency: 10000

render: () ->
  """
  <link rel="stylesheet" href="./ubersicht-polybar-widget/assets/font-awesome/css/all.css" />
  <div class="elements">
    <div class="input">
      <span>
        <span class="mic-icon"></span>
        <span class="volume-input"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="volume">
      <span>
        <span class="volume-icon"></span>
        <span class="volume-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="cpu">
      <span>
        <i class="fa fa-chart-area"></i>
        <span class="cpu-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="disk">
      <span>
        <i class="fa fa-hdd"></i>
        <span class="disk-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="wifi">
      <span>
        <i class="fa fa-wifi"></i>
        <span class="wifi-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="battery">
      <span>
        <span class="battery-icon"></span>
        <span class="battery-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="date">
      <span>
        <i class="fa fa-calendar"></i>
        <span class="date-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="time">
      <span>
        <i class="fa fa-clock"></i>
        <span class="time-output"></span>
      </span>
    </div>
  </div>
  """

update: (output) ->

  #console.log(output)
  output = output.split( /:::/g )

  battery  = output[0]
  charging = output[1]
  time     = output[2]
  wifi     = output[3]
  volume   = output[4]
  input    = output[5]
  date     = output[6]
  cpu      = output[7]
  disk     = output[8]

  $(".battery-output") .text("#{battery}")
  $(".time-output")    .text("#{time}")
  $(".wifi-output")    .text("#{wifi}")
  $(".volume-output")  .text("#{volume}%")
  $(".volume-input")   .text("#{input}%")
  $(".date-output")    .text("#{date}")
  $(".cpu-output")     .text("#{cpu}%")
  $(".disk-output")    .text("#{disk}")

  @handleBattery(Number(battery.replace( /%/g, "")), charging == '1')
  @handleVolume(Number(volume))
  @handleInput(Number(input))

handleBattery: ( percentage, charging ) ->
  if charging
    $(".battery-icon").html("<i class=\"fas fa-bolt \"></i>")
    return

  batteryIcon = switch
    when percentage <=  12 then "fa-battery-0"
    when percentage <=  25 then "fa-battery-1"
    when percentage <=  50 then "fa-battery-2"
    when percentage <=  75 then "fa-battery-3"
    when percentage <= 100 then "fa-battery-4"

  $(".battery-icon").html("<i class=\"fa #{batteryIcon} \"></i>")


handleVolume: (volume) ->
  volumeIcon = switch
    when volume ==   0 then "fa-volume-off"
    when volume <=  50 then "fa-volume-down"
    when volume <= 100 then "fa-volume-up"
  $(".volume-icon").html("<i class=\"fa #{volumeIcon}\"></i>")

handleInput: (volume) ->
  micIcon = switch
    when volume ==   0 then "fa-microphone-slash"
    when volume <= 100 then "fa-microphone"
  $(".mic-icon").html("<i class=\"fa #{micIcon}\"></i>")


style: """

  .elements
    display: flex
    align-items: stretch
    height: 14px
    margin: 0 4px

  .elements > div
    display: flex
    align-items: center
    padding: 2px 2px
    margin: 0px auto

  .spacer
    color: #{colors.gray}

  .battery
    color: #{colors.green}
  .time
    color: #{colors.timecolor}
  .wifi
    color: #{colors.white}
  .volume
    color: #{colors.cyan}
  .date
    color: #{colors.yellow}
  .cpu
    color: #{colors.cyan}
  .volume
    color: #{colors.yellow}
  .input
    color: #{colors.yellow}
  .disk
    color: #{colors.tmuxtan}

  top: 1px
  right: 14px
  font-family: 'Meslo LG S Regular for Powerline'
  font-size: 14px
  font-smoothing: antialiasing
  z-index: 0
"""
