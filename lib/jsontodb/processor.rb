module JSONtoDB
  # This module processes
  # commands passed to the
  # command-line interface
  module Processor
    module_function

    def run_command(args, user, pass)
      return if args.empty?
      command = args.shift

      case command
      when 'get'
        res = JSONtoDB::REST.get(args[0], user, pass)
        puts res
      when 'delete'
        JSONtoDB::REST.delete(args[0], user, pass)
      when 'put'
        JSONtoDB::REST.put(args[0], user, pass)
      when 'post'
        JSONtoDB::REST.post(args[0], user, pass)
      else
        puts "Unknown command '#{command}'."
      end
    end
  end
end
