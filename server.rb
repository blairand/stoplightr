%w(sinatra dino yaml json).each do |lib|
  require lib
end


board = Dino::Board.new(Dino::TxRx.new)
RED = Dino::Components::Led.new(pin: 4, board: board)
BLUE = Dino::Components::Led.new(pin: 2, board: board)
GREEN = Dino::Components::Led.new(pin: 3, board: board)
RED.off
BLUE.off
GREEN.off


get '/' do
  haml :index
end

get '/flash/all' do
  flash_all
  redirect '/'
end

get '/red' do
  go_red
  redirect '/'
end

get '/red/on' do
  RED.on
  redirect '/'
end

get '/red/off' do
  RED.off
  redirect '/'
end

get '/blue' do
  go_blue
  redirect '/'
end

get '/blue/flasher' do
  blue_flasher
  redirect '/'
end

get '/blue/on' do
  BLUE.on
  redirect '/'
end

get '/blue/off' do
  BLUE.off
  redirect '/'
end

get '/green' do
  go_green
  redirect '/'
end

get '/green/on' do
  GREEN.on
  redirect '/'
end

get '/green/off' do
  GREEN.off
  redirect '/'
end

get '/countdown' do
  countdown
  redirect '/'
end

get '/reset' do
  reset
  redirect '/'
end

get '/white' do
  go_white
  redirect '/'
end

get '/white/off' do
  all_off
  redirect '/'
end

get '/strobe' do
  strobe
  redirect '/'
end

get '/sos' do
  sos
  redirect '/'
end

def reset
  all_off
end

def strobe
  10.times do
    all_on
    sleep 0.1
    all_off
    sleep 0.1
  end
end

def blue_flasher
  [:on, :off].cycle(5) do |switch|
    BLUE.send(switch)
    sleep 1
  end
end

def go_white
  GREEN.on
  BLUE.on
  RED.on
end


def flash_all
  10.times do
    go_blue
    sleep 0.1
    reset
    go_red
    sleep 0.1
    reset
    go_white
    sleep 0.1
    reset
  end
end

def sos
  [:on, :off].cycle(3) do |switch|
    RED.send(switch)
    sleep 0.2
  end
  sleep 0.5
    [:on, :off].cycle(3) do |switch|
    RED.send(switch)
    sleep 0.5
  end
  sleep 0.5
    [:on, :off].cycle(3) do |switch|
    RED.send(switch)
    sleep 0.2
  end
end


def go_red
  RED.on
  BLUE.off
  GREEN.off
end

def go_blue
  BLUE.on
  GREEN.off
  RED.off
end

def go_green
  GREEN.on
  BLUE.off
  RED.off
end

def countdown
  RED.on
  BLUE.off
  GREEN.off
  sleep 1
  RED.off
  BLUE.on
  sleep 1
  BLUE.off
  GREEN.on
  sleep 1
  GREEN.off
end

def all_on
  GREEN.on
  BLUE.on
  RED.on
end

def all_off
  GREEN.off
  BLUE.off
  RED.off
end




