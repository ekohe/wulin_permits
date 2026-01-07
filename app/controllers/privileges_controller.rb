# frozen_string_literal: true

class PrivilegesController < WulinMaster::ScreenController
  controller_for_screen PrivilegeScreen

  add_callback :query_ready, :filter_for_user

  private

  def filter_for_user
    user_filter_params = params[:filters].to_a.find { |x| x.values.include?("user_id") and x.values.include?("exclude") }
    return if user_filter_params.blank?

    privilege_ids = UsersPrivilege.where(user_id: user_filter_params[:value]).pluck(:privilege_id).uniq

    if privilege_ids.present?
      @query = @query.where.not(id: privilege_ids)
    end
  end
end
