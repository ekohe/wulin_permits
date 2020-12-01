# frozen_string_literal: true

class RolesController < WulinMaster::ScreenController
  controller_for_screen RoleScreen

  add_callback :query_ready, :filter_for_user
  add_callback :query_ready, :filter_role

  private

  def filter_role
    filter = params[:filters].to_a.find { |x| x.value?("name") }
    return if filter.blank? || filter[:value].blank?

    @query ||= grid.model

    case filter[:operator]
    when "equals"
      @query = @query.where("name ~* ?", filter[:value])
    when "exclude"
      @query = @query.where("name <> ?", filter[:value])
    end
  end

  def filter_for_user
    filter = params[:filters].to_a.find { |x| x.value?("user_id") && x.value?("exclude") }
    return if filter.blank?

    role_ids = RolesUser.where(user_id: filter[:value]).pluck(:role_id).uniq

    @query = grid.model
    @query = grid.model.where("id NOT IN (?)", role_ids) if role_ids.present?
  end
end
