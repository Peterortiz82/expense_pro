class SharedListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @shared_lists = shared_lists.paginate(page: params[:page], per_page: 15)
  end

private

  def permissions_granted_for_current_user
    ListPermission.where(permission_granted_to: current_user.id)
  end

  def shared_lists
    lists = []

    permissions_granted_for_current_user.each do |permissions|
      list = permissions.list
      lists << list
    end

    lists
  end

end