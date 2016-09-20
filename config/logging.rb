require 'logging'
require 'fileutils'

root = Logging.logger.root
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

FileUtils::mkdir_p 'logs/'

if ENV['RACK_ENV'] == 'development'
  root.level = :debug
  root.appenders = Logging.appenders.stdout(:layout => layout)

elsif ENV['RACK_ENV'] == 'test'
  root.level = :debug
  file_appender = Logging.appenders.rolling_file('logs/riobamba.test.log', 
                                                 :size => 1024*1024*1024*10,
                                                 :keep => 10,
                                                 :layout => layout,
                                                 :level => :debug )
  root.appenders = [ Logging.appenders.stdout(:layout => layout), file_appender ]

elsif ENV['RACK_ENV'] == 'production'
  file_appender = Logging.appenders.rolling_file('logs/riobamba.log', 
                                                 :age => 'weekly', 
                                                 :level => :info,
                                                 :layout => layout )
  root.appenders [  Logging.appenders.stdout(:level => :error, :layout => layout),  file_appender ]
else
  root.level = :info
  root.appenders = Logging.appenders.stdout(:layout => layout)
end