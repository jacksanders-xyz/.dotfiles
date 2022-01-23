commands =
  active : "/usr/local/bin/yabai -m query --spaces --space | /usr/local/bin/jq '.index'"
  list   : "/usr/local/bin/yabai -m query --spaces | /usr/local/bin/jq -r '.[].label'"
  monitor: ""

colors =
  acqua:   "#00d787"
  wine:    "#72003e"
  orange:  "#ff8700"
  silver:  "#e4e4e4"
  elegant: "#1C2331"
  magenta: "#af005f"
  cyan:    "#00afd7"
  tmuxblue: "#a0a0e2"
  tmuxtan: "#958978"
  nvimback: "#282c34"
  nvimwhite: "#e0e0e0"
  nvimred: "#7c0708"
  nvimyellow: "#959908"

command: "echo " +
          "$(#{commands.active}):::" +
          "$(#{commands.list}):::"

refreshFrequency: 10000000

render: () ->
  """
  <link rel="stylesheet" href="./ubersicht-polybar-widget/assets/font-awesome/css/all.css" />
  <div class="spaces">
    <div>1: Default</div>
  </div>
  """

update: (output) ->
  output = output.split( /:::/g )

  active = output[0]
  list   = output[1]

  @handleSpaces(list)
  @handleActiveSpace(Number (active))

handleSpaces: (list) ->
  $(".spaces").empty()
  list = " " + list
  list = list.split(" ")

  $.each(list, (index, value) ->
    if (index > 0)
      $(".spaces").append(
         """<div class="workspace" id="#{index}">#{index}:#{value}</div>"""
      )
      #$("<div>").prop("id", index).text("#{index}: #{value}").appendTo(".spaces")
  )

handleActiveSpace: (id) ->
  $("##{id}").addClass("active")

style: """
  .spaces
    display: flex
    align-items: stretch
    height: 13px

  .workspace
    display: flex
    color: #{colors.nvimwhite}
    align-items: center
    justify-content: center
    padding: 8px 8px

  .active
    color: #{colors.nvimback}
    background: #{colors.tmuxblue}

  top: 4px
  left: 14px
  font-family: 'Meslo LG S Regular for Powerline'
  font-size: 14px
  font-smoothing: antialiasing
  z-index: 0
"""
