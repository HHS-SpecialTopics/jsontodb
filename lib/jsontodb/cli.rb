require 'io/console'
require 'base64'

module JSONtoDB
  # This module handles the
  # command-line interface for
  # JSONtoDB
  module CLI
    module_function

    def run
      if !ARGV.empty?
        if ARGV.length >= 2
          authentication_credentials(ARGV.shift, ARGV.shift)
          if ARGV.empty?
            continuous_cli
          else
            JSONtoDB::Processor.run_command(ARGV, @user, @pass)
          end
        end
      else
        authentication_credentials
        continuous_cli
      end
    end

    def authentication_credentials(user = nil, pass = nil)
      if user.nil? || pass.nil?
        puts 'USER AUTHENTICATION'
        puts '==================='
        puts
        print 'Username: '
        @user = STDIN.gets.chomp
        print 'Password: '
        @pass = STDIN.noecho(&:gets).chomp
        puts ''
      else
        @user = user
        @pass = pass
      end
    end

    def continuous_cli
      print 'jsontodb> '
      input = STDIN.gets.chomp
      while input != 'exit'
        JSONtoDB::Processor.run_command(tokenize_command(input), @user, @pass)
        print 'jsontodb> '
        input = STDIN.gets.chomp
      end
    end

    def tokenize_command(input)
      input.split(/\s(?=(?:[^'"]|'[^']*'|"[^"]*")*$)/)
           .select { |s| !s.empty? }
           .map { |s| s.gsub(/(^ +)|( +$)|(^["']+)|(["']+$)/, '') }
    end
  end
end
