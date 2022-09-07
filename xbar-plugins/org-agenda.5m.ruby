#!/usr/bin/env ruby
# coding: utf-8

# <xbar.title>Agenda</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>yqrashawn</xbar.author>
# <xbar.author.github>yqrashawn</xbar.author.github>
# <xbar.desc>display emacs org-agenda in bitbar</xbar.desc>
# <xbar.image>https://github.com/yqrashawn/bitbar-plugin-agenda/raw/master/bitbar-ext-org-agenda.png</xbar.image>
# <xbar.dependencies>ruby,emacs</xbar.dependencies>
# <xbar.abouturl>http://yqrashawn.com/2017/11/25/org-agenda-bitbar-plugin/</xbar.abouturl>

# for more information please checkout http://yqrashawn.com/2017/11/25/org-agenda-bitbar-plugin/
# it's on github https://github.com/yqrashawn/bitbar-plugin-agenda

require 'open3'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# your exported agenda files directory path eg. "#{Dir.home}/agendas/work/"
agenda_directory = '/Users/victorvialard/agendas/'

# the exported txt agenda file that in the agenda_directory eg. 'todos.txt'
agenda_name = 'todos.txt'

# the agenda custome command which brings the agenda view that you want to export
agenda_custom_command = 'z'

# function to REALLY kill emacs
# for spacemacs use (spacemacs/kill-emacs)
kill_emacs_function = '(let (kill-emacs-hook) (kill-emacs))'

# Change priority color here
tag_color = 'orange'

# Customise label color-code here (these colors are optimised for a dark theme menubar)
labels = {
  'NEXT' => 'red',
  'TODO [#A]' => 'violet'
}

tag_indicator = 'Headlines with TAGS match: '

# close stdout stderr
system 'PATH=/opt/homebrew/bin/:$PATH ',
       '&&',
       'emacsclient',
       '-e',
       "(progn (org-batch-agenda \"#{agenda_custom_command}\") (org-agenda-write \"#{agenda_directory}#{agenda_name}\") (kill-buffer))",
       '2>/dev/null',
       :out => :close,
       :err => :close

agenda_file = File.open("#{agenda_directory}#{agenda_name}")

lines = IO.readlines(agenda_file)

# remove empty line
lines.reject! { |s| s.nil? || s.strip.empty? }
lines.reject! { |s| s.include?('=====') }
lines.each.with_index do |line, i|
  # get url for urls [[https://example.com][example]]
  url = ''
  if line.include?('[[http')
    url = line.slice(/\[\[((http?|ftp).*\]\[)/)
    lines[i] = line.sub(url, '')
    lines[i] = lines[i].sub ']]', ''
    line = lines[i]
    url = url.slice(2, url.length - 4)
  end

  # detect tag line
  if line.include?(tag_indicator)
    lines[i] = "#{line.slice(tag_indicator.length, line.length).delete("\n")} | color=#{tag_color} font=Hack"
  else
    # get color dpends on priority
    line_color = ''
    labels.each { |label, label_color| line_color = label_color if line.include?(label) }
    line_color = 'white' if line_color.strip.empty?

    # remove TODO, add color, special font for clickable one
    lines[i] = "#{line.delete("\n").squeeze(' ')}|color=#{line_color}"
  end
end

puts "🚀 TODOs: #{lines.length}"
puts '---'
puts lines
