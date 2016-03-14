require 'logging'

logger = Logging.logger.root
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
  logger.level = :debug
  logger.appenders = Logging.appenders.stdout(:layout => layout)

elsif ENV['RACK_ENV'] == 'test'
  logger = Logging.logger.root
  logger.level = :debug
  file_appender = Logging.appenders.rolling_file('logs/riobamba.test.log', 
                                                 :size => 1024*1024*1024*10,
                                                 :keep => 10,
                                                 :layout => layout,
                                                 :level => :debug )
  logger.appenders = [ Logging.appenders.stdout(:layout => layout), file_appender ]

elsif ENV['RACK_ENV'] == 'production'
  logger = Logging.logger.root
  file_appender = Logging.appenders.rolling_file('logs/riobamba.log', 
                                                 :age => 'weekly', 
                                                 :level => :info,
                                                 :layout => layout )
  logger.appenders [  Logging.appenders.stdout(:level => :error, :layout => layout),  file_appender ]
else
  logger.level = :info
  logger.appenders = Logging.appenders.stdout(:layout => layout)
end

logger.info {"Starting up in :#{ENV['RACK_ENV'] || 'No RACK_ENV set'} mode"}