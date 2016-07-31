class ListPermission < ActiveRecord::Base

  belongs_to :list
  belongs_to :user, foreign_key: :permission_granted_to

  # validate :access_cannot_be_blank


private

  def access_cannot_be_blank
    if !read_access && !read_and_write_access
      errors.add(:category_id, "You must assign an access type")
    end
  end

end
