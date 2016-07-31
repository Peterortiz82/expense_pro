module ListPermissionsHelper

  def permissions_have_not_been_granted(list, invited_user)
    granted_permissions = list.list_permissions.select do |permission|
      permission.permission_granted_to == invited_user.id
    end

    granted_permissions.count < 1
  end

end