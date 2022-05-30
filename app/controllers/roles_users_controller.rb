class RolesUsersController < WulinMaster::ScreenController
  before_action :require_admin

  controller_for_screen MasterUserDetailRoleScreen

  add_callback :query_ready, :set_user_id_condition
  add_callback :query_ready, :set_role_id_condition
  add_callback :query_ready, :preload_relations
  add_callback :objects_ready, :assign_email

  protected

  def preload_relations
    @query = @query.includes(:role)
  end

  def assign_email
    if params[:screen] == "MasterRoleDetailUserScreen" && params[:grid] == "RolesUserGrid"
      # do nothing
    else
      return
    end

    users = User.find_by_ids @objects.map(&:user_id).compact

    email_dict = users.each_with_object({}) do |user, target|
      target[user.id] = user.email
    end

    @objects.each do |user_role|
      user_role.email = email_dict[user_role.user_id]
    end

    set_email_condition
    set_email_sorting
  end

  def set_email_sorting
    sort_col, sort_dir = params.values_at :sort_col, :sort_dir
    return if sort_col.blank?

    if sort_col == "email"
      case sort_dir
      when /asc/i
        @objects.sort! { |a, b|
          if a.email && b.email
            a.email <=> b.email
          else
            a.email ? -1 : 1
          end
        }
      when /desc/i
        @objects.sort! { |a, b|
          if a.email && b.email
            b.email <=> a.email
          else
            a.email ? -1 : 1
          end
        }
      end
    end
  end

  def set_email_condition
    email_filter_params = params[:filters].find { |x| x.value?("email") }
    return if email_filter_params.blank?

    @count_without_filter = @objects.size
    @objects.select! do |user_role|
      user_role.email.to_s =~ /#{email_filter_params[:value]}/i
    end
    @count = @objects.size
  end

  def set_user_id_condition
    return if params[:filters].blank?

    user_filter_params = params[:filters].find { |x| x.value?("user_id") }
    return if user_filter_params.blank?

    @query = grid.model.where(user_id: user_filter_params[:value])
  end

  def set_role_id_condition
    return if params[:filters].blank?

    role_filter_params = params[:filters].find { |x| x.value?("role_id") }
    return if role_filter_params.blank?
    @query = grid.model.where(role_id: role_filter_params[:value])
  end
end
