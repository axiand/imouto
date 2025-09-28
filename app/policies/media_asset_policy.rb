# frozen_string_literal: true

class MediaAssetPolicy < ApplicationPolicy
  def index?
    user.is_member?
  end

  def show?
    user.is_member?
  def

  def destroy?
    user.is_admin?
  end

  def image?
    can_see_image?
  end

  def can_see_image?
    !record.removed? && (record.post.blank? || record.post.visible?(user))
  end

  def rate_limit_for_image(**_options)
    { rate: 5.0 / 1.second, burst: 50 }
  end

  def api_attributes
    attributes = super + [:variants]
    attributes -= [:md5, :file_key, :variants] if !can_see_image?
    attributes
  end
end
