class UsersController < ApplicationController
  
  def index
    @users = User.all.reverse
  end

  def show
    current_user
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).reverse
    @tags = Tag.all
  end

  def create
    @user = User.new(user_params)
    @user.save
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "Welcome aboard, blog-friend!"
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to posts_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :firstname, :lastname, :age)
  end

end
