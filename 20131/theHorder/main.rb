# -*- coding: utf-8 -*-
begin
  # In case we use Gosu via RubyGems
  require 'rubygems'
rescue LoadError
  # In case we don't...
end

RUBYTRIS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(RUBYTRIS_ROOT)


require 'gosu'

require 'window'
require 'zombie'
require 'human'
require 'alvo'
require 'skull'
require 'fort'

window = Window.new
window.show