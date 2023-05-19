class TasksController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find_by(id: params[:id])
  end
  
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end
  
  def create
     @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクが作成されました" 
      redirect_to user_tasks_url(@user) 
    else
      render :new, locals: { user: @user }
    end
  end
  
  def edit
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
  
  def update
     @task = Task.find(params[:id])
     if @task.update_attributes(task_params)
       flash[:success] = "タスクの情報を更新しました。"
       redirect_to user_tasks_url
     else
       render :edit
     end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクが削除されました"
    redirect_to user_tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:name, :description)
  end
end
