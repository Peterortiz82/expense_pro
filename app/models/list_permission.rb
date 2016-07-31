class ListPermission < ActiveRecord::Base

  belongs_to :list
  belongs_to :user, foreign_key: :permission_granted_to

end
