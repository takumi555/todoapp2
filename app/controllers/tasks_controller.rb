class TasksController < ApplicationController 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def show
    @task = Task.find(params[:id])
    
  end

  def new
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build(user_id: current_user.id)
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params.merge!(user_id: current_user.id))
    if @task.save!
      redirect_to board_path(board), notice: '登録できました'
    else
      flash.now[:error] = '登録できませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(board_id: @task.board.id, id: @task.id), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy!
      redirect_to  board_path(id: @task.board_id), notice: '削除しました'

  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :image)
  end
end