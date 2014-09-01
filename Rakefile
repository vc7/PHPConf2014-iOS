task :default => :setup

desc 'Setup project with example files.'
task :setup do
	# Copying the defines files
	puts 'Copying the example PCDefines into place...'.cyan 
	`cp PHPConf2014/PCDefinesExample.h PHPConf2014/PCDefines.h`
	`cp PHPConf2014/PCDefinesExample.m PHPConf2014/PCDefines.m`

	# Done
  puts 'Done! You\'re ready to go!'.green
end

class String
  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def cyan
    self.class.colorize(self, 36)
  end

  def green
    self.class.colorize(self, 32)
  end
end
