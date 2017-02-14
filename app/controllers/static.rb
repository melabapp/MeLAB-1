get '/' do
  erb :"static/homepage"
end

get '/login' do
  erb :"static/login"
end

get '/signup' do
	erb :"static/signup"
end

post '/signup' do
	    if params[:password] == params[:password2]
		      user = User.new(:name=>params[:username],:email=>params[:email],:password=>params[:password])
			       if user.valid?
	    	 	         if user.save
	    			           @welcome = "Your Account has been created successfully!!!"
					             erb :"static/login"
    			        else
    				           @error3 = "your email is not valid!!!"
    				           erb :"static/signup"
       	 		       end
       	 	   else 
       	 		       @error4 = user.errors.messages
       	 		       erb :"static/signup"
       	 	   end
       else 
       	  @error2 = "Password does not match!!!"
       	  erb :"static/signup"
       end
end


post '/login' do
	user = User.find_by(:name=>params[:username])
	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
	    redirect 'questions'
    else
    	@error = "Invalid username or password!!!"
    	erb :"static/login"
	end
end

get '/signout' do
	session[:user_id] = nil 
	redirect '/'
end

