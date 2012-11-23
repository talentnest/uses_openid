require "uses_openid/version"
require "uses_openid/active_record"

module UsesOpenid
  class Railtie < Rails::Railtie
    initializer 'uses_openid.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :extend, UsesOpenID::MacroMethods
      end
    end
  end
end
