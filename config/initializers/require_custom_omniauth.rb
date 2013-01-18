# ***** IS_TAG *****

## 
# Require our custom Omniauth LDAP Strategy here.  Since we
# reopen a module/class, the autoloader isn't working and we're
# forced to load our module like this
Dir[Rails.root + 'lib/omniauth/**/*.rb'].each do |file|
  require file
end