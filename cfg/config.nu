def --env --wrapped fm [...args: string] { 
  cd (lf -print-last-dir ...$args)
}

$env.config = {
  menus: [
    {
      name: abbr_menu
      only_buffer_difference: false
      marker: none
      type: {
        layout: columnar
        columns: 1
        col_width: 20
        col_padding: 2
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
      source: { |buffer, position|
        let match = (scope aliases | where name == $buffer)
        if ($match | is-empty) { {value: $buffer} } else { $match | each { |it| {value: ($it.expansion) }} }
      }
    }
  ]
  keybindings: [
    {
      name: abbr_menu
      modifier: none
      keycode: space
      mode: [emacs, vi_insert]
      event: [
        { send: menu name: abbr_menu }
        { edit: insertchar value: ' '}
      ]
    }
    {
      name: fzf_cd_widget
      modifier: alt
      keycode: char_c
      mode: [emacs, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "cd (nu -n --no-std-lib -c $env.FZF_ALT_C_COMMAND | fzf ...($env.FZF_ALT_C_OPTS | split row ' '))"
        }
      ]
    }
  ]
}
