class TweetsController < ApplicationController
		
	def index
		if session[:token].present?
			# get some tweets!!!!
			client = Twitter::REST::Client.new do |config|
				config.consumer_key        = "HONlQztX7Fs7bVfiv8GeqypNw"
				config.consumer_secret     = "ebHH3Ahedob3oGZjw61drt3UnrfYrQDIxEsucaugHeBa2px8OF"
				config.access_token        = session[:token]
				config.access_token_secret = session[:token_secret]
			end

			@tweets = client.home_timeline

		end 
	end



	def login 
		@response = request.env['omniauth.auth']
		session[:username] = @response[:info][:nickname]
		session[:token] = @response[:credentials][:token]
		session[:token_secret] = @response[:credentials][:secret]

		redirect_to "/"	
	end

	def logout
		reset_session
		redirect_to "/"
	end




end
