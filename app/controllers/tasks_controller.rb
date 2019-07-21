class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :destroy, :update]
  
  def index
    if logged_in?
      #@task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      # @tasks = Task.where(user_id: current_user.id)
      #@tasks = Task.all
    end
  end 
 
  def show
      #set_task
      # user = User.find_by(id: @task.user_id)
      # @task.userで、@taskのuser_idで検索されたUserクラスのインスタンスが返ってくる
      # 現在ログインしているユーザーは、current_userによって取得できる
      # 
      #@task.user
      #@task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    #@task = Task.new(task_params)
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    #set_task
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    #set_task
    @task.destroy
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end