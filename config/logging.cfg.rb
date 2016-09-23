require 'logging'
require 'path_builder'

root = Logging.logger.root
path = ENV['LOG_FOLDER'] 
path ||= LoadPath::PathBuilder.new(File.dirname(__FILE__)).sibling_directory('logs').to_s

color_scheme = Logging.color_scheme( 'bright',
    :levels => {
      :info  => :green,
      :warn  => :yellow,
      :error => :red,
      :fatal => [:white, :on_red]
    },
    :date => :blue,
    :logger => :cyan,
    :message => :magenta
)
layout = Logging.layouts.pattern(
  :pattern => "%d %-5l [%c]: %m\n",
  :color => color_scheme
)

if ENV['RACK_ENV'] == 'development'
  puts "HEAJ"
  root.level = :debug
  file_appender = Logging.appenders.rolling_file(path + '/riobamba.development.log', 
                                                 :size => 1024*1024*1024,
                                                 :keep => 1,
                                                 :layout => layout )
  root.appenders = [ Logging.appenders.stdout(:layout => layout), file_appender ]

elsif ENV['RACK_ENV'] == 'test'
  root.level = :info
  file_appender = Logging.appenders.rolling_file(path + '/riobamba.test.log', 
                                                 :size => 1024*1024*1024,
                                                 :keep => 1,
                                                 :layout => layout,
                                                 :level => :debug )
  root.appenders = [ Logging.appenders.stdout(:layout => layout), file_appender ]

elsif ENV['RACK_ENV'] == 'production'
  file_appender = Logging.appenders.rolling_file(path + 'riobamba.log', 
                                                 :age => 'weekly', 
                                                 :level => :info,
                                                 :layout => layout )
  root.appenders [  Logging.appenders.stdout(:level => :error, :layout => layout),  file_appender ]
else
  root.level = :info
  root.appenders = Logging.appenders.stdout(:layout => layout)
end

root.info "Logging initialized"