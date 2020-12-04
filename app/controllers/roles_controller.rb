# frozen_string_literal: true

class RolesController < WulinMaster::ScreenController
  controller_for_screen RoleScreen

  #
  # DON'T change this order!
  #
  add_callback :query_ready, :filter_role
  add_callback :query_ready, :filter_for_user

  private

  def filter_role
    filter = params[:filters].to_a.find { |x| x.value?("name") }
    return if filter.blank? || filter[:value].blank?

    #
    # Override the
    #
    # - query.where(["UPPER(cast((#{column_name}) as text)) LIKE UPPER(?)", value + "%"])
    # - query.where(["UPPER(cast(#{relation_table_name}.#{source} as text)) #{operator} UPPER(?)", value + "%"])
    #
    where_clauses = @query.where_clause.send :predicates
    if where_clauses.size == 1 && where_clauses.first =~ /name/i
      @query = @query.unscope(:where)
    end

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

    @query = @query.where("id NOT IN (?)", role_ids) if role_ids.present?
  end
end
