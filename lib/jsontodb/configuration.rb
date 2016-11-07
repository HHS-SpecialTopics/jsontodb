module JSONtoDB
  # This module holds the configuration data for JSONtoDB
  module Configuration
    module_function

    def load
    end

    def [](key)
      config_as_hash[key] || nil
    end

    def []=(key)
      config_as_hash[key] || nil
    end

    private

    def config_as_hash
      @hash ||= {}
    end
  end
end
