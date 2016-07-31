module ListPermissionsHelper

  def permissions_have_not_been_granted_to_user(list, invited_user)
    granted_permissions = list.list_permissions.select do |permission|
      permission.permission_granted_to == invited_user.id
    end

    granted_permissions.count < 1
  end

  def list_has_users_without_permissions(list, invited_users)
    permissions = []

    invited_users.each do |user|
      list.list_permissions.select do |permission|
        permissions << permission.permission_granted_to == user.id
      end
    end

    invited_users.count > permissions.count
  end

end