# When establishing websocket connection, we dont have access to user sessions BUt
# we do have access to cookies.
# In order to be able to authenticate user, we need to do devise-related stuff:

# Creates a cookie with the user's ID upon successful sign in.
Warden::Manager.after_set_user do |user,auth,opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
end

# Removes the cookie when the user logs out
Warden::Manager.before_logout do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = nil
end
