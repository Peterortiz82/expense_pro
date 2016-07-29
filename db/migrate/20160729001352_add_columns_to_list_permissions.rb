class AddColumnsToListPermissions < ActiveRecord::Migration

  def up
    add_column :list_permissions, :permission_granted_to, :integer
    add_column :list_permissions, :permission_granted_by, :integer
    add_column :list_permissions, :read_access, :boolean, default: false
    add_column :list_permissions, :read_and_write_access, :boolean, default: false
  end

  def dowm
    remove_column :list_permissions, :permission_granted_to
    remove_column :list_permissions, :permission_granted_by
    remove_column :list_permissions, :read_access
    remove_column :list_permissions, :read_and_write_access
  end

end
