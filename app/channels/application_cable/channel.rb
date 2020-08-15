module ApplicationCable
  class Channel < ActionCable::Channel::Base
  end

  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    # connection identifier used to find specific connection later.
    # Note: Anything marked as an identifier will automatically create a delegate by the same 
    #       name on any channel instances created off the connection.

    def connect
      self.current_user = find_verified_user
    end

    private

    # Accesses the cookie that we set in the warden hook (config/initializers/warden_hooks.rb)
    def find_verified_user
      if (verified_user = User.find_by(id: cookies.signed['user.id']))
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
