class TasksController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
  
  def show
  end
  
  def new
    @Task = Task.new
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
end
