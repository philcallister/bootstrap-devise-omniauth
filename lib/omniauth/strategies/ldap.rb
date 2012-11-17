## Monkeypatch for Omniauth LDAP Strategy

module OmniAuth
  module Strategies
    class LDAP
      alias_method :request_phase_original, :request_phase
      def request_phase
        #request_phase_original
        redirect '/users/auth/ldap/login'
      end
    end
  end
end


