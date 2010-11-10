$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'eletro'
require 'rspec'
require 'rspec/autorun'

include Eletro
