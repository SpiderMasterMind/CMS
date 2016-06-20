require "sinatra"
require "sinatra/reloader"
require "sinatra/base"
require "pry"
require "tilt/erubis"

configure do
  enable :sessions
  set :sessions_secret, 'secret'
  set :erb, :escape_html => true
end

rootpath = File.expand_path("..", __FILE__)

get "/" do
  @files = Dir.glob(rootpath + "/data/*").map do |path|
    File.basename(path)
  end
  erb :index, layout: :index
end

get "/:filename" do
  filepath = rootpath + "/data/" + params[:filename]

  if File.exist?(filepath)
    headers["Content-Type"] = "text/plain"
    File.read(filepath)
  else
    session[:message] = "#{params[:filename]} does not exist"
    redirect "/"
  end
end