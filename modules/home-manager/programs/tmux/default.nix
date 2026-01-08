{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    historyLimit = 10000;
    keyMode = "vi";
    baseIndex = 1;
    mouse = true;
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];

    extraConfig = ''
      # Terminal overrides for RGB colors
      # set -g terminal-overrides ",xterm-256color:RGB"

      # UI Style
      set -g status-position top
      set -g status-left "#[fg=blue,bold]#S "
      set -g status-left-length 200
      set -g status-right ""
      set -g status-style 'bg=default'
      
      set -g window-status-current-format '👉 #[fg=magenta]#W'
      set -g window-status-format ' #[fg=gray]#W'

      set -g message-command-style bg=default,fg=yellow
      set -g message-style bg=default,fg=yellow
      set -g mode-style bg=default,fg=yellow
      set -g pane-active-border-style 'fg=magenta,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'

      # Behavior
      set -g set-clipboard on
      set -g renumber-windows on
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      # Keybinds
      unbind r
      bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"
      bind : command-prompt
      bind S choose-session

      # Vim-like Copy Mode
      set-window-option -g xterm-keys on
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi Enter send-keys -X copy-selection-and-cancel

      # Panes
      set -g pane-base-index 1
      bind s split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind -r m resize-pane -Z
      bind-key x kill-pane
      
      bind h resize-pane -L 5
      bind j resize-pane -D 5
      bind k resize-pane -U 5
      bind l resize-pane -R 5

      # Windows
      bind c new-window -c '#{pane_current_path}'
      bind -N "⌘+g lazygit " g new-window -c "#{pane_current_path}" -n "🌳" "lazygit 2> /dev/null"
      bind -N "⌘+y yazi" y new-window -c "#{pane_current_path}" -n "📂" "yazi"
      
      bind-key & kill-window
      bind C-b last-window
      bind C-n next-window
      bind C-p previous-window
      bind w list-windows
      bind r command-prompt "rename-window %%"

      # Plugins
      # set -g @plugin 'christoomey/vim-tmux-navigator'
    '';
  };
}
