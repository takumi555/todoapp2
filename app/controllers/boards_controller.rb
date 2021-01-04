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

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end
end