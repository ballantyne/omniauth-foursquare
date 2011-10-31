# lots of stuff taken from https://github.com/intridea/omniauth/blob/0-3-stable/oa-oauth/lib/omniauth/strategies/oauth2/foursquare.rb

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Foursquare < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :authorize_url => authorize_url(options),
        :token_url => 'https://foursquare.com/oauth2/access_token',
      }
      def request_phase
        options[:response_type] ||= 'code'
        super
      end
      
      def authorize_url(options)
        "https://foursquare.com/#{'mobile/' if options[:mobile]}oauth2/#{options[:sign_in] ? 'authenticate' : 'authorize'}"
      end

      def callback_phase
        options[:grant_type] ||= 'authorization_code'
        super
      end
      
      uid { raw_info['uid'] }

      info do
        {
          'nickname' => raw_info['response']['user']['contact']['twitter'],
          'first_name' => raw_info['response']['user']['firstName'],
          'last_name' => raw_info['response']['user']['lastName'],
          'email' => raw_info['response']['user']['contact']['email'],
          'name' => "#{raw_info['response']['user']['firstName']} #{user_data['response']['user']['lastName']}".strip,
          'image' => raw_info['response']['user']['photo'],
          'phone' => raw_info['response']['user']['contact']['phone']
        }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('https://api.foursquare.com/v2/users/self', { :params => { 'oauth_token' => @access_token.token } }).body)
        puts @raw_info.inspect
        @raw_info
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end