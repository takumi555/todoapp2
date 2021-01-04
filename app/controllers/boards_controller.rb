class BoardsController < ApplicationController
  
  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save!
      redirect_to boards_path, notice: '登録できました'
    else
      flash.now[:error] = '登録できませんでした'
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to boards_path, notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end

  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy!
    redirect_to boards_path, notice: '削除しました'
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end

 
end