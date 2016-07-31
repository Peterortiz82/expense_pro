class ListPermissionsController < ApplicationController
  before_action :set_list

  def index
    @list_permission = ListPermission.new
    @invited_users = User.where.not(invitation_accepted_at: nil).where(invited_by_id: current_user.id)
    @list_permissions = @list.list_permissions
  end

  def create
    @list_permission = ListPermission.new permission_params
    @list_permission.list_id = @list.id
    @list_permission.permission_granted_to = params[:invited_user_id].to_i
    @list_permission.permission_granted_by = current_user.id
    if @list_permission.save
      redirect_to list_list_permissions_path(@list)
    else
      render :index
    end
  end

  def destroy
    @list_permission = ListPermission.find params[:id]
    @list_permission.destroy
    redirect_to list_list_permissions_path(@list)
  end

private

  def set_list
    @list = List.find params[:list_id]
  end

  def permission_params
    params.require(:list_permission).permit :read_access, :read_and_write_access
  end

end