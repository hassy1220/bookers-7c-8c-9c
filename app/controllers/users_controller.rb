class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    # to=Time.current
    # from=(to - 6.day)
    # created_at: Time.current-1.day...Time.current
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # 今日投稿した数
    @today_books = @user.books.where(created_at: Time.zone.now.all_day)
    # 昨日投稿した数
    @yesterday_books = @user.books.where(created_at: Time.zone.now.yesterday.all_day)
    if  @today_books.count == 0 || @yesterday_books.count == 0
      @ratio="比較不可"
    else
      @ratio = (@today_books.count.to_f / @yesterday_books.count.to_f)*100
    end
    # 今週投稿した数
    @week = @user.books.where(created_at: Time.current.ago(1.week)...Time.current)
    # 先週投稿した数
    @week_second = @user.books.where(created_at: Time.current.ago(2.week)...Time.current.ago(1.week))
    if @week.count == 0 || @week_second.count == 0
      @week_ratio = "比較不可"
    else
      @week_ratio = @week.count.to_f / @week_second.count.to_f
    end
    number = params[:created_at]

    if number.present?
      @sort = @user.books.where(created_at: number.in_time_zone.all_day)
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
