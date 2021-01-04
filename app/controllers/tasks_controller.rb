class TasksController < ApplicationController 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def show
    
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
  end

  def update
  end
  
  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end