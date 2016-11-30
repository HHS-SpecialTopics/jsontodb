module JSONtoDB
  # This module processes commands passed to the
  # command-line interface
  module Processor
    module_function

    def run_config
      check_auth

      unless JSONtoDB::CONFIG['Matrix'].nil?
        JSONtoDB::CONFIG['Matrix'].each do |hash|
          files = hash['Files']
          url = hash['Url']
          command = hash['Command']

          if files.nil?
            run_command([command, url], @user, @pass)
          elsif files.is_a?(Array)
            files.each do |file|
              Dir[file].each do |f|
                run_command([command, url, f], @user, @pass)
              end
            end
          else
            entries = Dir[files].entries.sort_by { |x| -x[/\d+/].to_i }
            entries.each do |f|
              run_command([command, url, f], @user, @pass)
            end
          end
        end
      end

      JSONtoDB::CLI.continuous_cli if JSONtoDB::CONFIG['Interactive']
    end

    def check_auth
      @user = JSONtoDB::CONFIG['User']
      @pass = JSONtoDB::CONFIG['Pass']
      return unless JSONtoDB::CONFIG['CredPrompt']
      JSONtoDB::CLI.authentication_credentials(@user, @pass)
      @user = JSONtoDB::CLI.user
      @pass = JSONtoDB::CLI.pass
    end

    def run_command(args, user, pass)
      return if args.empty?
      command = args.shift

      case command
      when 'get'
        return unless check_args('put', 1, args)
        res = JSONtoDB::REST.get(args[0], user, pass)
        puts res
      when 'delete'
        return unless check_args('put', 1, args)
        JSONtoDB::REST.delete(args[0], user, pass)
      when 'put'
        return unless check_args('put', 2, args)
        JSONtoDB::REST.put(args[0], args[1], user, pass)
      when 'post'
        return unless check_args('put', 2, args)
        JSONtoDB::REST.post(args[0], args[1], user, pass)
      else
        puts "Unknown command '#{command}'."
      end
    end

    def check_args(command, expected, actual)
      return true if actual.length == expected
      puts "ERROR: Command '#{command}' expected #{expected} parameter(s) but received #{actual.length}!"
      false
    end
  end
end
