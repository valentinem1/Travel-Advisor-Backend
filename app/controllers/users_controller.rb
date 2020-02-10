class UsersController < ApplicationController

    def index
        @users = User.all

        render json: @users
    end

    def show
        @user = User.find(params[:id])

        render json: @user
    end

    ##Register
    def create
       @user = User.create(user_params)

        if @user.valid?
            token_tag = encode_token({user_id: @user.id})
            render json: {user: UserSerializer.new(@user), token: token_tag}, status: 201
        else
            render json: {error: "Invalid username or password"}
        end
    end

  # LOGGING IN
  ## if the user exists in the db, then send them their token
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token_tag = encode_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), token: token_tag}
      # render json: @user, include: "**"
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def persist
    token_tag = encode_token({user_id: @user.id})
    render json: {user: UserSerializer.new(@user), token: token_tag}
  end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)

        render json: @user
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy

        render json: {message: "User has been deleted", user: @user}
    end

    private

    def user_params
        params.permit(:username, :picture, :bio, :password)
    end

end