class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  def create
    # if. 参加を押した場合
    if params[:key]=="value"
      group = Group.find(params[:group])
      @user_room = GroupUser.new
      @user_room.user_id=current_user.id

      @user_room.group_id = group.id
      @user_room.save
      redirect_to groups_path
    else
      group = Group.new(group_params)
      group.owner_id = current_user.id
      group.save
      @user_room = GroupUser.new
      @user_room.user_id=current_user.id
      @user_room.group_id = group.id
      @user_room.save
      redirect_to groups_path
    end
  end
  def destroy
    # グループを抜ける処理
    if params[:key]=="value"
      user_room = GroupUser.find_by(user_id: current_user.id,group_id: params[:id])
      user_room.destroy
      redirect_to groups_path
    else
    end
  end
  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end
  def index
    @groups = Group.all
    @book = Book.new
  end
  def edit
    @group = Group.find(params[:id])
  end
  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to groups_path
  end
  private
  def group_params
    params.require(:group).permit(:name,:introduction,:group_image)
  end
end
