module UsesOpenID
  module MacroMethods
    def uses_openid(options = {})
      extend(ClassMethods)
      include InstanceMethods
    end
  end

  module ClassMethods
    class OpenIDAuthenticationError < StandardError; end

    def self.extended(klass)
      # Set up the has_many association
      klass.class_eval %Q{
        @identity_url_class_name = '#{klass.name}IdentityURL'
        has_many :identity_urls, :class_name => @identity_url_class_name, :dependent => :delete_all
      }
    end

    def authenticate_with_openid(identity_url, user_args = {})
      # Try to find a user from the identity_url
      # If one cannot be found, use the email to find a user.
      # A user can have multiple identity urls. If an unrecognized one is given, it'll be associated with the user
      user_args.symbolize_keys!
      email = user_args[:email]

      if user = @identity_url_class_name.constantize.find_by_identity_url(identity_url).try(:user)
        # We've already got the identity URL saved
      elsif !email.nil? and user = self.where(user_args).first
        # Save the identity URL for next time
        user.identity_urls.build(:identity_url => identity_url) unless user.identity_urls.where(:identity_url => identity_url).exists?
        user.save(:validate => false) # Don't need to do user validation here
      else
        # We don't have an account for this OpenID
        user = nil
      end

      user
    end
  end

  module InstanceMethods
    def openid_user?
      password.nil? and !identity_urls.empty?
    end
  end
end
